import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/AppTheme/fontSizes.dart';
import '../../Widgets/CustomAppBar/LogoAppBar.dart';
import '../../Widgets/CustomExpandedListTile/expandedListTile.dart';

class FAQsUI extends StatefulWidget {
  const FAQsUI({super.key});

  @override
  State<FAQsUI> createState() => _FAQsUIState();
}

class _FAQsUIState extends State<FAQsUI> {
  int currentSelection = -1;
  final List<FAQs> faqs = [
    FAQs(
        "Do you provide delivery services?",
        "YES, we deliver to all areas in KUWAIT\n \n"
            "We also ship to all GCC Countries."),
    FAQs(
        "How do I order?",
        "- Choose your favorite item from app, add them to your cart and ship them to your country.\n\n"
            "- Or send your order to our Whatsapp +96555509422"),
    FAQs("I don't know how to order!",
        "Kindly refer to our instagram account and check out the Story Highlights that explain how an order is complete."),
    FAQs(
      "What products are available?",
      "- All products published on the website or app\n\n"
          "- Almost same products are available also in our shop.",
    ),
    FAQs(
        "OUT OF STOCK products",
        "We are trying our best to provide out of stock products again as soon as possible.\n\n"
            "New Products will be added continuously."),
    FAQs(
        "How long will it take to get my order?",
        "Local Deliveries(Kuwait) => within 3 business days\n\n"
            "Overseas Deliveries => within 10 business days"),
    FAQs(
        "How can I EXCHANGE or RETURN?",
        "To Exchange or Return please visit our return portal and follow the steps\n\n"
            "IMPORTANT: Underwear, lingerie & satin wear are NON-EXCHANGEABLE & NON-REFUNDABLE"),
    FAQs(
        "How can I contact Layla's support team?",
        "You can:\n\n"
            "1. Fill the contact form on our Contact Us Page.\n"
            "2. Email: info@laylacollection.com\n"
            "3. Whatsapp number: +965 565 86099\n\n"
            "PS: Whatsapp working hours are [1:00-5:00 PM] everyday except Friday"),
  ];
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: logoAppBar(
          showBackButton: true,
          onBackTap: () {
            Navigator.of(context).pop();
          }),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: ListView(
          children: [
            Text(
              "FAQ",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: FontSizes.largeText, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10.sp,
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: faqs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.sp),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selected = index;
                        });
                      },
                      child: Text(
                        ">> ${faqs[index].question}",
                        style: TextStyle(
                            fontSize: FontSizes.smallText, fontWeight: selected == index ? FontWeight.w600 : FontWeight.w400),
                      ),
                    ),
                  );
                }),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.sp),
              child: Divider(
                color: ColorConstants.textColorGrey.withOpacity(0.5),
              ),
            ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    faqs[selected].question,
                    style: TextStyle(
                        fontSize: FontSizes.smallText, fontWeight:  FontWeight.w600),
                  ),
                  SizedBox(height: 5.sp,),
                  Text(
                    faqs[selected].answer,
                    style: TextStyle(
                        fontSize: FontSizes.smallText, fontWeight:  FontWeight.w400),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FAQs {
  final String question;
  final String answer;

  FAQs(this.question, this.answer);
}
