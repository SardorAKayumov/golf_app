import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/assets.dart';
import '../signup.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

enum CurrentForm {
  emailAndPassword,
  verification,
  setName,
}

class _SignUpViewState extends State<SignUpView> {
  CurrentForm currentForm = CurrentForm.emailAndPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Stack(
            children: [
              // Background Image
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 381.h,
                child: Image.asset(
                  Assets.loginBackground,
                  fit: BoxFit.cover,
                ),
              ),

              // Signup Form
              Align(
                alignment: Alignment.bottomCenter,
                child: Builder(builder: (context) {
                  if (currentForm == CurrentForm.emailAndPassword) {
                    return SignUpForm();
                  } else if (currentForm == CurrentForm.verification) {
                    return VerificationForm();
                  } else if (currentForm == CurrentForm.setName) {
                    return SetNameForm();
                  } else {
                    return SignUpForm();
                  }
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
