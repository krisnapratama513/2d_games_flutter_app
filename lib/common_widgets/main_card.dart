import 'package:flutter/material.dart';

class CustomFlexibleCard extends StatelessWidget {
  final String title;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;
  final double borderWidth;
  final double borderRadius;
  final EdgeInsetsGeometry outerMargin;
  final EdgeInsetsGeometry innerMargin;
  final double width;
  final double height;
  final double underlineWidth;
  final double underlineHeight;
  final VoidCallback onTap;

  const CustomFlexibleCard({
    required this.title,
    required this.borderColor,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
    this.borderWidth = 4.0,
    this.borderRadius = 20.0,
    this.outerMargin = const EdgeInsets.all(5),
    this.innerMargin = const EdgeInsets.all(10),
    this.width = 130,
    this.height = 180,
    this.underlineWidth = 50,
    this.underlineHeight = 5,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            margin: outerMargin,
            width: width,
            height: height,
            decoration: BoxDecoration(
              border: Border.all(
                color: borderColor,
                width: borderWidth,
              ),
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Container(
              margin: innerMargin,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: underlineWidth,
                    height: underlineHeight,
                    color: textColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
