import rateLimit from 'express-rate-limit';
import { Request } from 'express';

export const rateLimitMiddleware = rateLimit({
  windowMs: 60 * 1000, // 1 минута
  max: 20, // максимум 20 запросов в минуту на пользователя
  keyGenerator: (req: Request) => (req as any).userId || req.ip,
  handler: (_req, res) => {
    res.status(429).json({ error: 'Too many requests, please try again later.' });
  },
});
