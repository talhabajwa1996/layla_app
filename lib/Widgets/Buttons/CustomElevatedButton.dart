import 'package:flutter/material.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onPressed;
  final double radius;
  final double height;
  final double width;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final BorderSide borderSide;

  const CustomElevatedButton({
    this.child,
    this.onPressed,
    this.foregroundColor,
    this.backgroundColor,
    this.radius = 5.0,
    this.height = 45.0,
    this.width = double.infinity,
    this.borderSide = BorderSide.none,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: foregroundColor ?? Colors.black,
          backgroundColor: backgroundColor ?? Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius), side: borderSide),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }

  static solid({
    final String? title,
    final VoidCallback? onPressed,
    final double? height,
    final double? width,
  }) {
    return CustomElevatedButton(
      foregroundColor: ColorConstants.white,
      backgroundColor: ColorConstants.primaryColor,
      onPressed: onPressed,
      child: Text(
        title!,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  static outlined({
    final String? title,
    final VoidCallback? onPressed,
    final double? height,
    final double? width,
  }) {
    return CustomElevatedButton(
      foregroundColor: ColorConstants.black,
      backgroundColor: Colors.white,
      onPressed: onPressed,
      borderSide: const BorderSide(color: ColorConstants.primaryColor, width: 2),
      child: Text(
        title!,
        style: const TextStyle(fontWeight: FontWeight.bold, color: ColorConstants.textColorGrey),
      ),
    );
  }

}
