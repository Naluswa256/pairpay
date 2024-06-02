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
                     const SizedBox(height:20,),
                     Padding(
                       padding: const EdgeInsets.only(left:12),
                       child: Text('Enter 4 digit verification code sent to your registered mobile number.'),
                     ),
                    const OtpForm(),
                    const SizedBox(height:10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: ExpiringCode(onResendCode: (){}),
                    )
                   
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}


class ExpiringCode extends StatefulWidget {
  final Function onResendCode;

  const ExpiringCode({Key? key, required this.onResendCode}) : super(key: key);

  @override
  State<ExpiringCode> createState() => _ExpiringCodeState();
}

class _ExpiringCodeState extends State<ExpiringCode>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );
    _animation = Tween<double>(begin: 30.0, end: 0.0).animate(_controller);
    _controller.forward(from: 0.0); // Start the animation immediately
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text("This code will expire in "),
        AnimatedBuilder(
          animation: _controller,
          builder: (_, child) => Text(
            "00:${_animation.value.toInt()}",
            style: const TextStyle(color: kPrimaryColor),
          ),
        ),
       // Spacer(),
        Expanded(child:SizedBox()),
        _controller.isCompleted
            ? GestureDetector(
          onTap: () => widget.onResendCode(),
          child: Text(
            "Resend Code",
            style: const TextStyle(color:Colors.black, decoration: TextDecoration.underline),
          ),
        )
            : const SizedBox(), // Maintain spacing during animation
      ],
    );
  }
}
