part of 'movie_detail_recommendation_bloc.dart';

abstract class MovieDetailREvent extends Equatable {
  const MovieDetailREvent();

  @override
  List<Object> get props => [];
}

class FetchMovieR extends MovieDetailREvent {
  final int id;

  const FetchMovieR(this.id);

  @override
  List<Object> get props => [id];
}
