import 'package:flutter/material.dart';

import '../../Utils/Constants/ImageConstants.dart';

class AppLogo extends StatelessWidget {
  final double? height;
  final double? width;
  final AlignmentGeometry alignment;
  final Color? color;

  const AppLogo(
      {this.alignment = Alignment.center,
        this.color,
        this.height,
        this.width,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(ImageConstants.appLogo,
        height: height, width: width, alignment: alignment, color: color, fit: BoxFit.contain);
  }
}
