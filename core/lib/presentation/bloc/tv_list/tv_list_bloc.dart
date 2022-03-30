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
  }) : super(FetchEmpty()) {
    on<FetchNowPlayingTvs>(
      (event, emit) async {
        emit(FetchLoading());

        final result = await getNowPlayingTvs.execute();
        result.fold(
          (failure) {
            emit(FetchError(failure.message));
          },
          (tvs) {
            if (tvs.isEmpty) {
              emit(FetchEmpty());
            } else {
              if (tvs.isNotEmpty) {
                emit(FetchLoaded(tvs));
              } else {
                emit(FetchEmpty());
              }
            }
          },
        );
      },
    );

    on<FetchPopularTvs>((event, emit) async {
      emit(FetchPopularLoading());

      final result = await getPopularTvs.execute();
      result.fold(
        (failure) {
          emit(FetchPopularError(failure.message));
        },
        (tvs) {
          if (tvs.isNotEmpty) {
            emit(FetchPopularLoaded(tvs));
          } else {
            emit(FetchPopularEmpty());
          }
        },
      );
    });

    on<FetchTopRatedTvs>((event, emit) async {
      emit(FetchTopRatedLoading());

      final result = await getTopRatedTvs.execute();
      result.fold(
        (failure) {
          emit(FetchTopRatedError(failure.message));
        },
        (tvs) {
          if (tvs.isNotEmpty) {
            emit(FetchTopRatedLoaded(tvs));
          } else {
            emit(FetchTopRatedEmpty());
          }
        },
      );
    });
  }
}
