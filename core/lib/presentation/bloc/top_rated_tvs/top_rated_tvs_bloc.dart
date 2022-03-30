import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_top_rated_tvs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_tvs_event.dart';
part 'top_rated_tvs_state.dart';

class TopRatedTvsBloc extends Bloc<TopRatedTvsEvent, TopRatedTvsState> {
  final GetTopRatedTvs getTopRatedTvs;

  TopRatedTvsBloc({required this.getTopRatedTvs}) : super(FetchEmpty()) {
    on<FetchTopRatedTvs>((event, emit) async {
      emit(FetchLoading());

      final result = await getTopRatedTvs.execute();

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
