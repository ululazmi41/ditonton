import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/widgets/custom_drawer.dart';
import 'package:tv/presentation/bloc/popular_tvs/popular_tvs_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tvs/top_rated_tvs_bloc.dart';
import 'package:tv/presentation/bloc/tv_list/tv_list_bloc.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import '../../domain/entities/tv.dart';
import 'package:flutter/material.dart';

// Pages
import 'popular_tvs_page.dart';
import 'top_rated_tvs_page.dart';
import 'tv_detail_page.dart';

class HomeTvPage extends StatefulWidget {
  const HomeTvPage({Key? key}) : super(key: key);

  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvListBloc>().add(FetchNowPlayingTvs());
      context.read<PopularTvsBloc>().add(FetchPopularTvs());
      context.read<TopRatedTvsBloc>().add(FetchTopRatedTvs());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomDrawer(
        content: Scaffold(
          appBar: AppBar(
            title: const Text('Ditonton'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, searchTvRoute);
                },
                icon: const Icon(Icons.search),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Now Playing',
                    style: kHeading6,
                  ),
                  BlocBuilder<TvListBloc, TvListState>(
                      builder: (context, state) {
                    if (state is TvListLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TvListLoaded) {
                      return TvList(tvs: state.tvs);
                    } else if (state is TvListEmpty) {
                      return const Center(child: Text('Empty'));
                    } else if (state is TvListError) {
                      return const Text('Failed');
                    } else {
                      return Container();
                    }
                  }),
                  _buildSubHeading(
                    title: 'Popular',
                    onTap: () =>
                        Navigator.pushNamed(context, PopularTvsPage.routeName),
                  ),
                  BlocBuilder<PopularTvsBloc, PopularTvsState>(
                      builder: (context, state) {
                    if (state is PopularTvsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is PopularTvsLoaded) {
                      return TvList(tvs: state.tvs);
                    } else if (state is PopularTvsEmpty) {
                      return const Center(child: Text('Empty'));
                    } else if (state is PopularTvsError) {
                      return const Text('Failed');
                    } else {
                      return Container();
                    }
                  }),
                  _buildSubHeading(
                    title: 'Top Rated',
                    onTap: () =>
                        Navigator.pushNamed(context, TopRatedTvsPage.routeName),
                  ),
                  BlocBuilder<TopRatedTvsBloc, TopRatedTvsState>(
                      builder: (context, state) {
                    if (state is TopRatedTvsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TopRatedTvsLoaded) {
                      return TvList(tvs: state.tvs);
                    } else if (state is TopRatedTvsEmpty) {
                      return const Center(child: Text('Empty'));
                    } else if (state is TopRatedTvsError) {
                      return const Text('Failed');
                    } else {
                      return Container();
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tvs;

  const TvList({Key? key, required this.tvs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.routeName,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${tv.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}
