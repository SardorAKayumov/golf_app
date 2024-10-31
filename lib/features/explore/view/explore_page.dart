import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_handler.dart';
import '../explore.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.get<ExploreBloc>()..add(GetRecentSearches()),
      child: const ExploreView(),
    );
  }
}
