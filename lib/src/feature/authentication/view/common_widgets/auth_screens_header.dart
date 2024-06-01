import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HeaderWidget extends StatelessWidget {
  final String headerTitle;

  const HeaderWidget({
    Key? key,
    required this.headerTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.40,
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.arrow_back_ios_new, size: 18.sp),
                  ],
                ),
                const Expanded(
                    child: Center(
                  child: Text('illustration'),
                ))
              ],
            ),
          ),
        ),
        const SizedBox(height: 25,),
                    Padding(
                      padding: const EdgeInsets.only(left:12),
                      child: Text(headerTitle, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                    ), 
      ],
    );
  }
}
