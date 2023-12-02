import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:layla_app_dev/AppTheme/fontSizes.dart';
import 'package:layla_app_dev/Controllers/LocationController/locationController.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../AppTheme/ColorConstants.dart';
import '../../Widgets/Buttons/CustomFilledButton.dart';
import '../../Widgets/Buttons/OutlinedButton.dart';
import '../../Widgets/CustomAppBar/LogoAppBar.dart';
import '../../Widgets/TextFields/CustomTextFormField.dart';

class ContactUsUI extends StatefulWidget {
  const ContactUsUI({super.key});

  @override
  State<ContactUsUI> createState() => _ContactUsUIState();
}

class _ContactUsUIState extends State<ContactUsUI> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late LocationController locationProvider;

  @override
  void initState() {
    // TODO: implement initState
    locationProvider = Provider.of<LocationController>(context, listen: false);
    Future.delayed(Duration.zero, () {
      locationProvider.getPhoneNumbers();
    });
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<LocationController>(builder: (context, locationProvider, child) {
      return Scaffold(
        appBar: logoAppBar(
            showBackButton: true,
            onBackTap: () {
              Navigator.of(context).pop();
            }),
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  "CONTACT US",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: FontSizes.largeText, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20.sp,
                ),
                CustomTextFormField(
                  hintText: "Name",
                  controller: nameController,
                  // focusNode: _emailNode,
                  // onFieldSubmit: (value) => FocusScope.of(context).requestFocus(_passwordNode),
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.next,
                  // onTap: () => FocusScope.of(context).requestFocus(_emailNode),
                  // validator: (String? value) => value!.isEmpty ? "Please Enter your Name" : null,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                CustomTextFormField(
                  hintText: "Email*",
                  controller: emailController,
                  // focusNode: _emailNode,
                  // onFieldSubmit: (value) => FocusScope.of(context).requestFocus(_passwordNode),
                  inputType: TextInputType.emailAddress,
                  inputAction: TextInputAction.next,
                  // onTap: () => FocusScope.of(context).requestFocus(_emailNode),
                  validator: (String? value) => value!.isEmpty
                      ? "Please Enter your Email"
                      : !EmailValidator.validate(value)
                          ? "Please Enter a valid Email"
                          : null,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                CustomTextFormField(
                  hintText: "Phone number",
                  controller: phoneNumberController,
                  // focusNode: _emailNode,
                  // onFieldSubmit: (value) => FocusScope.of(context).requestFocus(_passwordNode),
                  inputType: TextInputType.number,
                  inputAction: TextInputAction.next,
                  // onTap: () => FocusScope.of(context).requestFocus(_emailNode),
                  // validator: (String? value) => value!.isEmpty ? "Please Enter your phone number" : null,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                CustomTextFormField(
                  maxLines: 5,
                  hintText: "Comment",
                  controller: commentController,
                  // focusNode: _emailNode,
                  // onFieldSubmit: (value) => FocusScope.of(context).requestFocus(_passwordNode),
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.next,
                  // onTap: () => FocusScope.of(context).requestFocus(_emailNode),
                  // validator: (String? value) => value!.isEmpty ? "Please Enter your Name" : null,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.sp),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                CustomFilledButton(
                  height: 35.sp,
                  width: size.width * 0.9,
                  title: "Send",
                  btnColor: ColorConstants.primaryColor,
                  textColor: ColorConstants.baseColor,
                  btnRadius: 5.r,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("Ok to go");
                    }
                  },
                ),
                SizedBox(
                  height: 10.sp,
                ),
                CustomOutlineButton(
                  width: size.width,
                  height: 35.sp,
                  title: "Whatsapp Support +965 565 86099",
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
                  title: "info@laylacollection.com",
                  fontColor: ColorConstants.textColorGrey,
                  fontSize: FontSizes.extraSmallText,
                  borderColor: ColorConstants.textColorGrey.withOpacity(0.8),
                  buttonColor: ColorConstants.textColorGrey.withOpacity(0.01),
                  buttonIcon: CupertinoIcons.envelope,
                  buttonIconColor: ColorConstants.textColorGrey.withOpacity(0.8),
                  onPressed: () async {
                    Uri email = Uri.parse('mailto:info@laylacollection.com');
                    if (await launchUrl(email)) {
                      //dialer opened
                    } else {
                      //dailer is not opened
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.sp),
                  child: Divider(
                    color: ColorConstants.textColorGrey.withOpacity(0.5),
                  ),
                ),
                Text(
                  "Branches Contact Number",
                  style: TextStyle(fontSize: FontSizes.normalText2, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: locationProvider.shopLocations.length,
                    itemBuilder: (context, index) {
                      return Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${locationProvider.shopLocations[index].name}",
                            style: TextStyle(fontSize: FontSizes.smallText, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () async {
                              Uri phoneNo = Uri.parse('tel:${locationProvider.shopLocations[index].phone}');
                              if (await launchUrl(phoneNo)) {
                                //dialer opened
                              } else {
                                //dailer is not opened
                              }
                            },
                            child: SizedBox(
                              width: size.width * 0.28,
                              child: Text(
                                locationProvider.shopLocations[index].phone!,
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: FontSizes.smallText, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ),
        ),
      );
    });
  }
}
