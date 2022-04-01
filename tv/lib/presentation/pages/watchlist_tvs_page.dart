import 'package:core/utils/utils.dart';
import 'package:tv/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/tv_card_list.dart';
import 'package:flutter/material.dart';

class WatchlistTvsPage extends StatefulWidget {
  static const routeName = '/watchlist-tv';

  const WatchlistTvsPage({Key? key}) : super(key: key);

  @override
  _WatchlistTvsPageState createState() => _WatchlistTvsPageState();
}

class _WatchlistTvsPageState extends State<WatchlistTvsPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<WatchlistTvBloc>().add(FetchWatchlistTvs()),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTvBloc>().add(FetchWatchlistTvs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
          builder: (context, state) {
            if (state is FetchLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FetchLoaded) {
              if (state.tvs.isNotEmpty) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tv = state.tvs[index];
                    return TvCard(tv: tv);
                  },
                  itemCount: state.tvs.length,
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.tv),
                        Text("Belum ada"),
                      ],
                    ),
                  ],
                );
              }
            } else if (state is FetchEmpty) {
              return const Center(child: Text('Empty'));
            } else if (state is FetchError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
