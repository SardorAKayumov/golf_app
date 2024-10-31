import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golf_app/features/booking/booking.dart';
import 'package:golf_app/injection_handler.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.get<BookingBloc>(),
      child: const BookingsView(),
    );
  }
}
