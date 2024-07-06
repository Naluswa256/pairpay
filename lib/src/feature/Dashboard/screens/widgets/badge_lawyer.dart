// ignore_for_file: public_member_api_docs, avoid_redundant_argument_values

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sizzle_starter/src/feature/app/model/app_theme.dart';

class BadgeLawyer extends StatelessWidget {
  final String label;
  final String value;
  final int color;
  final IconData icon;
  late ThemeData themeData;
  BadgeLawyer(
      {Key? key,
      this.label = "Patients",
      this.value = "1000",
      this.color = 0xff7ACEFA,
      this.icon = EvaIcons.person})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Container(
      width: 110,
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            padding: const EdgeInsets.fromLTRB(12, 30, 12, 8),
            decoration: BoxDecoration(
              color: Color(color).withOpacity(0.15),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Icon(
              icon,
              size: 30,
              color: Color(color),
            ),
          ),
          Text(value,
              style: AppThemeCustom.getTextStyle(
                themeData.textTheme.bodySmall,
                color: const Color.fromARGB(255, 106, 127, 192),
              )),
          Text(label,
              style: AppThemeCustom.getTextStyle(
                themeData.textTheme.bodySmall,
                color: const Color(0xff6B779A),
              ))
        ],
      ),
    );
  }
}
