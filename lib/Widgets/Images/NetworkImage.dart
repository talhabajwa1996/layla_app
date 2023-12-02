import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shimmer/shimmer.dart';
import 'package:websafe_svg/websafe_svg.dart';
import '../../AppTheme/ColorConstants.dart';
import '../Loaders/AppLoader.dart';

Widget appNetworkImage(String? url, double? width, double? height, BoxFit boxFit,
    {Color? imageColor,
    Color? svgColor,
    bool showLoadingShimmers = false,
    bool showLoading = true,
    bool showErrorWidget = true,
    Color? svgBackgroundColor,
    Alignment alignment = Alignment.center,
    BoxFit? svgBoxFit}) {
  String imageType = url != null && url.isNotEmpty ? url.substring(url.length - 3) : "";

  return (url != null && url.isNotEmpty && url.length > 4)
      ? kIsWeb
          ? Image.network(
              url,
              fit: boxFit,
              width: width,
              alignment: alignment,
              height: height,
              color: imageType == 'svg' ? svgColor : imageColor,
            )
          : url.substring(url.length - 3) == 'svg'
              ? Material(
                  color: svgBackgroundColor ?? ColorConstants.transparent,
                  child: kIsWeb
                      ? WebsafeSvg.network(url,
                          fit: svgBoxFit ?? boxFit,
                          width: width,
                          alignment: alignment,
                          colorFilter: ColorFilter.mode(
                            svgColor!,
                            BlendMode.srcIn,
                          ),
                          height: height,
                          placeholderBuilder: (BuildContext context) => showLoadingShimmers
                              ? Shimmer.fromColors(
                                  direction: ShimmerDirection.ltr,
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    color: ColorConstants.transparent,
                                  ))
                              : Center(child: AppLoader()))

                      // WebsafeSvg.network(url ?? "",
                      //     fit: svgBoxFit ?? boxFit,
                      //     width: width,
                      //     alignment: alignment,
                      //     color: svgColor,
                      //     height: height,
                      //     placeholderBuilder: (BuildContext context) => showLoadingShimmers
                      //         ? Shimmer.fromColors(
                      //             direction: ShimmerDirection.ltr,
                      //             baseColor: Colors.grey[300]!,
                      //             highlightColor: Colors.grey[100]!,
                      //             child: Container(
                      //               color: ColorConstants.transparent,
                      //             ))
                      //         : Center(child: AppLoader()))
                      : CachedNetworkSVGImage(url ?? "",
                          fit: svgBoxFit ?? boxFit,
                          width: width,
                          alignment: alignment,
                          color: svgColor,
                          height: height,
                          placeholderBuilder: (BuildContext context) => showLoadingShimmers
                              ? Shimmer.fromColors(
                                  direction: ShimmerDirection.ltr,
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    color: ColorConstants.transparent,
                                  ))
                              : Center(child: AppLoader())),
                )
              : CachedNetworkImage(
                  fit: boxFit,
                  imageUrl: url ?? "",
                  width: width,
                  alignment: alignment as Alignment,
                  color: imageColor,
                  height: height,
                  progressIndicatorBuilder: (context, url, downloadProgress) => showLoading
                      ? showLoadingShimmers
                          ? Shimmer.fromColors(
                              direction: ShimmerDirection.ltr,
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                color: ColorConstants.transparent,
                              ))
                          : Center(child: AppLoader())
                      : SizedBox(),
                  errorWidget: (context, url, error) => showErrorWidget
                      ? Icon(CupertinoIcons.nosign)
                      : SizedBox(),
                )
      : SizedBox();
}

// Future<void> _precache(dynamic imageUrl) async {
//     await precachePicture(
//       NetworkPicture(
//         WebsafeSvg.svgByteDecoderBuilder,
//         imageUrl,
//       ),
//       null,
//     );
// }
