import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:weather_app1/ui/theme/app_colors.dart';

class HomePageBox extends StatelessWidget {
  final Widget? child;
  const HomePageBox({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 3,
          sigmaX: 3,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.blockBgColor,
          ),
          child: child,
        ),
      ),
    );
  }
}
