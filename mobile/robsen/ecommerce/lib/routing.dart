import 'package:ecommerce/add.dart';
import 'package:ecommerce/detailpage.dart';
import 'package:ecommerce/homepage.dart';
import 'package:ecommerce/search.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder:
          (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: Homepage(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
    ),
    GoRoute(
      path: '/addpage',
      pageBuilder:
          (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: Addpage(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          ),
    ),
    GoRoute(
      path: '/detail',
      pageBuilder:
          (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: Detailpage(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return ScaleTransition(scale: animation, child: child);
            },
          ),
    ),
    GoRoute(
      path: '/search',
      pageBuilder:
          (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: SearchPage(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
    ),
  ],
);
