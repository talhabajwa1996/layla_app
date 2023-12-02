import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/AppTheme/fontSizes.dart';
import 'package:layla_app_dev/Controllers/DashboardController/dashboardController.dart';
import 'package:layla_app_dev/Services/ShopifyServices/ShopifyServices.dart';
import 'package:layla_app_dev/UI/FavoritesUI/favorites.dart';
import 'package:layla_app_dev/Widgets/Buttons/OutlinedButton.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Utils/Globals.dart';
import '../../Utils/HelperFunctions.dart';
import '../../Widgets/CustomAppBar/LogoAppBar.dart';
import '../CustomerServicesUI/contactUsUI.dart';
import '../HelpUI/helpUI.dart';

class SettingsUI extends StatefulWidget {
  const SettingsUI({super.key});

  @override
  State<SettingsUI> createState() => _SettingsUIState();
}

class _SettingsUIState extends State<SettingsUI> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: logoAppBar(
          showBackButton: true,
          onBackTap: () {
            Provider.of<DashboardController>(context, listen: false).setTabIndex = 0;
            Navigator.of(context).pop();
          }),
      body: ListView(
        children: [
          Container(
            width: size.width,
            height: 100.sp,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorConstants.primaryColor, ColorConstants.primaryColor.withOpacity(0.5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 15.w, top: 15.w, right: 15.w),
              child: Container(
                height: 80.sp,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(3.r)),
                  color: ColorConstants.white,
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          backgroundColor: ColorConstants.secondaryColor.withOpacity(0.25),
                          child: Text(
                            HelperFunctions().getInitials(shopifyUser!.firstName!),
                            style: TextStyle(
                                fontSize: FontSizes.normalText1, fontWeight: FontWeight.w900, color: ColorConstants.primaryColor),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              shopifyUser!.displayName!,
                              style: TextStyle(
                                  fontSize: FontSizes.smallText,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstants.textColorGrey),
                            ),
                            Text(
                              shopifyUser!.email!,
                              style: TextStyle(
                                  fontSize: FontSizes.smallText,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstants.textColorGrey.withOpacity(0.6)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: size.width,
            height: 85.sp,
            color: ColorConstants.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                settingsCard(localizedText(context)!.notifications, CupertinoIcons.bell),
                settingsCard(localizedText(context)!.favorites, CupertinoIcons.heart, onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return Favorites();
                  }));
                }),
                settingsCard("Discounts", CupertinoIcons.tag),
                settingsCard("Elvis", CupertinoIcons.sparkles),
              ],
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
          settingsListTile(localizedText(context)!.my_orders, CupertinoIcons.archivebox),
          settingsListTile(localizedText(context)!.my_account, CupertinoIcons.person),
          settingsListTile("My Addresses", CupertinoIcons.map_pin_ellipse),
          settingsListTile("Change Password", CupertinoIcons.lock),
          settingsListTile("My Reviews", CupertinoIcons.star_lefthalf_fill),
          settingsListTile("Saved Filters", CupertinoIcons.bookmark),
          settingsListTile("My Wallet", CupertinoIcons.money_dollar),
          settingsListTile("My Saved Cards", CupertinoIcons.creditcard),
          settingsListTile("My Gift Cards", CupertinoIcons.gift_alt),
          settingsListTile("Help", CupertinoIcons.question_circle, onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return HelpUI();
            }));
          }),
          settingsListTile(localizedText(context)!.signout, Icons.logout_rounded, onTap: () {
            ShopifyService().signOutUser(context);
          }),
          SizedBox(
            height: 20.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Support",
                  style: TextStyle(
                      fontSize: FontSizes.normalText1, color: ColorConstants.textColorGrey, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                CustomOutlineButton(
                  width: size.width,
                  height: 35.sp,
                  title: "Whatsapp Support 444 4 529",
                  fontColor: ColorConstants.textColorGrey,
                  fontSize: FontSizes.extraSmallText,
                  borderColor: ColorConstants.green.withOpacity(0.8),
                  buttonColor: ColorConstants.green.withOpacity(0.05),
                  buttonIcon: FontAwesomeIcons.whatsapp,
                  buttonIconColor: ColorConstants.green.withOpacity(0.8),
                  onPressed: () async {
                    Uri whatsapp = Uri.parse("https://wa.me/+96556586099");
                    if (await launchUrl(whatsapp)) {
                    //dialer opened
                    } else {
                    //dailer is not opened
                    }
                  },
                ),
                SizedBox(
                  height: 10.sp,
                ),
                CustomOutlineButton(
                  width: size.width,
                  height: 35.sp,
                  title: "Contact Form",
                  fontColor: ColorConstants.textColorGrey,
                  fontSize: FontSizes.extraSmallText,
                  borderColor: ColorConstants.primaryColor.withOpacity(0.8),
                  buttonColor: ColorConstants.primaryColor.withOpacity(0.03),
                  buttonIcon: CupertinoIcons.doc_text,
                  buttonIconColor: ColorConstants.primaryColor.withOpacity(0.8),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return ContactUsUI();
                    }));
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 100.sp,
          ),
        ],
      ),
    );
  }

  Widget settingsCard(String title, IconData icon, {Color? iconColor, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 33.sp,
            height: 33.sp,
            decoration: BoxDecoration(
              color: ColorConstants.dullWhite.withOpacity(0.6),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Icon(
                icon,
                color: ColorConstants.primaryColor,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(
            height: 8.sp,
          ),
          Text(
            title,
            style: TextStyle(fontSize: FontSizes.extraSmallText),
          )
        ],
      ),
    );
  }

  Widget settingsListTile(String title, IconData icon, {Function()? onTap}) {
    return Container(
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: ColorConstants.textColorGrey.withOpacity(0.1), width: 0.5))),
      child: ListTile(
        tileColor: ColorConstants.white,
        leading: Icon(icon),
        title: Text(
          title,
          style: TextStyle(fontSize: FontSizes.smallText, color: ColorConstants.textColorGrey),
        ),
        trailing: Icon(CupertinoIcons.forward),
        onTap: onTap,
      ),
    );
  }
}
