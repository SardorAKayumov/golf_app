import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golf_app/features/shared/widgets/custom_appbar.dart';
import 'package:golf_app/features/topup/topup.dart';
import 'package:golf_app/injection_handler.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopupHistoryPage extends StatefulWidget {
  const TopupHistoryPage({super.key});

  @override
  State<TopupHistoryPage> createState() => _TopupHistoryPageState();
}

class _TopupHistoryPageState extends State<TopupHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.get<TopupBloc>(),
      child: Scaffold(
        appBar: CustomAppBar(
          context: context,
          title: AppLocalizations.of(context)!.page_title_points_history,
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
          child: Column(
            children: List.generate(3, (index) => Column(
              children: [
                SizedBox(height: 8.h),
                TopupHistoryItem(),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
