import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/utils/routes.dart';
import '../../core.dart';
import '../../domain/entities/tv.dart';
import '../provider/tv_list_notifier.dart';
import '../widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    Future.microtask(() => Provider.of<TvListNotifier>(context, listen: false)
      ..fetchOnTheAirTvs()
      ..fetchPopularTvs()
      ..fetchTopRatedTvs());
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
                  Navigator.pushNamed(context, searchRoute);
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
                  Consumer<TvListNotifier>(builder: (context, data, child) {
                    final state = data.onTheAirState;
                    if (state == RequestState.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state == RequestState.loaded) {
                      return TvList(tvs: data.onTheAirTvs);
                    } else {
                      return const Text('Failed');
                    }
                  }),
                  _buildSubHeading(
                    title: 'Popular',
                    onTap: () =>
                        Navigator.pushNamed(context, PopularTvsPage.routeName),
                  ),
                  Consumer<TvListNotifier>(builder: (context, data, child) {
                    final state = data.popularTvsState;
                    if (state == RequestState.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state == RequestState.loaded) {
                      return TvList(tvs: data.popularTvs);
                    } else {
                      return const Text('Failed');
                    }
                  }),
                  _buildSubHeading(
                    title: 'Top Rated',
                    onTap: () =>
                        Navigator.pushNamed(context, TopRatedTvsPage.routeName),
                  ),
                  Consumer<TvListNotifier>(builder: (context, data, child) {
                    final state = data.topRatedTvsState;
                    if (state == RequestState.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state == RequestState.loaded) {
                      return TvList(tvs: data.topRatedTvs);
                    } else {
                      return const Text('Failed');
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
