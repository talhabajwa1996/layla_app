import 'package:flutter/material.dart';
import 'package:layla_app_dev/Utils/Constants/ColorConstants.dart';

class MenuCategoryCard extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;

  const MenuCategoryCard({this.title, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: ColorConstants.cardBackground,
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 100,
              width: double.infinity,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title!.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.textCategories),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
