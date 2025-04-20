export function logError(error: any) {
  // Можно интегрировать с внешней системой логирования
  console.error('[ERROR]', error);
}

export function logEvent(event: string, data?: any) {
  // Можно интегрировать с аналитикой
  console.log('[EVENT]', event, data || '');
}
