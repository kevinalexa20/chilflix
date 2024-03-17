import 'package:auto_route/auto_route.dart';
import 'package:chilflix/features/details/presentation/pages/details_page.dart';
import 'package:chilflix/features/home/domain/entities/movie_entity.dart';
import 'package:chilflix/features/home/presentation/pages/home_page.dart';
import 'package:chilflix/features/home/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: SearchRoute.page),
        AutoRoute(page: DetailsRoute.page)
      ];
}
