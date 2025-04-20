// TODO: Кастомные анимации переходов между экранами

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Fade transition
CustomTransitionPage fadeTransitionPage<T>({required Widget child}) =>
    CustomTransitionPage<T>(
      child: child,
      transitionsBuilder:
          (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
    );

// Slide from right transition
CustomTransitionPage slideRightTransitionPage<T>({required Widget child}) =>
    CustomTransitionPage<T>(
      child: child,
      transitionsBuilder:
          (context, animation, secondaryAnimation, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
    );
