import { Request, Response, NextFunction } from 'express';
import { logError } from './logging';

export function errorHandler(err: any, _req: Request, res: Response, _next: NextFunction) {
  logError(err);
  res.status(500).json({ error: 'Internal server error', details: err?.message || err });
}
