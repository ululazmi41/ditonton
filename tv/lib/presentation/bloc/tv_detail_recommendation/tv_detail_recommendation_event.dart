part of 'tv_detail_recommendation_bloc.dart';

abstract class TvDetailREvent extends Equatable {
  const TvDetailREvent();

  @override
  List<Object> get props => [];
}

class FetchTvR extends TvDetailREvent {
  final int id;

  const FetchTvR(this.id);

  @override
  List<Object> get props => [id];
}
