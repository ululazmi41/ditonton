part of 'movie_detail_recommendation_bloc.dart';

abstract class MovieDetailRState extends Equatable {
  const MovieDetailRState();

  @override
  List<Object> get props => [];
}

class MovieDetailRLoading extends MovieDetailRState {}

class MovieDetailREmpty extends MovieDetailRState {}

class MovieDetailRError extends MovieDetailRState {
  final String message;

  const MovieDetailRError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailRLoaded extends MovieDetailRState {
  final List<Movie> recommendations;

  const MovieDetailRLoaded(this.recommendations);

  @override
  List<Object> get props => [recommendations];
}
