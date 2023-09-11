import 'dart:async';
import 'package:flutter/material.dart';
import '../../Utils/Constants/ColorConstants.dart';
import '../../Utils/Constants/RouteConstants.dart';
import '../../Widgets/Images/AppLogo.dart';

class SplashScreenUI extends StatefulWidget {
  const SplashScreenUI({super.key});

  @override
  _SplashScreenUIState createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI>
    with SingleTickerProviderStateMixin {
  Animation<double>? _iconAnimation;
  AnimationController? _iconAnimationController;

  void navigate() async {
    Timer(const Duration(seconds: 4), () async {
      Navigator.of(context).pushReplacementNamed(RouteConstants.selectLanguage);
    });
  }

  @override
  void initState() {
    _iconAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2500));
    _iconAnimation = CurvedAnimation(
      parent: _iconAnimationController!,
      curve: Curves.easeOutBack,
    );
    _iconAnimation!.addListener(() => this.setState(() {}));
    _iconAnimationController!.forward();
    navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Center(
          child: SizedBox(
            height: _iconAnimation!.value * size.height * 0.23,
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(50.0),
                child: AppLogo(color: ColorConstants.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
