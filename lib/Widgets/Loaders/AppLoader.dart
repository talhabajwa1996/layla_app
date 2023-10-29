import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../AppTheme/ColorConstants.dart';

class AppLoader extends StatelessWidget {
  final double size;
  final Color color;

  const AppLoader(
      {this.size = 40.0, this.color = ColorConstants.primaryColor, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(color: color, size: size);
  }
}
