import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Utils/Constants/ColorConstants.dart';
import '../../Utils/HelperFunctions.dart';
import '../Buttons/CustomElevatedButton.dart';

Future<dynamic> customBottomSheet(BuildContext context,
    {List<String>? selectionOptions,
    String? title,
    int? initialIndex,
    required void Function(int) onSelectedItemChanged}) async {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext buildContext) {
      return SizedBox(
          height: 500,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  title ?? "",
                  style: const TextStyle(
                      color: ColorConstants.textColorGrey,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                      initialItem: initialIndex ?? 0),
                  // backgroundColor: Colors.white,
                  onSelectedItemChanged: onSelectedItemChanged,
                  itemExtent: 40,
                  magnification: 1,
                  children: List.generate(
                    selectionOptions!.length,
                    (index) => Center(
                      child: Text(
                        selectionOptions[index],
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: CustomElevatedButton.solid(
                    title: localizedText(context).submit,
                    onPressed: () => Navigator.pop(context)),
              )
            ],
          ));
    },
  );
}
