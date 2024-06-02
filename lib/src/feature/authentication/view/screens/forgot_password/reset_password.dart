
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sizzle_starter/src/feature/authentication/view/common_widgets/auth_screens_header.dart';
import 'package:sizzle_starter/src/feature/authentication/view/screens/forgot_password/components/forgot_pass_form.dart';
import 'package:sizzle_starter/src/feature/authentication/view/screens/forgot_password/components/reset_password_form.dart';

class ResetPasswordScreen extends StatelessWidget {

  const ResetPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(headerTitle: 'Reset Your Password'),
              const SizedBox(height: 10,),
              const ResetPasswordForm(),
            ],
          ),
        ),
      ),
    ),
  );
}
