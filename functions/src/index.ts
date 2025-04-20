import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';

import { generateAIResponse } from './ai/generate-response';
import { manageAIContext } from './ai/context-manager';
import { chatStorageRouter } from './ai/chat-storage';
import { authMiddleware } from './middleware/auth';
import { rateLimitMiddleware } from './middleware/rate-limit';
import { errorHandler } from './utils/error-handler';

// Инициализация переменных окружения
dotenv.config();

// Инициализация Firebase Admin
admin.initializeApp();

const app = express();

// Настройка CORS
app.use(cors({ origin: true }));

// Middleware для авторизации и rate limiting
app.use(authMiddleware);
app.use(rateLimitMiddleware);

// Основные маршруты
app.post('/ai/generate', generateAIResponse);
app.post('/ai/context', manageAIContext);
app.use('/ai/chat', chatStorageRouter);

// Глобальный обработчик ошибок
app.use(errorHandler);

// Экспорт Cloud Function
export const api = functions.https.onRequest(app);
