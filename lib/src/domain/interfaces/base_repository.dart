/// Базовый интерфейс репозитория для CRUD-операций
abstract class BaseRepository<T> {
  /// Получить все объекты
  Future<List<T>> getAll();

  /// Получить объект по id
  Future<T?> getById(String id);

  /// Создать новый объект
  Future<T> create(T entity);

  /// Обновить объект
  Future<void> update(String id, T entity);

  /// Удалить объект
  Future<void> delete(String id);
}
