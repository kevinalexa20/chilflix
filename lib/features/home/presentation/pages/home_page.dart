import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chilflix/common/routes/app_router.dart';
import 'package:chilflix/features/home/domain/entities/movie_entity.dart';
import 'package:chilflix/features/home/presentation/cubit/home_cubit.dart';
import 'package:chilflix/features/home/presentation/widgets/home_constants.dart';
import 'package:chilflix/features/home/presentation/widgets/movie_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit homeCubit;
  TextEditingController searchTextFieldController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    // dashboardCubit = InjectorSupport.resolve<HomeCubit>();
    super.initState();
    homeCubit = BlocProvider.of<HomeCubit>(context);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        key: HomeConstants.dashboardAppBarKey,
        title: Text('ChillFlix'),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              context.router.push(const SearchRoute());
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              fixedSize: const Size(500, 30),
            ),
            child: const Text(
              'Search movies',
              style: TextStyle(
                  // color: Colors.white,

                  ),
            ),
          ),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is MovieListOnLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is MovieListOnSuccess) {
                return _buildOnLoadedNewestMovies(state.movieList);
              } else if (state is HomeInitial) {
                homeCubit.getNewestMovies('marvel');
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const Center(
                child: Text(
                  'No Movies Found',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOnLoadedNewestMovies(List<MovieEntity> movieList) {
    return Expanded(
      key: HomeConstants.onMovieLoadedContainerKey,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          childAspectRatio: 0.9,
          crossAxisSpacing: 1,
        ),
        itemCount: movieList.length,
        itemBuilder: (_, i) {
          return _buildNewestMoviesPosterWidget(movieList[i]);
        },
      ),
    );
  }

  Widget _buildNewestMoviesPosterWidget(MovieEntity movie) {
    return GestureDetector(
      key: ValueKey('${movie.imdbID}_content_key'),
      onTap: () {
        context.router.push(
          DetailsRoute(movieEntity: movie),
        );
      },
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: movie.poster,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
