part of "search_tv_bloc.dart";

abstract class SearchTvsState extends Equatable {
  const SearchTvsState();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchTvsState {}

class SearchLoading extends SearchTvsState {}

class SearchError extends SearchTvsState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasData extends SearchTvsState {
  final List<Tv> result;

  const SearchHasData(this.result);

  @override
  List<Object> get props => [result];
}
