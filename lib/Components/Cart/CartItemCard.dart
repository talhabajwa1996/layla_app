import 'package:flutter/material.dart';
import 'package:layla_app_dev/Widgets/Images/NetworkImage.dart';

class CartItemCard extends StatelessWidget {
  final String? image;
  final String? title;
  final String? totalPrice;
  final String? size;
  final String? color;
  final String? quantity;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onRemove;
  final VoidCallback? onTap;

  const CartItemCard(
      {this.title,
      this.size,
      this.image,
      this.quantity,
      this.color,
      this.onDecrement,
      this.onIncrement,
      this.onTap,
      this.onRemove,
      this.totalPrice,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              appNetworkImage(image, 100, double.infinity, BoxFit.contain),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title ?? "",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Size: $size"),
                            Text("Color: $color"),
                            const Expanded(child: SizedBox()),
                            Row(
                              children: [
                                InkWell(
                                  onTap: onDecrement,
                                  child: Container(
                                      height: 25,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color:
                                                  Colors.black.withOpacity(0.1))),
                                      child: const Center(
                                        child: Text('-',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      )),
                                ),
                                Container(
                                    height: 25,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color:
                                                Colors.black.withOpacity(0.1))),
                                    child: Center(
                                      child: Text(quantity!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    )),
                                InkWell(
                                  onTap: onIncrement,
                                  child: Container(
                                      height: 25,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color:
                                                  Colors.black.withOpacity(0.1))),
                                      child: const Center(
                                        child: Text('+',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                        Text(totalPrice ?? "0",
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
