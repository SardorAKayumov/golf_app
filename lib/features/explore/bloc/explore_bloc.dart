import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golf_app/core/local_storage/shared_pref.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final MySharedPref sharedPref;

  ExploreBloc({required this.sharedPref}) : super(ExploreInitial()) {
    on<ExploreEvent>((event, emit) async {
      switch (event) {
        case GetRecentSearches():
          await _getRecentSearches(emit);
          break;
        case SetRecentSearches():
          await _setRecentSearches(event.searches, emit);
          break;
      }
    });
  }

  Future<void> _getRecentSearches(Emitter<ExploreState> emit) async {
    emit(ExploreLoading());
    final searches = await sharedPref.getRecentSearches();
    emit(ExploreRecentSearchesLoaded(searches: searches));
  }

  Future<void> _setRecentSearches(
      List<String> searches, Emitter<ExploreState> emit) async {
    emit(ExploreLoading());
    await sharedPref.setRecentSearches(searches);
    emit(ExploreLoaded());
  }
}
