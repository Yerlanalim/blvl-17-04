import 'package:cloud_firestore/cloud_firestore.dart';

/// Fluent-интерфейс для построения запросов к Firestore
class QueryBuilder {
  final CollectionReference collection;
  final List<Query Function(Query)> _modifiers = [];

  QueryBuilder(this.collection);

  /// Добавить фильтр where
  QueryBuilder where(String field, {required dynamic isEqualTo}) {
    _modifiers.add((q) => q.where(field, isEqualTo: isEqualTo));
    return this;
  }

  /// Добавить сортировку orderBy
  QueryBuilder orderBy(String field, {bool descending = false}) {
    _modifiers.add((q) => q.orderBy(field, descending: descending));
    return this;
  }

  /// Ограничить количество результатов
  QueryBuilder limit(int count) {
    _modifiers.add((q) => q.limit(count));
    return this;
  }

  /// Добавить startAfter для пагинации
  QueryBuilder startAfterDocument(DocumentSnapshot doc) {
    _modifiers.add((q) => q.startAfterDocument(doc));
    return this;
  }

  /// Выполнить запрос и получить результаты
  Future<List<Map<String, dynamic>>> get() async {
    // TODO: Реализация
    throw UnimplementedError();
  }

  /// Выполнить агрегирующую операцию (например, count)
  Future<int> count() async {
    // TODO: Реализация
    throw UnimplementedError();
  }

  /// Собрать итоговый Query
  Query build() {
    Query q = collection;
    for (final mod in _modifiers) {
      q = mod(q);
    }
    return q;
  }
}
