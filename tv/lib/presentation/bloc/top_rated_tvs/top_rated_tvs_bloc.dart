import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tvs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_tvs_event.dart';
part 'top_rated_tvs_state.dart';

class TopRatedTvsBloc extends Bloc<TopRatedTvsEvent, TopRatedTvsState> {
  final GetTopRatedTvs getTopRatedTvs;

  TopRatedTvsBloc({required this.getTopRatedTvs}) : super(TopRatedTvsEmpty()) {
    on<FetchTopRatedTvs>((event, emit) async {
      emit(TopRatedTvsLoading());

      final result = await getTopRatedTvs.execute();

      result.fold(
        (failure) {
          emit(TopRatedTvsError(failure.message));
        },
        (tvs) {
          if (tvs.isNotEmpty) {
            emit(TopRatedTvsLoaded(tvs));
          } else {
            emit(TopRatedTvsEmpty());
          }
        },
      );
    });
  }
}
