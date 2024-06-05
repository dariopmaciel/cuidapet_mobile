import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class CuidapetDefaultButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double borderRadius;
  final Color? color;
  final Color? labelColor;
  final String label;
  final double labelSize;
  final double padding;
  final double widgt;
  final double height;

  const CuidapetDefaultButton({
    super.key,
    required this.onPressed,
    this.borderRadius = 10,
    this.color,
    this.labelColor,
    required this.label,
    this.labelSize = 20,
    this.padding = 10,
     this.widgt = double.infinity,
     this.height = 66,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      width: widgt,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
          backgroundColor: color ?? context.primaryColor,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: labelSize,
            color: labelColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
