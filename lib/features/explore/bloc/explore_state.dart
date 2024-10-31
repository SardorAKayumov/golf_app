part of 'explore_bloc.dart';

sealed class ExploreState {}

final class ExploreInitial extends ExploreState {}

final class ExploreLoading extends ExploreState {}

final class ExploreLoaded extends ExploreState {}

final class ExploreRecentSearchesLoaded extends ExploreState {
  final List<String> searches;
  ExploreRecentSearchesLoaded({required this.searches});
}
