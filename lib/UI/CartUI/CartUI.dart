import 'package:flutter/material.dart';
import 'package:layla_app_dev/Components/Cart/Cart.dart' as cartComponent;
import 'package:layla_app_dev/Models/CartModels/RetrieveCartResponseModel.dart';
import 'package:layla_app_dev/Services/API/ServerResponse.dart';
import 'package:layla_app_dev/Services/CartServices/CartServices.dart';
import '../../AppTheme/ColorConstants.dart';
import '../../Widgets/Buttons/CustomFilledButton.dart';
import '../../Widgets/Loaders/AppLoader.dart';
import '../ErrorUI/ErrorUI.dart';

class CartUI extends StatefulWidget {
  const CartUI({super.key});

  @override
  State<CartUI> createState() => _CartUIState();
}

class _CartUIState extends State<CartUI> {
  Future<ServerResponse<RetrieveCartResponseModel>>? _retrieveCartData;

  @override
  void initState() {
    _retrieveCartData = CartServices().retrieveCart(context);
    super.initState();
  }

  Future<void> _onRefresh() async {
    setState(() {
      _retrieveCartData = CartServices().retrieveCart(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: FutureBuilder<ServerResponse<RetrieveCartResponseModel>>(
            future: _retrieveCartData!,
            builder: (BuildContext context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: AppLoader());
                default:
                  if (snapshot.hasData) {
                    switch (snapshot.data!.status!) {
                      case Status.LOADING:
                        return const Center(child: AppLoader());
                      case Status.COMPLETED:
                        return const cartComponent.Cart();
                      case Status.ERROR:
                        return ShowError(
                          height: double.infinity,
                          errorMessage: snapshot.data!.message,
                          onRetryPressed: () => setState(
                            () => _retrieveCartData =
                                CartServices().retrieveCart(context),
                          ),
                        );
                    }
                  }
                  return Container();
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: Padding(
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
      ),
    );
  }
}
