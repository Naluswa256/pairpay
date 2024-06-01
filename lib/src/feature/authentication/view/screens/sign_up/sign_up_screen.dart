// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sizzle_starter/src/core/constant/theme/theme_constants.dart';
import 'package:sizzle_starter/src/feature/authentication/view/common_widgets/already_account_text.dart';
import 'package:sizzle_starter/src/feature/authentication/view/common_widgets/auth_screens_header.dart';
import 'package:sizzle_starter/src/feature/authentication/view/common_widgets/social_card.dart';
import 'package:sizzle_starter/src/feature/authentication/view/screens/sign_up/components/sign_up_form.dart';
import 'package:get/get.dart';
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
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
                     HeaderWidget(headerTitle: 'Sign Up'),                 
                    const SignUpForm(),
                    AlreadyAccountText()
                  
                   
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
