// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:sizzle_starter/src/core/constant/sizeConfig/size_config.dart';
import 'package:sizzle_starter/src/core/constant/theme/theme_constants.dart';
class CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String text;

  CategoryIcon({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    MySize().init(context);

    return InkWell(
      splashColor: Color(MyColors.bg01),
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(MySize.getScaledSizeWidth(4.0)),
        child: Column(
          children: [
            Container(
              width: MySize.getScaledSizeWidth(50),
              height: MySize.getScaledSizeHeight(50),
              decoration: BoxDecoration(
                color: Color(MyColors.bg),
                borderRadius: BorderRadius.circular(MySize.getScaledSizeWidth(50)),
              ),
              child: Icon(
                icon,
                color: Color(MyColors.primary),
              ),
            ),
            SizedBox(
              height: MySize.getScaledSizeHeight(10),
            ),
            Text(
              text,
              style: TextStyle(
                color: Color(MyColors.primary),
                fontSize: MySize.getScaledSizeHeight(12),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
