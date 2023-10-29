import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../AppTheme/ColorConstants.dart';
import '../../AppTheme/fontSizes.dart';
import '../../Widgets/Buttons/customBackButton.dart';

class ProductUI extends StatefulWidget {
  final Map<String, dynamic>? args;
  const ProductUI({super.key, this.args});

  @override
  State<ProductUI> createState() => _ProductUIState();
}

class _ProductUIState extends State<ProductUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(left: 15.w, top: 8.sp, bottom: 8.sp),
          child: CustomBackButton(
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          "Back",
          style: TextStyle(fontSize: FontSizes.normalText1, color: ColorConstants.primaryColor, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
