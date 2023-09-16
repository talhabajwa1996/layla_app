import 'package:flutter/material.dart';
import 'package:layla_app_dev/Components/MenuCategories/MenuMainCategories.dart';
import 'package:layla_app_dev/Models/MenuCollectionsModel/MenuCollectionsResponseModel.dart';
import 'package:layla_app_dev/Services/CollectionsServices/MenuCollectionsService.dart';
import 'package:layla_app_dev/Widgets/Appbars/SearchAppBar.dart';
import '../../Services/API/ServerResponse.dart';
import '../../Widgets/Loaders/AppLoader.dart';
import '../ErrorUI/ErrorUI.dart';

class MenuMainCategoriesUI extends StatefulWidget {
  final String? userId;

  const MenuMainCategoriesUI({this.userId, Key? key}) : super(key: key);

  @override
  State<MenuMainCategoriesUI> createState() => _MenuMainCategoriesUIState();
}

class _MenuMainCategoriesUIState extends State<MenuMainCategoriesUI> {
  Future<ServerResponse<MenuCollectionsResponseModel>>? _getMenuCategories;

  @override
  void initState() {
    _getMenuCategories = MenuCollectionsService().getMenuCategoriesAndSubCategories(context);
    super.initState();
  }

  Future _handleRefresh() async {
    setState(() {
      _getMenuCategories = MenuCollectionsService().getMenuCategoriesAndSubCategories(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchAppBar(),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: StreamBuilder<ServerResponse<MenuCollectionsResponseModel>>(
          stream: _getMenuCategories!.asStream(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: AppLoader());
              default:
                if (snapshot.hasData) {
                  switch (snapshot.data!.status!) {
                    case Status.LOADING:
                      return const Center(child: AppLoader());
                    case Status.COMPLETED:
                      return const MenuMainCategories();
                    case Status.ERROR:
                      return ShowError(
                          errorMessage: snapshot.data!.message,
                          onRetryPressed: () => _handleRefresh());
                  }
                }
                return ShowError(
                    height: double.infinity,
                    width: double.infinity,
                    errorMessage: "An unexpected Error Occurred",
                    onRetryPressed: () => _handleRefresh());
            }
          },
        ),
      ),
    );
  }
}
