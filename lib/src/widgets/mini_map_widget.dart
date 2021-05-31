import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petbook_app/src/providers/location_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

class MiniMap extends StatelessWidget {
  final LocationProvider _locationProvider = LocationProvider();
  final String address;
  final String title;

  MiniMap({@required this.address, this.title});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _locationProvider.getLocation(address),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return _getMap(context, snapshot.data, address, title);
            default:
              return _getLoadingWidget(context);
          }
        });
  }

  Widget _getMap(
      BuildContext context, LatLng latLng, String address, String title) {
    String mapStyle;
    rootBundle.loadString('assets/styles/map_style.txt').then((string) {
      mapStyle = string;
    });

    Completer<GoogleMapController> _controller = Completer();
    MapType mapType = MapType.normal;

    final CameraPosition _puntoInicial =
        CameraPosition(target: latLng, zoom: 17.5, tilt: 55);

    Set<Marker> markers = new Set<Marker>();
    markers.add(Marker(
      markerId: MarkerId('shelter'),
      position: latLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(208),
    ));

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      height: 300,
      child: Hero(
        tag: 'map-${latLng.latitude}',
        child: GoogleMap(
          myLocationButtonEnabled: false,
          scrollGesturesEnabled: false,
          mapType: mapType,
          markers: markers,
          initialCameraPosition: _puntoInicial,
          onMapCreated: (GoogleMapController controller) {
            controller.setMapStyle(mapStyle);
            if (!_controller.isCompleted) _controller.complete(controller);
          },
          onTap: (_) {
            Navigator.pushNamed(context, 'map', arguments: {
              'latLng': latLng,
              'info': address,
              'style': mapStyle,
              'title': title
            });
          },
        ),
      ),
    );
  }

  Widget _getLoadingWidget(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      child: CircularProgressIndicator(
        valueColor:
            new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
      ),
    );
  }
}
