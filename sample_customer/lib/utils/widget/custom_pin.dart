import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//Set Custom Pin Marker
class CustomPin {
  BitmapDescriptor _pinLocationIcon1, _pinLocationIcon2;
  BitmapDescriptor get pinLocationIcon1 => _pinLocationIcon1;
  BitmapDescriptor get pinLocationIcon2 => _pinLocationIcon2;
  void setCustomMapPin() async {
    _pinLocationIcon1 = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5, size: Size(40, 40)),
        'assets/ic_pick.png');

    _pinLocationIcon2 = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5, size: Size(40, 40)),
        'assets/destination_map_marker.png');
  }
}

final customPin = CustomPin();
