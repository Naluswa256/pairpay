// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SocalCard extends StatelessWidget {
  const SocalCard({
    super.key,
    this.icon,
    this.press,
  });

  final String? icon;
  final Function? press;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: press as void Function()?,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(12),
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            color: Color(0xFFF5F6F9),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(icon!),
        ),
      );
}
