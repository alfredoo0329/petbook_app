import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;
    LatLng latLng = arguments['latLng'];
    String address = arguments['info'];
    String mapStyle = arguments['style'];
    String title = arguments['title'];

    final CameraPosition _puntoInicial =
        CameraPosition(target: latLng, zoom: 17.5, tilt: 55);

    Set<Marker> markers = new Set<Marker>();
    markers.add(Marker(
      markerId: MarkerId('details'),
      position: latLng,
      infoWindow: InfoWindow(title: '$address'),
      icon: BitmapDescriptor.defaultMarkerWithHue(208),
    ));

    return Scaffold(
      appBar: _getAppBar(context, title),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Hero(
          tag: 'map-${latLng.latitude}',
          child: GoogleMap(
            myLocationButtonEnabled: false,
            mapType: mapType,
            markers: markers,
            initialCameraPosition: _puntoInicial,
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(mapStyle);
              if (!_controller.isCompleted) _controller.complete(controller);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.satellite_rounded),
        onPressed: () {
          setState(() {
            if (mapType == MapType.normal) {
              mapType = MapType.satellite;
            } else {
              mapType = MapType.normal;
            }
          });
        },
      ),
    );
  }

  Widget _getAppBar(BuildContext context, String title) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      centerTitle: true,
      title: Text(title, style: TextStyle(color: Colors.white)),
      iconTheme: IconThemeData(color: Colors.white),
    );
  }
}
