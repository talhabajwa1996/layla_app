import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/AppTheme/fontSizes.dart';
import 'package:layla_app_dev/Controllers/AuthController/AuthController.dart';
import 'package:layla_app_dev/Controllers/DashboardController/dashboardController.dart';
import 'package:layla_app_dev/Controllers/SearchBarController/searchBarController.dart';
import 'package:layla_app_dev/Services/AuthServices/AuthServices.dart';
import 'package:layla_app_dev/Services/ShopifyServices/ShopifyServices.dart';
import 'package:layla_app_dev/Utils/Globals.dart';
import 'package:layla_app_dev/Utils/HelperFunctions.dart';
import 'package:layla_app_dev/Widgets/Buttons/customBackButton.dart';
import 'package:provider/provider.dart';
import 'package:shopify_flutter/enums/src/sort_key_product.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import '../../AppTheme/ColorConstants.dart';
import '../../Utils/Constants/ImageConstants.dart';
import '../../Utils/Constants/RouteConstants.dart';
import '../Buttons/CustomElevatedButton.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  SpeechToText speech = SpeechToText();
  bool available = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSpeech();
  }

  ///Speech Recognition Initializer and Functions

  initSpeech() async {
    available = await speech.initialize(debugLogging: true, onError: errorListener, onStatus: statusListener);
  }

  void errorListener(SpeechRecognitionError error) {
    print('Received error status: $error, listening: ${speech.isListening}');
    setState(() {
      // lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  startListening(Size size) async {
    if (available) {
      print("Listening. . .");
      speech.listen(onResult: _onSpeechResult, listenFor: Duration(seconds: 10));
      showModalBottomSheet(
          context: context,
          clipBehavior: Clip.antiAlias,
          shape: const RoundedRectangleBorder(
            // <-- SEE HERE
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          builder: (context) {
            return BottomSheetContainer(speech: speech);
          });
    } else {
      print("The user has denied the use of speech recognition.");
    }
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    print("Words:: ${result.recognizedWords.toString()}");
    Provider.of<SearchBarController>(context, listen: false).setLastWords = result.recognizedWords;
  }

  void statusListener(String status) {
    print('Received listener status: $status, listening: ${speech.isListening}');
    Provider.of<SearchBarController>(context, listen: false).setLastStatus = status;
  }

  ///

  ///Barcode Scanning Initialization
  Future<String> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    return barcodeScanRes;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer3<DashboardController, SearchBarController, AuthController>(
        builder: (context, dashboardProvider, searchbarProvider, authController, child) {
      return Row(
        children: [
          // searchbarProvider.isSearching
          //     ? Wrap(
          //         children: [
          //           CustomBackButton(
          //             onTap: () {
          //               searchbarProvider.setSearching = false;
          //             },
          //           ),
          //           SizedBox(
          //             width: 10.w,
          //           ),
          //         ],
          //       )
          //     : SizedBox(),
          Flexible(
            child: Container(
              width: size.width,
              height: 32.sp,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                  border: Border.all(color: ColorConstants.textColorGrey.withOpacity(0.2))),
              child: Center(
                child: TextField(
                  onTap: () {
                    searchbarProvider.setSearching = true;
                    dashboardProvider.setTabIndex = 1;
                  },
                  controller: searchbarProvider.searchController,
                  onSubmitted: (value) {
                    searchbarProvider.searchController.text = value;
                    searchbarProvider.searchAndFetchProducts();
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                  // The style of the input field
                  decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: "Search . . .",
                      icon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Icon(
                          CupertinoIcons.search,
                          color: ColorConstants.textColorGrey.withOpacity(0.3),
                          size: 15.sp,
                        ),
                      ),
                      hintStyle: TextStyle(color: ColorConstants.textColorGrey.withOpacity(0.3), fontSize: 14.sp, height: 1.4),
                      suffixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                startListening(size);
                              },
                              child: Icon(
                                CupertinoIcons.mic,
                                color: ColorConstants.textColorGrey.withOpacity(0.3),
                                size: 20.sp,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                scanBarcodeNormal();
                              },
                              child: Icon(
                                CupertinoIcons.barcode_viewfinder,
                                color: ColorConstants.textColorGrey.withOpacity(0.3),
                                size: 20.sp,
                              ),
                            ),
                            SizedBox(
                              width: 3.sp,
                            ),
                            Icon(
                              CupertinoIcons.camera,
                              color: ColorConstants.textColorGrey.withOpacity(0.3),
                              size: 20.sp,
                            ),
                          ],
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto),
                  // The controller of the input box
                ),
              ),
            ),
          ),
          searchbarProvider.isSearching
              ? SizedBox()
              : Wrap(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    InkWell(
                      onTap: () {
                        authController.isUserLoggedIn
                            ? Navigator.pushNamed(context, RouteConstants.settings)
                            : Navigator.pushNamed(context, RouteConstants.auth);
                      },
                      child: Container(
                        width: 32.sp,
                        height: 32.sp,
                        decoration: BoxDecoration(
                            color: ColorConstants.secondaryColor, borderRadius: BorderRadius.circular(10.r)),
                        child: Center(
                            child: authController.isUserLoggedIn
                                ? Text(
                                    HelperFunctions().getInitials(shopifyUser?.firstName ?? ""),
                                    style: TextStyle(
                                        fontSize: FontSizes.smallText,
                                        fontWeight: FontWeight.w900,
                                        color: ColorConstants.primaryColor),
                                  )
                                : Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Image.asset(ImageConstants.userIcon),
                                )),
                      ),
                    )
                  ],
                ),
        ],
      );
    });
  }
}

class BottomSheetContainer extends StatefulWidget {
  final SpeechToText speech;

  const BottomSheetContainer({super.key, required this.speech});

  @override
  State<BottomSheetContainer> createState() => _BottomSheetContainerState();
}

class _BottomSheetContainerState extends State<BottomSheetContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<SearchBarController>(builder: (context, searchbarProvider, child) {
      return Container(
        color: ColorConstants.secondaryColor,
        height: 250.sp,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    _stopListening();
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.clear)),
            ),
            Spacer(),
            Center(
              child: Text(
                widget.speech.isListening
                    ? "Listening . . ."
                    : widget.speech.isNotListening && searchbarProvider.lastWords.isEmpty
                        ? "Didn't hear anything"
                        : searchbarProvider.lastWords,
                style: TextStyle(fontSize: FontSizes.bigText, color: ColorConstants.textColorGrey, fontWeight: FontWeight.w600),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.sp),
              child: CustomElevatedButton.solid(
                  title: "Listen Again",
                  onPressed: () {
                    searchbarProvider.resetProvider();
                    widget.speech.listen(onResult: _onSpeechResult, listenFor: Duration(seconds: 10));
                  }),
            )
          ],
        ),
      );
    });
  }

  void _stopListening() async {
    print("Stopping. . .");
    await widget.speech.stop();
    setState(() {});
    print("Stopped");
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    print("Words:: ${result.recognizedWords.toString()}");
    Provider.of<SearchBarController>(context, listen: false).setLastWords = result.recognizedWords;
  }
}
