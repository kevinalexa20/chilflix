import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:chilflix/features/home/presentation/cubit/home_cubit.dart';
import 'package:chilflix/features/home/presentation/widgets/movie_search.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late HomeCubit homeCubit;
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MovieSearch(
        onSearch: (query) {
          if (_debounce?.isActive ?? false) _debounce?.cancel();
          _debounce = Timer(const Duration(milliseconds: 500), () {
            homeCubit.getMovieBySearch(query);
          });
        },
        // key: HomeConstants.dashboardAppBarKey,
      ),
    );
  }
}
