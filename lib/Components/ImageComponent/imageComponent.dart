import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:layla_app_dev/Controllers/ExchangeAndReturnController/exchangeAndReturnController.dart';
import 'package:layla_app_dev/Widgets/Notifiers/Toast.dart';
import 'dart:io';

import '../../Utils/HelperFunctions.dart';

class ImageComponent{

  imgFromCamera(BuildContext context, ImagePicker picker, ExchangeAndReturnController returnProvider) async {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        File image0 = File(image.path);
        HelperFunctions().compressImage(image0).then((value) {
          returnProvider.addImage(value);
        });
      }
  }

  imgFromGallery(BuildContext context, ImagePicker picker, ExchangeAndReturnController returnProvider) async {
    final List<XFile?> image = await picker.pickMultiImage();
    if (image.isNotEmpty) {
      print("Length:: ${image.length}");
      if(image.length < 7){
        for(var i in image){
          File image0 = File(i!.path);
          HelperFunctions().compressImage(image0).then((value) {
            returnProvider.addImage(value);
          });
        }
      }else{
        showToast("Please select max 6 images");
      }

    }
  }
}