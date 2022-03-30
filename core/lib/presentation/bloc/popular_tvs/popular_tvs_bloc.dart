import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_popular_tvs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_tvs_events.dart';
part 'popular_tvs_state.dart';

class PopularTvsBloc extends Bloc<PopularTvsEvent, PopularTvsState> {
  final GetPopularTvs getPopularTvs;

  PopularTvsBloc(this.getPopularTvs) : super(FetchEmpty()) {
    on<FetchPopularTvs>((event, emit) async {
      emit(FetchLoading());

      final result = await getPopularTvs.execute();

      result.fold(
        (failure) {
          emit(FetchError(failure.message));
        },
        (tvs) {
          if (tvs.isNotEmpty) {
            emit(FetchLoaded(tvs));
          } else {
            emit(FetchEmpty());
          }
        },
      );
    });
  }
}
