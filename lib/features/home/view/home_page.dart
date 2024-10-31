import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_handler.dart';
import '../home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.onRewardPointClicked});
  final VoidCallback onRewardPointClicked;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.get<HomeBloc>(),
      child: HomeView(onPointRewardClicked: onRewardPointClicked),
    );
  }
}
