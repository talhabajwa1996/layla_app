import 'package:flutter/material.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/Utils/Constants/AppIcons.dart';
import 'package:layla_app_dev/Widgets/Images/NetworkImage.dart';

class CheckoutItemCard extends StatelessWidget {
  final String? image;
  final String? title;
  final String? totalPrice;
  final String? size;
  final String? color;
  final String? quantity;

  const CheckoutItemCard(
      {this.title,
      this.size,
      this.image,
      this.quantity,
      this.color,
      this.totalPrice,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: appNetworkImage(image, 40, double.infinity, BoxFit.contain),
                ),
                SizedBox(
                  width: 50,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: ColorConstants.black,
                      child: Text(
                        quantity!,
                        style: TextStyle(color: ColorConstants.white, fontSize: 12),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title ?? "",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        Text("$size / $color"),
                      ],
                    ),
                    Text(totalPrice ?? "KWD 0",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
