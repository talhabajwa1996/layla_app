import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:layla_app_dev/Models/MarkersModel/markersListModel.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class LocationController extends ChangeNotifier {
  MarkersListModel? markersList;
  List<Marker> markers = <Marker>[];
  List<ShopLocationData> shopLocations = [];
  int selectedIndex = -1;
  AutoScrollController? controller;

  initializeMarkers() {
    controller = AutoScrollController();
    shopLocations.clear();
    MarkersListModel markersList = MarkersListModel.fromJson(markersJson);
    for (int i = 0; i < markersList.marker!.length; i++) {
      shopLocations.add(markersList.marker![i]);
      markers.add(Marker(
          consumeTapEvents: false,
          zIndex: 10,
          markerId: MarkerId(markersList.marker![i].name.toString()),
          position: LatLng(double.parse(markersList.marker![i].lat!), double.parse(markersList.marker![i].lng!)),
          infoWindow: InfoWindow(
            title: markersList.marker![i].name,
          ),
          onTap: () {
            setIndex = i;
            controller?.scrollToIndex(selectedIndex, preferPosition: AutoScrollPosition.begin);
          }));
    }
    notifyListeners();
  }

  getPhoneNumbers(){
    shopLocations.clear();
    MarkersListModel markersList = MarkersListModel.fromJson(markersJson);
    for (int i = 0; i < markersList.marker!.length; i++) {
      shopLocations.add(markersList.marker![i]);
    }
    notifyListeners();
    return shopLocations;
  }

  set setIndex(value) {
    selectedIndex = value;
    notifyListeners();
  }
}
