import 'package:flutter/material.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/Utils/Constants/ImageConstants.dart';

class EmptyList extends StatelessWidget {
  final String? message;

  const EmptyList({this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(ImageConstants.emptyList),
        const SizedBox(height: 30),
        Text(
          message ?? "No Items",
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: ColorConstants.grey),
        )
      ],
    );
  }
}
