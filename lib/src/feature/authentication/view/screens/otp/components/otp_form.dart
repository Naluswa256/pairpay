// ignore_for_file: public_member_api_docs, inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sizzle_starter/src/core/constant/theme/theme_constants.dart';
import 'package:get/get.dart';
import 'package:sizzle_starter/src/feature/authentication/view/screens/forgot_password/forgot_password_screen.dart';
import 'package:sizzle_starter/src/feature/authentication/view/screens/onboarding/components/primary_button.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({
    super.key,
  });

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) => Form(
        child: Column(
          children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 60,
                    child: TextFormField(
                      autofocus: true,
                      obscureText: true,
                      style: TextStyle(fontSize: 24.sp),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: otpInputDecoration,
                      onChanged: (value) {
                        nextField(value, pin2FocusNode);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: TextFormField(
                      focusNode: pin2FocusNode,
                      obscureText: true,
                      style: TextStyle(fontSize: 24.sp),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: otpInputDecoration,
                      onChanged: (value) => nextField(value, pin3FocusNode),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: TextFormField(
                      focusNode: pin3FocusNode,
                      obscureText: true,
                      style: TextStyle(fontSize: 24.sp),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: otpInputDecoration,
                      onChanged: (value) => nextField(value, pin4FocusNode),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: TextFormField(
                      focusNode: pin4FocusNode,
                      obscureText: true,
                      style: TextStyle(fontSize: 24.sp),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: otpInputDecoration,
                      onChanged: (value) {
                        if (value.length == 1) {
                          pin4FocusNode!.unfocus();
                          // Then you need to check is the code is correct or not
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            CustomButton(isFilled: true, buttonTitle: 'Submit', onPressed: (){

            }),

          ],
        ),
      );
}
