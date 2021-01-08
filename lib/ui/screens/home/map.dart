import 'package:community_support/ui/widget/input.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  GoogleMapController mapController;
  Circle circle;
  Marker marker;
  LatLng newLatLang;

  @override
  void initState() {
    _getLocation();
    super.initState();
  }

  _getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    LocationData locationData = await location.getLocation();
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 12,
          target: LatLng(locationData.latitude, locationData.longitude),
        ),
      ),
    );

   Marker m = Marker(
      markerId: MarkerId('markId'),
      position: LatLng(locationData.latitude, locationData.longitude),
      infoWindow: InfoWindow(
        title: 'Your current location',
        snippet: 'Drag to change location!'
      ),
      onDragEnd: (LatLng latlng){
        newLatLang = latlng;
        print(newLatLang.longitude + newLatLang.latitude);
      }
    );

    Circle c = Circle(
      radius: 1000,
      center: LatLng(locationData.latitude, locationData.longitude),
      circleId: CircleId('circleId'),
      fillColor: Colors.amber.withOpacity(0.2),
      strokeWidth: 0,
    );
    if(mounted){
      setState(() {
        circle = c;
        marker = m;
      });
    }

  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('assets/png/home.png'))),
      child: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            zoomControlsEnabled: false,
            myLocationEnabled: false,
            circles: circle == null ? {} : {circle},
            markers: marker == null ? {} : {marker},
            initialCameraPosition: CameraPosition(
              target: LatLng(6.185123, 6.979588),
              zoom: 14.0,
            ),
          ),
          RoundedInput(
            elevation: true,
            label: 'Search',
            preIcon: Icons.search,
          ),
        ],
      ),
    );
  }
}
