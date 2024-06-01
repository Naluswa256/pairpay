// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sizzle_starter/src/core/constant/theme/theme_constants.dart';
import 'package:sizzle_starter/src/feature/authentication/view/common_widgets/custom_surfix_icon.dart';
import 'package:sizzle_starter/src/feature/authentication/view/common_widgets/form_error.dart';
import 'package:sizzle_starter/src/feature/authentication/view/common_widgets/no_account_text.dart';
import 'package:sizzle_starter/src/feature/authentication/view/screens/init_screen.dart';
import 'package:sizzle_starter/src/feature/authentication/view/screens/onboarding/components/primary_button.dart';
import 'package:sizzle_starter/src/feature/home/widget/home_screen.dart';

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({super.key});

  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String? email;
  @override
  Widget build(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                onSaved: (newValue) => email = newValue,
                onChanged: (value) {
                  if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                    setState(() {
                      errors.remove(kEmailNullError);
                    });
                  } else if (emailValidatorRegExp.hasMatch(value) &&
                      errors.contains(kInvalidEmailError)) {
                    setState(() {
                      errors.remove(kInvalidEmailError);
                    });
                  }
                  return;
                },
                validator: (value) {
                  if (value!.isEmpty && !errors.contains(kEmailNullError)) {
                    setState(() {
                      errors.add(kEmailNullError);
                    });
                  } else if (!emailValidatorRegExp.hasMatch(value) &&
                      !errors.contains(kInvalidEmailError)) {
                    setState(() {
                      errors.add(kInvalidEmailError);
                    });
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Email Address",
                  hintText: "Enter your email",
                  filled: false,
                  hintStyle: TextStyle(fontSize: 16, color: Color.fromARGB(255, 71, 70, 70)),
                    enabledBorder: UnderlineInputBorder(      
                          borderSide: BorderSide(color: Colors.black),   
                          ), 
                    focusedBorder: UnderlineInputBorder(      
                          borderSide: BorderSide(color: Colors.black),   
                          ),  
                ),
              ),
            ),
            SizedBox(height: 8),
            FormError(errors: errors),
            SizedBox(height: 8),
        
            CustomButton(isFilled: true, buttonTitle: 'Submit', onPressed: (){
               if (_formKey.currentState!.validate()) {
                  // Do what you want to do
                  Get.to(const InitScreen());
                }
            }),
            SizedBox(height: 16),
            const NoAccountText(),
          ],
        ),
      );
}
