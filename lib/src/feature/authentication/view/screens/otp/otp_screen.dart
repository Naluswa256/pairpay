// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sizzle_starter/src/core/constant/theme/theme_constants.dart';
import 'package:sizzle_starter/src/feature/authentication/view/screens/otp/components/otp_form.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    const Text(
                      "OTP Verification",
                      style: headingStyle,
                    ),
                    const Text("We sent your code to +1 898 860 ***"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("This code will expired in "),
                        TweenAnimationBuilder(
                          tween: Tween(begin: 30.0, end: 0.0),
                          duration: const Duration(seconds: 30),
                          builder: (_, dynamic value, child) => Text(
                            "00:${value.toInt()}",
                            style: const TextStyle(color: kPrimaryColor),
                          ),
                        ),
                      ],
                    ),
                    const OtpForm(),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        // OTP code resend
                      },
                      child: const Text(
                        "Resend OTP Code",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
