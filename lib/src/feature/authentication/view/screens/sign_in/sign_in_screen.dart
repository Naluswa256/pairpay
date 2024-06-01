

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
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
                    Container(
                      height: MediaQuery.sizeOf(context).height*0.40,
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
                      child: Text('Login', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                    ), 
                    SignForm(),
                    const SizedBox(height: 25,), 
                    CustomButton(isFilled: false, buttonTitle: 'Continue with Google', onPressed: (){

                    })
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}


