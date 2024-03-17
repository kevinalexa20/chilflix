import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chilflix/common/routes/app_router.dart';
import 'package:chilflix/features/home/domain/entities/movie_entity.dart';
import 'package:chilflix/features/home/presentation/cubit/home_cubit.dart';
import 'package:chilflix/features/home/presentation/widgets/home_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieSearch extends StatefulWidget {
  final Function(String) onSearch;

  MovieSearch({required this.onSearch, super.key});

  @override
  State<MovieSearch> createState() => _MovieSearchState();
}

class _MovieSearchState extends State<MovieSearch> {
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
    // final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        key: HomeConstants.dashboardAppBarKey,
        title: Text('ChillFlix'),
        elevation: 0.0,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
            decoration: const BoxDecoration(
              // color: Colors.teal,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
            child: TextField(
              key: HomeConstants.searchFieldKey,
              controller: searchTextFieldController,
              onChanged: (query) {
                if (_debounce?.isActive ?? false) _debounce!.cancel();
                _debounce = Timer(const Duration(milliseconds: 800), () {
                  if (query.length > 1) {
                    homeCubit.getMovieBySearch(query);
                  }
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  onPressed: searchTextFieldController.clear,
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<HomeCubit, HomeState>(
            bloc: homeCubit,
            builder: (_, state) {
              if (state is MovieSearchOnError) {
                return _buildTextWidget(state.message);
              } else if (state is MovieSearchOnSuccess) {
                return _buildOnLoadedWidget(state.movieList);
              } else if (state is HomeInitial) {
                return _buildTextWidget('Search movies');
              } else {
                return const Expanded(
                  key: HomeConstants.onLoadingContainerKey,
                  child: Center(
                    child: CircularProgressIndicator(
                      key: HomeConstants.onLoadingSpinnerKey,
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildTextWidget(dynamic msg) {
    return Expanded(
      key: HomeConstants.messageContainerKey,
      child: Center(
        child: Text(
          msg.toString(),
          key: HomeConstants.messageTextKey,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildOnLoadedWidget(List<MovieEntity> movieList) {
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
          return _buildPosterWidget(movieList[i]);
        },
      ),
    );
  }

  Widget _buildPosterWidget(MovieEntity movie) {
    return GestureDetector(
      key: ValueKey('${movie.imdbID}_content_key'),
      onTap: () {
        context.router.push(
          DetailsRoute(
            movieEntity: movie,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              movie.poster,
            ),
          ),
        ),
      ),
    );
  }
}
