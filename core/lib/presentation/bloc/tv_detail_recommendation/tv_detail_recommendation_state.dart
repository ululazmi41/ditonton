part of 'tv_detail_recommendation_bloc.dart';

abstract class TvDetailRState extends Equatable {
  const TvDetailRState();

  @override
  List<Object> get props => [];
}

class TvDetailRLoading extends TvDetailRState {}

class TvDetailREmpty extends TvDetailRState {}

class TvDetailRError extends TvDetailRState {
  final String message;

  const TvDetailRError(this.message);

  @override
  List<Object> get props => [message];
}

class TvDetailRLoaded extends TvDetailRState {
  final List<Tv> recommendations;

  const TvDetailRLoaded(this.recommendations);

  @override
  List<Object> get props => [recommendations];
}
