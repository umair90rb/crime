import 'package:community_support/ui/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GetLocationFromMap extends StatefulWidget {
  @override
  _GetLocationFromMapState createState() => _GetLocationFromMapState();
}

class _GetLocationFromMapState extends State<GetLocationFromMap> {
  GoogleMapController mapController;
  LatLng newLatLng;
  Marker marker;

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
        draggable: true,
        onDragEnd: (LatLng latlng){
          newLatLng = latlng;
          print(newLatLng.longitude.toString() +" "+ newLatLng.latitude.toString());
        }
    );

    setState(() {
      marker = m;
    });

  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
        backgroundColor: Colors.amber,
        toolbarHeight: 100,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pop(context, newLatLng),
        label: Text('Select Location'),
        backgroundColor: Colors.amber,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            zoomControlsEnabled: false,
            myLocationEnabled: false,
            markers: marker == null ? {} : {marker},
            initialCameraPosition: CameraPosition(
              target: LatLng(31.494010, 73.274050),
              zoom: 6.0,
            ),
          ),
        ],
      ),
    );
  }
}
