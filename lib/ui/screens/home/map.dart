import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_support/services/db_services.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place/search_map_place.dart';


class Map extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  Map(this.scaffoldKey);
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> with AutomaticKeepAliveClientMixin {


  @override
  bool get wantKeepAlive => true;

  GoogleMapController mapController;
  Circle circle;
  List<Marker> markers = List();
  LatLng newLatLang;
  loc.LocationData userLocation;
  DbServices db = DbServices();
  
  getIncidents() async {
    List<QueryDocumentSnapshot> crimes = await db.getSnapshot('crimes');
    crimes.map((e){
      Marker m = Marker(
          markerId: MarkerId(e['uid']),
          position: LatLng(e['incidentLat'], e['incidentLong']),
          infoWindow: InfoWindow(
              title: e['incidentType'],
              snippet: "${e['incidentTime']} ${e['incidentDate']}"
          ),
      );
      markers.add(m);
    });
  }

  generateCode(){
    Random random = Random.secure();
    return random.nextInt(99999999);
  }

  @override
  void initState() {
    _getLocation();
    super.initState();
  }

  _getLocation() async {
    loc.Location location = new loc.Location();

    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }
    loc.LocationData locationData = await location.getLocation();
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 12,
          target: LatLng(locationData.latitude, locationData.longitude),
        ),
      ),
    );

    int mId = generateCode();
    Marker m = Marker(
        markerId: MarkerId(mId.toString()),
        position: LatLng(locationData.latitude, locationData.longitude),
        infoWindow: InfoWindow(
            title: 'Your current location',
            snippet: 'Drag to change location!'
        ),
        onDragEnd: (LatLng latlng) {
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

    getIncidents();

    if (mounted) {
      setState(() {
        userLocation = locationData;
        circle = c;
        markers.add(m);
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
              markers: markers.isEmpty ? {} : markers.toSet(),
              initialCameraPosition: CameraPosition(
                target: LatLng(6.185123, 6.979588),
                zoom: 14.0,
              ),
            ),
            Align(
              alignment: Alignment(0.95, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    heroTag: 'btn2',
                    mini:true,
                    backgroundColor: Colors.amber,
                    onPressed: (){
                    mapController.animateCamera(
                      CameraUpdate.zoomIn(),
                    );
                  }, child: Icon(Icons.add),),
                  SizedBox(height: 10,),
                  FloatingActionButton(
                    heroTag: 'btn3',
                      mini:true,
                      backgroundColor: Colors.amber,
                      onPressed: (){
                    mapController.animateCamera(
                      CameraUpdate.zoomOut(),
                    );
                  }, child: Icon(Icons.remove))
                ],
              ),
            ),
            Align(
              alignment: Alignment(0.0, -0.9),
              child: SearchMapPlaceWidget(
                apiKey: 'AIzaSyAii2btH0d9Ep1Yego7zp6P9EEtbXxlXVI',
                // The language of the autocompletion
                language: 'en',
                // The position used to give better recomendations. In this case we are using the user position
                // location: LatLng(userLocation.latitude, userLocation.longitude),
                // radius: 30000,
                onSelected: (Place place) async {
                  final geolocation = await place.geolocation;
                  // Will animate the GoogleMap camera, taking us to the selected position with an appropriate zoom
//                final GoogleMapController controller = await _mapController.future;
                  mapController.animateCamera(CameraUpdate.newLatLng(geolocation.coordinates));
                  mapController.animateCamera(CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
                  int markerId = generateCode();
                  Marker m = Marker(
                      markerId: MarkerId(markerId.toString()),
                      position: geolocation.coordinates,
                      infoWindow: InfoWindow(
                          title: place.description,
                      ),
                      onDragEnd: (LatLng latlng) {
                        newLatLang = latlng;
                        print(newLatLang.longitude + newLatLang.latitude);
                      }
                  );

                  setState(() {
                    markers.add(m);
                  });
                  print(markers);
                },
              ),
            ),
          ],
        ),
      );
    }
  }
