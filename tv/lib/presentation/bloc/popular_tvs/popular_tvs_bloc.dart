import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tvs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_tvs_events.dart';
part 'popular_tvs_state.dart';

class PopularTvsBloc extends Bloc<PopularTvsEvent, PopularTvsState> {
  final GetPopularTvs getPopularTvs;

  PopularTvsBloc(this.getPopularTvs) : super(PopularTvsEmpty()) {
    on<FetchPopularTvs>((event, emit) async {
      emit(PopularTvsLoading());

      final result = await getPopularTvs.execute();

      result.fold(
        (failure) {
          emit(PopularTvsError(failure.message));
        },
        (tvs) {
          if (tvs.isNotEmpty) {
            emit(PopularTvsLoaded(tvs));
          } else {
            emit(PopularTvsEmpty());
          }
        },
      );
    });
  }
}
