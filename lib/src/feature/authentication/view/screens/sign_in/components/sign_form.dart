// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sizzle_starter/src/core/constant/theme/theme_constants.dart';
import 'package:sizzle_starter/src/core/helper/keyboard.dart';
import 'package:sizzle_starter/src/feature/authentication/view/common_widgets/custom_surfix_icon.dart';
import 'package:sizzle_starter/src/feature/authentication/view/common_widgets/form_error.dart';
import 'package:sizzle_starter/src/feature/authentication/view/screens/onboarding/components/primary_button.dart';
import 'package:sizzle_starter/src/feature/authentication/view/screens/otp/otp_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) => Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                onSaved: (newValue) => email = newValue,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    removeError(error: kEmailNullError);
                  } else if (emailValidatorRegExp.hasMatch(value)) {
                    removeError(error: kInvalidEmailError);
                  }
                  return;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    addError(error: kEmailNullError);
                    return "";
                  } else if (!emailValidatorRegExp.hasMatch(value)) {
                    addError(error: kInvalidEmailError);
                    return "";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                 // labelText: "Email",
                  hintText: "Enter your email",
                   filled: false,
                  hintStyle: TextStyle(fontSize: 16, color: Color.fromARGB(255, 71, 70, 70)),
                   enabledBorder: UnderlineInputBorder(      
                        borderSide: BorderSide(color: Colors.black),   
                        ),  
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                onSaved: (newValue) => password = newValue,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    removeError(error: kPassNullError);
                  } else if (value.length >= 8) {
                    removeError(error: kShortPassError);
                  }
                  return;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    addError(error: kPassNullError);
                    return "";
                  } else if (value.length < 8) {
                    addError(error: kShortPassError);
                    return "";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  filled: false,
                  labelText: "Password",
                  hintText: "Enter your password",
                  hintStyle: TextStyle(fontSize: 16, color: Color.fromARGB(255, 71, 70, 70)),
                  enabledBorder: UnderlineInputBorder(      
                        borderSide: BorderSide(color: Colors.black),   
                        ), 
                  focusedBorder: UnderlineInputBorder(      
                        borderSide: BorderSide(color: Colors.black),   
                        ),       
                )
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Forgot Password",
                        style: TextStyle(decoration: TextDecoration.underline, color: Color(0xFF292929), fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
              FormError(errors: errors),
              SizedBox(height: 16),
              CustomButton(isFilled: true, buttonTitle: 'Login', onPressed: (){
                if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // if all are valid then go to success screen
                    KeyboardUtil.hideKeyboard(context);
                    Get.to(const OtpScreen());
                  }
              }), 
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3563884214.
              const SizedBox(height: 5),
              CustomButton(isFilled: false, buttonTitle: 'Continue with Google', onPressed: (){})
              
            ],
          ),
        ),
      );
}
