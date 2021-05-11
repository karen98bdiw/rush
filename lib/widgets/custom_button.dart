import 'package:flutter/material.dart';
import 'package:rush/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final Function onClick;
  final String title;
  final Color fillColor;

  CustomButton({
    this.onClick,
    this.title,
    this.fillColor = AppColors.Main_Orange,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 40,
        ),
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topRight: Radius.zero,
            bottomLeft: Radius.zero,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
