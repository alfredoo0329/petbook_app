import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider {
  // ignore: non_constant_identifier_names
  Future<LatLng> getLocation(String address) async {
    final List<Address> addresses =
        await Geocoder.local.findAddressesFromQuery(address);
    final Coordinates coordinates = addresses.first.coordinates;
    final LatLng latLng = LatLng(coordinates.latitude, coordinates.longitude);
    return latLng;
  }
}
