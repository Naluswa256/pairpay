// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sizzle_starter/src/feature/authentication/view/screens/forgot_password/components/forgot_pass_form.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = "/forgot_password";

  const ForgotPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Container(
                    height: MediaQuery.sizeOf(context).height*0.60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor
                    ),
              
                    child:Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical:24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.arrow_back_ios_new, size:18.sp),
                            ],
                          ),
                         const  Expanded(child:Center(child:Text('illustration'),))                         
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25,),
                  Padding(
                    padding: const EdgeInsets.only(left:12),
                    child: Text('Forgot\nyour Password?', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                  ),   
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left:12,right: 3),
                    child: Text('Please enter the email address you’d like your password reset information sent to'),
                  ),
                  const ForgotPassForm(),
                ],
              ),
            ),
          ),
        ),
      );
}
