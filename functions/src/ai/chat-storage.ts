import { Router, Request, Response } from 'express';
import * as admin from 'firebase-admin';
import { logEvent, logError } from '../utils/logging';

export const chatStorageRouter = Router();

// Сохранить сообщение в истории
chatStorageRouter.post('/save', async (req: Request, res: Response) => {
  try {
    const userId = (req as any).userId;
    const { sessionId, message, role } = req.body;
    if (!sessionId || !message || !role) {
      return res.status(400).json({ error: 'Invalid sessionId, message or role' });
    }
    await admin.firestore()
      .collection('chats')
      .doc(userId)
      .collection('sessions')
      .doc(sessionId)
      .collection('messages')
      .add({ message, role, createdAt: admin.firestore.FieldValue.serverTimestamp() });
    logEvent('CHAT_SAVE', { userId, sessionId, role });
    res.json({ status: 'ok' });
  } catch (error) {
    logError(error);
    res.status(500).json({ error: 'Failed to save message', details: error?.message || error });
  }
});

// Получить историю сообщений
chatStorageRouter.get('/history', async (req: Request, res: Response) => {
  try {
    const userId = (req as any).userId;
    const { sessionId, limit = 50 } = req.query;
    if (!sessionId) {
      return res.status(400).json({ error: 'Invalid sessionId' });
    }
    const snap = await admin.firestore()
      .collection('chats')
      .doc(userId)
      .collection('sessions')
      .doc(sessionId as string)
      .collection('messages')
      .orderBy('createdAt', 'desc')
      .limit(Number(limit))
      .get();
    const messages = snap.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    res.json({ messages });
  } catch (error) {
    logError(error);
    res.status(500).json({ error: 'Failed to get history', details: error?.message || error });
  }
});

// Очистить историю сообщений
chatStorageRouter.delete('/clear', async (req: Request, res: Response) => {
  try {
    const userId = (req as any).userId;
    const { sessionId } = req.body;
    if (!sessionId) {
      return res.status(400).json({ error: 'Invalid sessionId' });
    }
    const messagesRef = admin.firestore()
      .collection('chats')
      .doc(userId)
      .collection('sessions')
      .doc(sessionId)
      .collection('messages');
    const snap = await messagesRef.get();
    const batch = admin.firestore().batch();
    snap.docs.forEach(doc => batch.delete(doc.ref));
    await batch.commit();
    logEvent('CHAT_CLEAR', { userId, sessionId });
    res.json({ status: 'ok' });
  } catch (error) {
    logError(error);
    res.status(500).json({ error: 'Failed to clear history', details: error?.message || error });
  }
});
