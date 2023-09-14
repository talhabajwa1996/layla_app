import 'package:flutter/material.dart';
import '../../Utils/Constants/ImageConstants.dart';

class DevUI extends StatelessWidget {
  const DevUI({Key? key}) : super(key: key);
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            SizedBox(height: 150, child: Image.asset(ImageConstants.devIcon)),
      ),
    );
  }
}
