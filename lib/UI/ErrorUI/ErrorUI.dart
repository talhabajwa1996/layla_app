import 'package:flutter/material.dart';
import '../../AppTheme/ColorConstants.dart';
import '../../Utils/Constants/ImageConstants.dart';

class ShowError extends StatelessWidget {
  final String? errorMessage;
  final void Function()? onRetryPressed;
  final bool? isBackButton;
  final double? height;
  final double? width;

  const ShowError(
      {Key? key,
      this.errorMessage,
      this.onRetryPressed,
      this.width,
      this.height,
      this.isBackButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(errorMessage);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        height: height ?? size.height,
        width: width ?? size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Expanded(child: SizedBox()),
            Image.asset(
              ImageConstants.errorImage,
              height: size.height * 0.2,
              color: Colors.black,
            ),
            const SizedBox(height: 8.0),
            Text(errorMessage ?? "An unexperted Error occured",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            const Expanded(child: SizedBox()),
            const SizedBox(height: 20),
            SizedBox(
              width: size.width * 0.35,
              child: InkWell(
                onTap: onRetryPressed ?? () {},
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      color: ColorConstants.primaryColor,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: const Center(
                    child: Text(
                      "Retry",
                      style: TextStyle(color: ColorConstants.white),
                      strutStyle: StrutStyle(
                        forceStrutHeight: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
