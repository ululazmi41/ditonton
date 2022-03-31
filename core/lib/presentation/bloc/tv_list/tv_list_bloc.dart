import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_on_the_air_tvs.dart';
import 'package:core/domain/usecases/get_popular_tvs.dart';
import 'package:core/domain/usecases/get_top_rated_tvs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_list_event.dart';
part 'tv_list_state.dart';

class TvListBloc extends Bloc<TvListEvent, TvListState> {
  final GetOnTheAirTvs getNowPlayingTvs;
  final GetPopularTvs getPopularTvs;
  final GetTopRatedTvs getTopRatedTvs;

  TvListBloc({
    required this.getNowPlayingTvs,
    required this.getPopularTvs,
    required this.getTopRatedTvs,
  }) : super(TvListEmpty()) {
    on<FetchNowPlayingTvs>(
      (event, emit) async {
        emit(TvListLoading());

        final result = await getNowPlayingTvs.execute();
        result.fold(
          (failure) {
            emit(TvListError(failure.message));
          },
          (tvs) {
            if (tvs.isEmpty) {
              emit(TvListEmpty());
            } else {
              if (tvs.isNotEmpty) {
                emit(TvListLoaded(tvs));
              } else {
                emit(TvListEmpty());
              }
            }
          },
        );
      },
    );
  }
}
