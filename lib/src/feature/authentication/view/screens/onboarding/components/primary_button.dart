import 'package:flutter/material.dart';



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
    return isFilled
        ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: ElevatedButton(
              onPressed: onPressed,
              child: Text(buttonTitle),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
              ),
              ),
            ),
        )
        : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: OutlinedButton(
              onPressed: onPressed,
              child: Text(buttonTitle),
             style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
              ),
              ),
            ),
        );
  }
}
