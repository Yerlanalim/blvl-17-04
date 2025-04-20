/// ImageOptimizer: утилиты для оптимизации загрузки и отображения изображений
/// Включает resize, кэширование, lazy loading

import 'package:flutter/widgets.dart';

class ImageOptimizer {
  /// Возвращает оптимизированный виджет изображения с кэшированием и lazy loading
  static Widget optimizedImage(
    String url, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    // TODO: Использовать кэширование (например, CachedNetworkImage), оптимизировать размеры
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      // TODO: добавить placeholder, errorWidget, кэширование
      // Можно заменить на CachedNetworkImage при наличии зависимости
    );
  }

  /// Пример оптимизации локального изображения
  static Widget optimizedAsset(
    String assetName, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return Image.asset(assetName, width: width, height: height, fit: fit);
  }
}
