import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';

class CustomAppButton extends StatelessWidget {
  const CustomAppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.backgroundColor = ColorsManager.mainColor,
    this.width = 300,
    this.height = 50,
    this.splashColor = const Color(0xffEAEAEA),
    this.textStyle = const TextStyle(
      color: Colors.white,
      letterSpacing: 0.8,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    this.suffixIcon,
    this.borderRadius = 10,
    this.elevation = 0,
    this.activeButton = true,
    this.inactiveColor,
    this.prefixIcon,
    this.borderColor,
    this.padding,
    this.margin,
    this.spacing,
  });

  final String label;
  final Function() onTap;
  final Color backgroundColor;
  final double width, height, borderRadius, elevation;
  final Color? splashColor, inactiveColor;
  final TextStyle textStyle;
  final Widget? suffixIcon, prefixIcon;
  final bool activeButton;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding, margin;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: splashColor,
      highlightColor: splashColor,
      onTap: (activeButton) ? onTap : null,
      borderRadius: BorderRadius.circular(borderRadius.r),
      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
          color: (activeButton)
              ? backgroundColor
              : inactiveColor ?? backgroundColor.withValues(alpha: 0.5),
          borderRadius: BorderRadiusDirectional.circular(borderRadius.r),
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),
        padding: padding,
        margin: margin,
        child: Row(
          spacing: spacing ?? 0,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (prefixIcon != null) prefixIcon!,
            Text(
              label,
              style: textStyle,
            ),
            if (suffixIcon != null) suffixIcon!,
          ],
        ),
      ),
    );
  }
}
