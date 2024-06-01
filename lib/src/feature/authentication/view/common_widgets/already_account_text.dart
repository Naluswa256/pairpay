import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sizzle_starter/src/core/constant/theme/theme_constants.dart';

class AlreadyAccountText extends StatelessWidget {
  const AlreadyAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: TextStyle(fontSize: 16.sp),
        ),
        GestureDetector(
          onTap: () {},
          child:Text(
            "Login",
            style: TextStyle(fontSize: 16.sp, color:Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
}
