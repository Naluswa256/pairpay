// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sizzle_starter/src/core/constant/theme/theme_constants.dart';
import 'package:sizzle_starter/src/feature/authentication/view/common_widgets/auth_screens_header.dart';
import 'package:sizzle_starter/src/feature/authentication/view/screens/otp/components/otp_form.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.zero,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     HeaderWidget(headerTitle: 'Enter OTP'),
                     const SizedBox(height: 30,),
                     Text('Enter 4 digit verification code sent to your registered mobile number.'),
                    const OtpForm(),
                    
                    // GestureDetector(
                    //   onTap: () {
                    //     // OTP code resend
                    //   },
                    //   child: const Text(
                    //     "Resend OTP Code",
                    //     style: TextStyle(decoration: TextDecoration.underline),
                    //   ),
                    // )
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     const Text("This code will expired in "),
                    //     TweenAnimationBuilder(
                    //       tween: Tween(begin: 30.0, end: 0.0),
                    //       duration: const Duration(seconds: 30),
                    //       builder: (_, dynamic value, child) => Text(
                    //         "00:${value.toInt()}",
                    //         style: const TextStyle(color: kPrimaryColor),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
