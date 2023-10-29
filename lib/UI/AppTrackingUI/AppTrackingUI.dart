import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/UI/AppTrackingUI/centerDescriptionWidget.dart';

import '../../AppTheme/fontSizes.dart';
import '../../Utils/Constants/RouteConstants.dart';
import '../../Utils/HelperFunctions.dart';
import '../../Widgets/Buttons/CustomElevatedButton.dart';
import '../../Widgets/Images/AppLogo.dart';

class AppTrackingUI extends StatefulWidget {
  const AppTrackingUI({super.key});

  @override
  State<AppTrackingUI> createState() => _AppTrackingUIState();
}

class _AppTrackingUIState extends State<AppTrackingUI> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        body: SafeArea(
      top: true,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AppLogo(
              width: size.width * 0.5,
            ),
            SizedBox(
              width: size.width * 0.8,
              height: size.height * 0.6,
              child: const CenterDescriptionWidget(),
            ),
            Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    child: CustomElevatedButton.solid(
                        title: localizedText(context)?.next.toUpperCase(),
                        onPressed: () async {
                          checkAndAskForPermission();
                        })),
                Text(localizedText(context)!.privacy_policy,
                  style: TextStyle(
                      height: 1.25,
                      color: ColorConstants.textColorGrey,
                      fontSize: FontSizes.smallText,
                      fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline
                  ),),
              ],
            )
          ],
        ),
      ),
    ));
  }


  checkAndAskForPermission() async {
    final status = await AppTrackingTransparency.requestTrackingAuthorization();

    if(status == TrackingStatus.notDetermined){
      await AppTrackingTransparency.requestTrackingAuthorization().then((value){
        navigateToHome();
      });
    }else if (status == TrackingStatus.authorized) {
      navigateToHome();
    }else{
      navigateToHome();
    }
  }

  navigateToHome(){
    Navigator.pushReplacementNamed(context, RouteConstants.home);
  }
}
