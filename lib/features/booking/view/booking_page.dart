import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golf_app/features/booking/booking.dart';
import 'package:golf_app/injection_handler.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.get<BookingBloc>(),
      child: const BookingView(),
    );
  }
}
