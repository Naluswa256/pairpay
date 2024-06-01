import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';



class CustomButton extends StatelessWidget {

  final bool isFilled;
  final String buttonTitle;
  final VoidCallback onPressed;
  
  const CustomButton({
    Key? key,
    required this.isFilled,
    required this.buttonTitle,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final  screenConfigHeight = MediaQuery.sizeOf(context).height;
    return isFilled
        ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, screenConfigHeight*0.08),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
              ),
              ),
              child: Text(buttonTitle, style: TextStyle(
                fontWeight: FontWeight.w600, 
                fontSize: 16.sp
              ),),
            ),
        )
        : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: OutlinedButton(
              onPressed: onPressed,
             style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, screenConfigHeight*0.08),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
              ),
              ),
              child: Text(buttonTitle, style: TextStyle(
                fontWeight: FontWeight.w600, 
                fontSize: 16.sp
              ),),
            ),
        );
  }
}
