# Firebase Cloud Functions для Gemini API (BizLevel)

## Структура
- `src/index.ts` — точка входа, маршрутизация
- `src/ai/generate-response.ts` — прокси к Gemini API
- `src/ai/context-manager.ts` — управление контекстом диалога
- `src/ai/chat-storage.ts` — история диалогов
- `src/middleware/auth.ts` — авторизация (Firebase Auth)
- `src/middleware/rate-limit.ts` — ограничение частоты запросов
- `src/utils/error-handler.ts` — обработка ошибок
- `src/utils/logging.ts` — логирование

## Запуск локально
1. Установить зависимости: `npm install`
2. Заполнить `.env` (GEMINI_API_KEY)
3. Запустить эмулятор: `npm run serve`

## Деплой
`npm run deploy`

## Переменные окружения
- `GEMINI_API_KEY` — ключ доступа к Gemini API (Google AI)

## Требования
- Node.js 18+
- Firebase CLI
- Аккаунт Firebase с настроенным проектом 