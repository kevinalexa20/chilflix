// ignore_for_file: inference_failure_on_function_return_type

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chilflix/common/routes/app_router.dart';
import 'package:chilflix/features/details/presentation/cubit/details_cubit.dart';
import 'package:chilflix/features/details/presentation/pages/details_view_constants.dart';
import 'package:chilflix/features/home/domain/entities/movie_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.movieEntity});
  final MovieEntity movieEntity;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late DetailsCubit detailsCubit;
  late List<String> genres;

  @override
  void initState() {
    // detailsCubit = InjectorSupport.resolve<DetailsCubit>()
    //   ..getMovieDetailsByImdbId(widget.movieEntity.imdbID);
    detailsCubit = BlocProvider.of<DetailsCubit>(context)
      ..getMovieDetailsByImdbId(widget.movieEntity.imdbID);
    genres = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    return Scaffold(
      key: DetailsViewConstants.detailsScaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        // key: DetailsViewConstants.detailsAppBarKey,
        title: Text('ChillFlix'),
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              context.router.push(SearchRoute());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                '${widget.movieEntity.title} (${widget.movieEntity.year})',
                textScaleFactor: 0.8,
              ),
              background: CachedNetworkImage(
                imageUrl: widget.movieEntity.poster,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ConstrainedBox(
              constraints: const BoxConstraints(),
              child: BlocConsumer<DetailsCubit, DetailsState>(
                listener: (context, state) {
                  if (state is FetchDetailsOnSuccess) {
                    genres = state.movieDetailsData.genre.split(',');
                  }
                },
                bloc: detailsCubit,
                builder: (context, state) {
                  if (state is FetchDetailsOnSuccess) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          sectionWidget(
                            sectionTitle: state.movieDetailsData.rated,
                            sectionContent: '',
                            titleKey: DetailsViewConstants.ratedTitleKey,
                            contentKey: DetailsViewConstants.ratedContentKey,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Visibility(
                            visible: genres.isNotEmpty,
                            child:
                                genreWidget(key: DetailsViewConstants.genreKey),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            state.movieDetailsData.plot,
                            key: DetailsViewConstants.plotKey,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          sectionWidget(
                            sectionTitle: 'Awards',
                            sectionContent: state.movieDetailsData.awards,
                            titleKey: DetailsViewConstants.awardTitleKey,
                            contentKey: DetailsViewConstants.awardContentKey,
                          ),
                          sectionWidget(
                            sectionTitle: "Actors",
                            sectionContent: state.movieDetailsData.actors,
                          ),
                          sectionWidget(
                            sectionTitle: 'Director',
                            sectionContent: state.movieDetailsData.director,
                          ),
                          sectionWidget(
                            sectionTitle: "Writer",
                            sectionContent: state.movieDetailsData.writer,
                          ),
                          sectionWidget(
                            sectionTitle: 'Box Office',
                            sectionContent: state.movieDetailsData.boxOffice,
                          ),
                        ],
                      ),
                    );
                  }
                  return const LinearProgressIndicator(
                    key: DetailsViewConstants.linearProgressKey,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget genreWidget({Key? key}) {
    return Row(
      key: key,
      children: genres
          .map(
            (e) => Container(
              margin: const EdgeInsets.only(
                right: 10,
              ),
              padding: const EdgeInsets.all(
                8,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(
                  14,
                ),
              ),
              child: Text(
                e,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget sectionWidget({
    required String sectionTitle,
    required String sectionContent,
    Key? titleKey,
    Key? contentKey,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          sectionTitle,
          key: titleKey,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          sectionContent,
          key: contentKey,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
