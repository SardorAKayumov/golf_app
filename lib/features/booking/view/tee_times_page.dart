import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golf_app/injection_handler.dart';

import '../booking.dart';

class TeeTimesPage extends StatelessWidget {
  const TeeTimesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.get<BookingBloc>(),
      child: const TeeTimesView(),
    );
  }
}
