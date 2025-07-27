import 'package:ecommerce/add.dart';
import 'package:ecommerce/detailpage.dart';
import 'package:ecommerce/homepage.dart';
import 'package:ecommerce/search.dart';

import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Homepage(),
    ),
    GoRoute(
      path: '/addpage',
      builder: (context, state) => Addpage(),
    ),
    GoRoute(
      path: '/detailpage',
      builder: (context, state) => Detailpage(),
    ),
    GoRoute(path: '/search' , builder:(context , state )=> SearchPage()) ,

  ],
);
