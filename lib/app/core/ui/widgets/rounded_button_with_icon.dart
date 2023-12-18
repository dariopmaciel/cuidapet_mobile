import 'package:flutter/material.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/size_screen_extension.dart';

class RoundedButtonWithIcon extends StatelessWidget {
  final GestureTapCallback onTap;
  final double widht;
  final Color color;
  final IconData icon;
  final String label;

  const RoundedButtonWithIcon({
    super.key,
    required this.onTap,
    required this.widht,
    required this.color,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: widht,
        height: 45.h,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 2),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20.w,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: VerticalDivider(
                color: Colors.white,
                thickness: 2,
              ),
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
