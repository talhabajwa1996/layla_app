import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:layla_app_dev/AppTheme/ColorConstants.dart';
import 'package:layla_app_dev/AppTheme/fontSizes.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../Controllers/LocationController/locationController.dart';
import '../../Models/MarkersModel/markersListModel.dart';
import '../../Widgets/CustomAppBar/LogoAppBar.dart';

class OurLocationsUI extends StatefulWidget {
  const OurLocationsUI({super.key});

  @override
  State<OurLocationsUI> createState() => _OurLocationsUIState();
}

class _OurLocationsUIState extends State<OurLocationsUI> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  LocationController? locationProvider;


  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(29.1744729, 48.0979973),
    zoom: 10,
  );

  @override
  void initState() {
    // TODO: implement initState
    locationProvider = Provider.of<LocationController>(context, listen: false);
    Future.delayed(Duration.zero, () {
      locationProvider?.initializeMarkers();
    });
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<LocationController>(builder: (context, locationProvider, child) {
      return Scaffold(
        appBar: logoAppBar(
            showBackButton: true,
            onBackTap: () {
              Navigator.of(context).pop();
            }),
        body: Padding(
            padding: EdgeInsets.all(18.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    color: ColorConstants.dullWhite,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  height: 200.sp,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.r),
                    child: GoogleMap(
                      myLocationEnabled: true,
                      zoomControlsEnabled: true,
                      myLocationButtonEnabled: true,
                      mapType: MapType.normal,
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      markers: Set<Marker>.of(locationProvider.markers),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.sp,
                ),
                Text(
                  "Our Locations",
                  style: TextStyle(fontSize: FontSizes.largeText, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      controller: locationProvider.controller,
                      padding: EdgeInsets.zero,
                      itemCount: locationProvider.shopLocations.length,
                      itemBuilder: (context, index) {
                        ShopLocationData? locationData = locationProvider.shopLocations[index];
                        return AutoScrollTag(

                          key: ValueKey(index.toString()),
                          controller: locationProvider.controller!,
                          index: index,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.sp),
                            child: InkWell(
                              onTap: () async {
                                final GoogleMapController controller = await _controller.future;
                                controller.showMarkerInfoWindow(MarkerId(locationData.name.toString()));
                                await controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                                  target: LatLng(double.parse(locationData.lat!), double.parse(locationData.lng!)),
                                  zoom: 13,
                                )));
                                locationProvider.setIndex = index;
                              },
                              child: Container(
                                width: size.width,
                                // height: 150.sp,
                                decoration: BoxDecoration(
                                    color: ColorConstants.dullWhite,
                                    borderRadius: BorderRadius.circular(5.r),
                                    border: locationProvider.selectedIndex == index
                                        ? Border.all(color: ColorConstants.textColorGrey.withOpacity(0.1))
                                        : Border(),
                                    boxShadow: [
                                      BoxShadow(
                                          color: ColorConstants.textColorGrey.withOpacity(0.1), spreadRadius: 0.5, blurRadius: 10)
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        CupertinoIcons.map_pin_ellipse,
                                        size: 22.sp,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              locationData?.name! ?? "",
                                              style: TextStyle(fontSize: FontSizes.normalText1, fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 5.sp,
                                            ),
                                            Text(
                                              locationData.address! ?? "",
                                              style: TextStyle(
                                                  fontSize: FontSizes.smallText,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorConstants.textColorGrey.withOpacity(0.8)),
                                            ),
                                            Text(
                                              "${locationData.city}, ${locationData.postal}",
                                              style: TextStyle(
                                                  fontSize: FontSizes.smallText,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorConstants.textColorGrey.withOpacity(0.8)),
                                            ),
                                            Text(
                                              locationData.phone! ?? "",
                                              style: TextStyle(
                                                  fontSize: FontSizes.smallText,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorConstants.textColorGrey.withOpacity(0.8)),
                                            ),
                                            SizedBox(
                                              height: 5.sp,
                                            ),
                                            InkWell(
                                              onTap: (){
                                                MapsLauncher.launchCoordinates(double.parse(locationData.lat!), double.parse(locationData.lng!));
                                              },
                                              child: Text(
                                                "Directions",
                                                style: TextStyle(
                                                    fontSize: FontSizes.smallText,
                                                    fontWeight: FontWeight.w400,
                                                    color: ColorConstants.secondary1Color,
                                                    decoration: TextDecoration.underline),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            )),
      );
    });
  }
}
