import { Request, Response } from 'express';
import axios from 'axios';
import { logEvent, logError } from '../utils/logging';

export async function generateAIResponse(req: Request, res: Response) {
  try {
    const userId = (req as any).userId;
    const { prompt, context } = req.body;
    if (!prompt || typeof prompt !== 'string') {
      return res.status(400).json({ error: 'Invalid prompt' });
    }
    // Можно добавить доп. валидацию context
    logEvent('AI_REQUEST', { userId, prompt });

    const apiKey = process.env.GEMINI_API_KEY;
    if (!apiKey) {
      throw new Error('Gemini API key not configured');
    }

    // Прокси-запрос к Gemini API
    const geminiRes = await axios.post(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent',
      {
        contents: [
          { role: 'user', parts: [{ text: prompt }] },
          ...(context ? [{ role: 'system', parts: [{ text: context }] }] : [])
        ]
      },
      {
        params: { key: apiKey },
        headers: { 'Content-Type': 'application/json' }
      }
    );

    const aiResponse = geminiRes.data;
    logEvent('AI_RESPONSE', { userId, aiResponse });
    res.json(aiResponse);
  } catch (error) {
    logError(error);
    res.status(500).json({ error: 'Failed to generate AI response', details: error?.message || error });
  }
}
