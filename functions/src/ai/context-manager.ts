import { Request, Response } from 'express';
import * as admin from 'firebase-admin';
import { logEvent, logError } from '../utils/logging';

const MAX_CONTEXT_LENGTH = 4000; // символов

export async function manageAIContext(req: Request, res: Response) {
  try {
    const userId = (req as any).userId;
    const { context, sessionId } = req.body;
    if (!context || typeof context !== 'string' || !sessionId) {
      return res.status(400).json({ error: 'Invalid context or sessionId' });
    }
    // Ограничение размера контекста
    let trimmedContext = context;
    if (context.length > MAX_CONTEXT_LENGTH) {
      trimmedContext = context.slice(-MAX_CONTEXT_LENGTH);
    }
    // Сохраняем контекст в Firestore
    await admin.firestore()
      .collection('chats')
      .doc(userId)
      .collection('sessions')
      .doc(sessionId)
      .set({ context: trimmedContext, updatedAt: admin.firestore.FieldValue.serverTimestamp() }, { merge: true });
    logEvent('CONTEXT_UPDATE', { userId, sessionId });
    res.json({ status: 'ok', context: trimmedContext });
  } catch (error) {
    logError(error);
    res.status(500).json({ error: 'Failed to update context', details: error?.message || error });
  }
}
