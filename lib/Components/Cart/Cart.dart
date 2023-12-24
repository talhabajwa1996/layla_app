import 'package:flutter/material.dart';
import 'package:layla_app_dev/Components/Cart/CartItemCard.dart';
import 'package:provider/provider.dart';
import '../../Controllers/CartControllers/CartController.dart';
import '../../UI/ProductUI/productDetail.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child:
          Consumer<CartController>(builder: (context, cartController, child) {
        var cartItems = cartController.retrieveCartResponse!.cart!.lines!.nodes;
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ITEMS:  ${cartItems!.length}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 13),
                ),
                Text(
                    'TOTAL:   ${cartController.retrieveCartResponse!.cart!.cost!.totalAmount!.currencyCode} ${cartController.retrieveCartResponse!.cart!.cost!.totalAmount!.amount}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 13)),
              ],
            ),
            const Divider(),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return CartItemCard(
                    title: cartItems[index].merchandise!.product!.title,
                    color: cartItems[index]
                        .merchandise!
                        .selectedOptions!
                        .firstWhere((element) => element.name == 'Color')
                        .value,
                    size: cartItems[index]
                        .merchandise!
                        .selectedOptions!
                        .firstWhere((element) => element.name == 'Size')
                        .value,
                    image:  cartItems[index].merchandise!.image != null ? cartItems[index].merchandise!.image!.url : "",
                    quantity: cartItems[index].quantity.toString(),
                    totalPrice:
                        "${cartItems[index].merchandise!.price!.currencyCode} ${cartItems[index].merchandise!.price!.amount}",
                    onIncrement: () {},
                    onDecrement: () {},
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProductDetail(
                                productId: cartItems[index]
                                    .merchandise!
                                    .product!
                                    .id!))),
                  );
                }),
            const SizedBox(height: 30),
          ],
        );
      }),
    );
  }
}
