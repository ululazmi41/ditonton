import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv_detail_recommendation/tv_detail_recommendation_bloc.dart';
import 'package:tv/presentation/bloc/tv_detail_watchlist/tv_detail_watchlist_bloc.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';

class TvSeasonPage extends StatefulWidget {
  static const routeName = '/tv_season';

  final List list;
  const TvSeasonPage({Key? key, required this.list}) : super(key: key);

  @override
  _TvSeasonPageState createState() => _TvSeasonPageState();
}

class _TvSeasonPageState extends State<TvSeasonPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvDetailBloc>().add(FetchTvDetail(widget.list[0]));
      context.read<TvDetailRBloc>().add(FetchTvR(widget.list[0]));
      context.read<TvDetailWatchlistBloc>().add(
            LoadWatchlist(widget.list[0]),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvDetailBloc, TvDetailState>(
        builder: (context, state) {
          if (state is TvDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvDetailLoaded) {
            return SafeArea(
              child: SeasonContent(
                tv: state.tv,
                season: widget.list[1],
                recommendations: state.recommendations,
              ),
            );
          } else if (state is TvDetailEmpty) {
            return const Center(child: Text('Empty'));
          } else if (state is TvDetailError) {
            return Text(state.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class SeasonContent extends StatelessWidget {
  const SeasonContent(
      {Key? key,
      required this.tv,
      required this.season,
      required this.recommendations})
      : super(key: key);

  final TvDetail tv;
  final Season season;
  final List<Tv> recommendations;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          child: season.posterPath != null && season.posterPath != ""
              ? CachedNetworkImage(
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500${season.posterPath}',
                  width: screenWidth,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : Container(
                  width: screenWidth,
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    color: Colors.white60,
                  ),
                  child: Icon(Icons.image_not_supported),
                ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${season.name}',
                              style: kHeading6,
                            ),
                            Text('${season.episodeCount} Episodes'),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text('${season.overview}'),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final season =
                                      tv.seasons.reversed.toList()[index];
                                  if (season.posterPath != null &&
                                      season.posterPath != "") {
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushReplacementNamed(
                                            context,
                                            TvSeasonPage.routeName,
                                            arguments: [tv.id, season],
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "https://image.tmdb.org/t/p/w500${season.posterPath!}",
                                            placeholder: (context, url) =>
                                                const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.white60,
                                          ),
                                          child:
                                              Icon(Icons.image_not_supported),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                itemCount: tv.seasons.length,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvDetailRBloc, TvDetailRState>(
                              builder: (context, state) {
                                if (state is TvDetailRLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is TvDetailRError) {
                                  return Text(state.message);
                                } else if (state is TvDetailRLoaded) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = state.recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvDetailPage.routeName,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendations.length,
                                    ),
                                  );
                                }
                                if (state is TvDetailREmpty) {
                                  return const Center(child: Text('Empty'));
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }
}
