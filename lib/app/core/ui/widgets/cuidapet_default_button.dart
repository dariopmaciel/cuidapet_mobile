import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class CuidapetDefaultButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? labelColor;
  final double? fontSize;
  final double padding;
  final double height;
  final double width;


  const CuidapetDefaultButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.borderRadius = 10,
    this.backgroundColor,
    this.labelColor,
    this.fontSize,
    this.padding = 10,
    this.width = double.infinity,
    this.height = 66,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          backgroundColor: backgroundColor ?? context.primaryColor,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: fontSize ?? 20,
            color: labelColor ?? Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
