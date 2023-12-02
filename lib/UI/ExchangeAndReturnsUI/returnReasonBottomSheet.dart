import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:layla_app_dev/Components/ImageComponent/imageComponent.dart';
import 'package:provider/provider.dart';
import '../../AppTheme/ColorConstants.dart';
import '../../AppTheme/fontSizes.dart';
import '../../Controllers/ExchangeAndReturnController/exchangeAndReturnController.dart';
import '../../Utils/Globals.dart';
import '../../Widgets/Buttons/CustomFilledButton.dart';
import '../../Widgets/Images/AppLogo.dart';
import '../../Widgets/Images/NetworkImage.dart';

class ReturnReasonBottomSheet extends StatefulWidget {
  const ReturnReasonBottomSheet({super.key});

  @override
  State<ReturnReasonBottomSheet> createState() => _ReturnReasonBottomSheetState();
}

class _ReturnReasonBottomSheetState extends State<ReturnReasonBottomSheet> {
  bool isDetailPage = false;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<ExchangeAndReturnController>(builder: (context, returnProvider, child) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.sp),
        child: Wrap(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isDetailPage
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            isDetailPage = false;
                          });
                        },
                        child: SizedBox(
                          height: 30.sp,
                          width: 30.sp,
                          child: Center(
                              child: Icon(
                            CupertinoIcons.back,
                            size: 22.sp,
                          )),
                        ),
                      )
                    : SizedBox(
                        width: 30.sp,
                      ),
                // productData.images.isNotEmpty
                //     ? appNetworkImage(productData.image, 75.w, double.infinity, BoxFit.contain)
                //     :
                Container(
                  width: 75.w,
                  height: 100.sp,
                  color: ColorConstants.secondaryColor.withOpacity(0.5),
                  child: AppLogo(),
                ),
                isDetailPage
                    ? SizedBox(
                        width: 30.sp,
                      )
                    : InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          height: 30.sp,
                          width: 30.sp,
                          child: Center(
                              child: Icon(
                            CupertinoIcons.clear,
                            size: 22.sp,
                          )),
                        ),
                      )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.sp),
              child: Text(
                isDetailPage ? "Let us know more details" : "Why are you returning this item?",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: FontSizes.largeText,
                ),
              ),
            ),
            isDetailPage
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Images",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: FontSizes.normalText1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Please upload max 6 images",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: ColorConstants.textColorGrey.withOpacity(0.8),
                          fontSize: FontSizes.extraSmallText,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Flexible(
                        child: GridView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(bottom: 5.sp),
                            itemCount: returnProvider.imageFiles.length <= 5
                                ? returnProvider.imageFiles.length + 1
                                : returnProvider.imageFiles.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              return returnProvider.imageFiles.length < 6 && index == returnProvider.imageFiles.length
                                  ? InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        returnProvider.setContainerHeight(100.sp);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: DottedBorder(
                                              dashPattern: const [5, 3],
                                              color: ColorConstants.textColorGrey.withOpacity(0.6),
                                              radius: Radius.circular(10.r),
                                              borderType: BorderType.RRect,
                                              child: Center(
                                                child: Container(
                                                  width: size.width,
                                                  decoration: BoxDecoration(color: ColorConstants.dullWhite),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        CupertinoIcons.add,
                                                        size: 15.sp,
                                                        color: ColorConstants.textColorGrey.withOpacity(0.6),
                                                      ),
                                                      SizedBox(
                                                        height: 5.sp,
                                                      ),
                                                      Text(
                                                        "Max Size: 5MB",
                                                        style: TextStyle(
                                                            fontSize: 8.sp, color: ColorConstants.textColorGrey.withOpacity(0.6)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        returnProvider.removeImage(index);
                                      },
                                      child: AspectRatio(
                                          aspectRatio: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                                              child: Image.file(
                                                returnProvider.imageFiles[index],
                                                width: double.infinity,
                                                height: double.infinity,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          )),
                                    );
                            }),
                      ),
                      returnProvider.imageFiles.isNotEmpty
                          ? Padding(
                              padding: EdgeInsets.only(bottom: 10.sp),
                              child: Text(
                                "*Tap on image to remove",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: ColorConstants.textColorGrey.withOpacity(0.8),
                                  fontSize: FontSizes.extraSmallText,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            )
                          : SizedBox()
                    ],
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: returnReasonsList.length,
                    padding: EdgeInsets.only(bottom: 25.sp),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.sp),
                        child: InkWell(
                          onTap: () {
                            returnProvider.setReason(returnReasonsList[index]);
                            setState(() {
                              isDetailPage = true;
                            });
                          },
                          child: Container(
                            height: 35.sp,
                            width: size.width,
                            decoration: BoxDecoration(color: ColorConstants.dullWhite, borderRadius: BorderRadius.circular(5.r)),
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  returnReasonsList[index],
                                  style: TextStyle(fontSize: FontSizes.smallText, fontWeight: FontWeight.w400),
                                ),
                                Icon(
                                  CupertinoIcons.forward,
                                  size: FontSizes.smallText,
                                  color: ColorConstants.textColorGrey.withOpacity(0.6),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
            isDetailPage
                ? Padding(
                    padding: EdgeInsets.only(bottom: 20.sp),
                    child: CustomFilledButton(
                      title: "Done",
                      textColor: ColorConstants.baseColor,
                      height: 35.sp,
                      width: size.width,
                      btnColor: ColorConstants.primaryColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                : SizedBox(),
            isDetailPage ? AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: returnProvider.animatedContainerHeight,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    dense: true,
                    leading: Icon(
                      FontAwesomeIcons.images,
                      size: 20.sp,
                    ),
                    title: Text(
                      "Choose from library",
                      style: TextStyle(fontSize: FontSizes.smallText, fontWeight: FontWeight.w400),
                    ),
                    onTap: () {
                      ImageComponent().imgFromGallery(context, picker, returnProvider);
                      returnProvider.setContainerHeight(0.0);
                    },
                  ),
                  ListTile(
                    dense: true,
                    leading: Icon(
                      FontAwesomeIcons.camera,
                      size: 20.sp,
                    ),
                    title: Text(
                      "Take Photo",
                      style: TextStyle(fontSize: FontSizes.smallText, fontWeight: FontWeight.w400),
                    ),
                    onTap: () {
                      ImageComponent().imgFromCamera(context, picker, returnProvider);
                      returnProvider.setContainerHeight(0.0);
                    },
                  ),
                ],
              ),
            ): SizedBox()
          ],
        ),
      );
    });
  }
}
