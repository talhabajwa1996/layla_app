import 'package:flutter/material.dart';
import 'package:layla_app_dev/Components/Cart/CartItemCard.dart';
import 'package:layla_app_dev/Services/API/ServerResponse.dart';
import 'package:layla_app_dev/Services/CartServices/CartServices.dart';
import 'package:layla_app_dev/Widgets/EmptyList.dart';
import 'package:layla_app_dev/Widgets/Notifiers/Toast.dart';
import 'package:provider/provider.dart';
import '../../AppTheme/ColorConstants.dart';
import '../../Controllers/CartControllers/CartController.dart';
import '../../UI/ProductUI/productDetail.dart';
import '../../Widgets/Buttons/CustomFilledButton.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child:
          Consumer<CartController>(builder: (context, cartController, child) {
        var cartItems = cartController.retrieveCartResponse!.cart!.lines!.nodes;
        return cartItems != null && cartItems.isNotEmpty
            ? SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
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
                                .firstWhere(
                                    (element) => element.name == 'Color')
                                .value,
                            size: cartItems[index]
                                .merchandise!
                                .selectedOptions!
                                .firstWhere((element) => element.name == 'Size')
                                .value,
                            image: cartItems[index].merchandise!.image != null
                                ? cartItems[index].merchandise!.image!.url
                                : "",
                            quantity: cartItems[index].quantity.toString(),
                            totalPrice:
                                "${cartItems[index].cost!.totalAmount!.currencyCode} ${double.parse(cartItems[index].cost!.totalAmount!.amount!).toStringAsFixed(3)}",
                            onIncrement: () async => await CartServices()
                                .updateCartLine(
                                    context,
                                    cartItems[index].merchandise!.id!,
                                    cartItems[index].id!,
                                    cartItems[index].quantity! + 1)
                                .then((response) {
                              if (response.status == Status.ERROR) {
                                showToast(response.message!);
                              }
                            }),
                            onDecrement: () async => await CartServices()
                                .updateCartLine(
                                    context,
                                    cartItems[index].merchandise!.id!,
                                    cartItems[index].id!,
                                    cartItems[index].quantity! - 1)
                                .then((response) {
                              if (response.status == Status.ERROR) {
                                showToast(response.message!);
                              }
                            }),
                            onRemove: () async => await CartServices()
                                .updateCartLine(
                                    context,
                                    cartItems[index].merchandise!.id!,
                                    cartItems[index].id!,
                                    0)
                                .then((response) {
                              if (response.status == Status.ERROR) {
                                showToast(response.message!);
                              }
                            }),
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
                    const Divider(),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text('Subtotal',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(width: 50),
                        Text(
                            '${cartController.retrieveCartResponse!.cart!.cost!.subtotalAmount!.currencyCode} ${double.parse(cartController.retrieveCartResponse!.cart!.cost!.subtotalAmount!.amount!).toStringAsFixed(3)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16))
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text('Total',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(width: 50),
                        Text(
                            '${cartController.retrieveCartResponse!.cart!.cost!.totalAmount!.currencyCode} ${double.parse(cartController.retrieveCartResponse!.cart!.cost!.totalAmount!.amount!).toStringAsFixed(3)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16))
                      ],
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomFilledButton(
                        height: 35,
                        width: MediaQuery.of(context).size.width * 0.9,
                        title: 'Checkout',
                        btnColor: ColorConstants.primaryColor,
                        textColor: ColorConstants.white,
                        btnRadius: 5,
                        onPressed: () async {},
                      ),
                    )
                  ],
                ),
              )
            : const Center(child: EmptyList(message: 'Cart is Empty'));
      }),
    );
  }
}
