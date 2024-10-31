part of 'explore_bloc.dart';

sealed class ExploreEvent {}

class GetRecentSearches extends ExploreEvent {}

class SetRecentSearches extends ExploreEvent {
  final List<String> searches;
  SetRecentSearches({required this.searches});
}