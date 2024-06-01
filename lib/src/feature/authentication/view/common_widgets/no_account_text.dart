import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sizzle_starter/src/core/constant/theme/theme_constants.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: TextStyle(fontSize: 16.sp),
        ),
        GestureDetector(
          onTap: () {},
          child:Text(
            "Sign Up",
            style: TextStyle(fontSize: 16.sp, color: kPrimaryColor),
          ),
        ),
      ],
    );
}
