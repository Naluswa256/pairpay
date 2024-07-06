// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:sizzle_starter/src/core/constant/sizeConfig/size_config.dart';
import 'package:sizzle_starter/src/feature/app/model/app_theme.dart';
import 'package:sizzle_starter/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/authenticaton_bloc.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/events/authentication_event.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/states/authentication_bloc.dart';
import 'package:sizzle_starter/src/home_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  late ThemeData themeData;
  late AuthenticationBloc authenticationBloc;
  final TextEditingController _OtpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    authenticationBloc = DependenciesScope.of(context).authenticationBloc;
    themeData = Theme.of(context);
    MySize().init(context);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600,),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back_ios_rounded,
        //     color: Colors.black,
        //   ),
        // ),
        elevation: 0,
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        bloc: authenticationBloc,
        listener: (context, state) {
          if (state is EmailVerified) {
            _showError('Email successfully verified');
            context.goNamed('Home');
          } else if (state is AuthenticationFailure) {
            _showError(state.message);
          }
        },
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            bloc: authenticationBloc,
            builder: (BuildContext context, AuthenticationState state) =>
                Container(
                  margin: const EdgeInsets.only(left: 25, right: 25),
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo-removebg-preview.png',
                          width: 150,
                          height: 150,
                        ),
                        SizedBox(
                          height: MySize.size24,
                        ),
                        const Text(
                          "Email Verification",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold,),
                        ),
                        SizedBox(
                          height: MySize.size30,
                        ),
                        const Text(
                          "Enter the Otp code sent to your email we want to verify before getting started",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: MySize.size30,
                        ),
                        Pinput(
                          length: 4,
                          showCursor: true,
                          controller: _OtpController,
                          onCompleted: (pin) => {},
                          
                        ),
                        SizedBox(
                          height: MySize.size20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: MySize.getScaledSizeHeight(45),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                    themeData.colorScheme.primary,),
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            MySize.getScaledSizeHeight(
                                                8,),),), // Square corners
                                  ),
                                ),
                              ),
                              onPressed: () {
                                authenticationBloc.add(VerifyEmail(
                                    Otp: _OtpController.text,),);
                              },
                              child: state is AuthenticationLoading
                                  ? CircularProgressIndicator(
                                      backgroundColor: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color,
                                    )
                                  : Text("Verify Email",
                                      style: AppThemeCustom.getTextStyle(
                                          themeData.textTheme.labelLarge,
                                          fontWeight: 600,
                                          color: themeData
                                              .colorScheme.onPrimary,),),),
                        ),
                      ],
                    ),
                  ),
                ),),
      ),
    );
  }

  void _showError(String error) async {
    await Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,);
  }
}
