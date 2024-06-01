

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sizzle_starter/src/feature/authentication/view/common_widgets/auth_screens_header.dart';
import 'package:sizzle_starter/src/feature/authentication/view/common_widgets/no_account_text.dart';
import 'package:sizzle_starter/src/feature/authentication/view/common_widgets/social_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizzle_starter/src/feature/authentication/view/screens/onboarding/components/primary_button.dart';
import 'package:sizzle_starter/src/feature/authentication/view/screens/sign_in/components/sign_form.dart';

class SignInScreen extends StatelessWidget {

  const SignInScreen({super.key});
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
                    HeaderWidget(headerTitle: 'Sign In'),
                    SignForm(),
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}


