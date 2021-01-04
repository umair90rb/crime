import 'dart:convert';
import 'dart:io';

import 'package:community_support/services/db_services.dart';
import 'package:community_support/ui/screens/home/get_location_from_map.dart';
import 'package:community_support/ui/widget/button.dart';
import 'package:community_support/ui/widget/card.dart';
import 'package:community_support/ui/widget/heading.dart';
import 'package:community_support/ui/widget/input.dart';
import 'package:community_support/ui/widget/date_button.dart';
import 'package:community_support/ui/widget/input_button.dart';
import 'package:community_support/ui/widget/res_card.dart';
import 'package:community_support/ui/widget/time_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:file_picker/file_picker.dart';


class AddIncident extends StatefulWidget {

  @override
  _AddIncidentState createState() => _AddIncidentState();
}

class _AddIncidentState extends State<AddIncident> {
  DateTime dateTime = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  DateTime reportingUserDateTime = DateTime.now();
  TimeOfDay reportingUserTime = TimeOfDay.now();
  var userLocation;

  GoogleMapController mapController;
  var add;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  File photo;
  File voiceRecording;
  String incidentType;
  DbServices db = DbServices();
  TextEditingController incidentDetails = TextEditingController();
  bool loading = false;
  LocationData loc;

  List<String> crimeIcon = [
    'inturders',
    'child',
    'bulg',
    'murder',
  ];

  List<String> crime = [
    'Inturders',
    'Child Abuse',
    'Bulgery',
    'Murder'
  ];



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
    final coordinates = new Coordinates(locationData.latitude, locationData.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    setState(() {
      loc = locationData;
      add = "${first.addressLine}, ${first.locality}, ${first.countryName}";
      userLocation = "${first.addressLine}, ${first.locality}, ${first.countryName}";
    });

  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GetLocationFromMap()),
    );
    final coordinates = new Coordinates(result.latitude, result.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    if(result != null){
      setState(() {
        add = "${first.addressLine}, ${first.locality}, ${first.countryName}";
      });
    }
    return;
  }

  Future chooseImage(scaffoldKey) async {
    File result = await FilePicker.getFile();
    if(result != null) {
      File file = File(result.path);
      return file;
    } else {
      scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text('No file chosen!'))
      );
      return;
    }
  }



  @override
  void initState() {
    _getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar:AppBar(
        title: Text('REPORT INCIDENT'),
        toolbarHeight: 100,
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: loading,
              child: LinearProgressIndicator(
                backgroundColor: Colors.white,
                minHeight: 1.75,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
              ),
            ),
            SizedBox(height: 5,),
            Container(height: 160,
              child: ListView.builder(
                padding: EdgeInsets.all(5),
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, i){
                  return InkWell(
                    onTap: (){
                      setState(() {
                        incidentType = crime[i];
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:4.0),
                      child: IconCard(icon: crimeIcon[i], title: crime[i] == incidentType ? crime[i]+'(selected)' : crime[i],),
                    ),
                  );
                },
              ),
            ),


            InputButton(
              backgroundColor: Colors.white,
              elevation: true,
              label: add == null ? 'Location': '$add',
              preIcon: Icons.location_pin,
              onTap: () => _navigateAndDisplaySelection(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width*0.55,
                  child: DatePicker(
                    firstDate: DateTime(1975, 1),
                    selectedDate: dateTime,
                    themeColor: Colors.amber,
                    labelColor: Colors.black,
                    elevation: true,
                    label: dateTime == null ? "Date of Birth" : "${dateTime.day}/${dateTime.month}/${dateTime.year}",
                    backgroundColor: Colors.white,
                    onDateSelect: (value){
                      print(value);
                      setState(() {
                        dateTime = value;
                      });
                      print('${dateTime.day}/${dateTime.month}/${dateTime.year}');
                    },
                  ),

                ),

                SizedBox(
                  width: size.width*0.45,
                  child: TimeButton(
                    selectedTime: time,
                    themeColor: Colors.amber,
                    labelColor: Colors.black,
                    elevation: true,
                    label: time == null ? "Time" : "${time.hour}:${time.minute}",
                    backgroundColor: Colors.white,
                    onTimeSelect: (value){
                      print(value);
                      setState(() {
                        time = value;
                      });
                    },
                  ),

                ),
              ],
            ),
            RoundedInput(
              borderRadius: 20,
              backgroundColor: Colors.white,
              maxLines: 3,
              controller: incidentDetails,
              label: 'Add Detail',
              elevation: true,
            ),
            FlatButton.icon(
                onPressed: () async {
                  File p = await chooseImage(_scaffoldKey);
                  setState(() {
                    photo = p;
                  });
                  print(photo.path);
                },
                icon: Icon(Icons.camera),
                label: Text('Upload Photo/Video',
                    style: TextStyle(decoration: TextDecoration.underline),),),
            FlatButton.icon(
                onPressed: () async {
                  File v = await chooseImage(_scaffoldKey);
                  setState(() {
                    voiceRecording = v;
                  });
                  print(voiceRecording.path);
                },
                icon: Icon(Icons.mic),
                label: Text('Add Voice Recording',
                    style: TextStyle(decoration: TextDecoration.underline),),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Heading(
                fontSize: 14,
                text: 'T&Cs: By Posting This Reports You Indicate Acceptance Of Our Terms and Condition',
                color: Colors.grey,
                align: TextAlign.justify,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedButton(label: 'Cancel', onPressed: () => Navigator.pop(context)),
                SizedBox(width: 5,),
                RoundedButton(label: 'Submit', onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  final prefs = await SharedPreferences.getInstance();
                  String uid = prefs.getString('user');
                  String profile = prefs.getString('profile');
                  Map<String, dynamic> decodedProfile = jsonDecode(profile);
                  uid = uid.replaceAll('"', '');
                  // print(uid);
                  // return;

                  String photoUrl = photo == null ? '' : await db.uploadFile('crimeFile', photo);
                  String voiceUrl = voiceRecording == null ? '' :  await db.uploadFile('crimeFile', voiceRecording);
                  bool dataInserted = await db.addData('crimes',{
                    'uid': uid,
                    'userName':decodedProfile['full_name'],
                    'userAvatar':decodedProfile['avatar'],
                    'incidentType':incidentType,
                    'incidentLocation':add,
                    'incidentLong': loc.longitude,
                    'incidentLat': loc.latitude,
                    'incidentDate':'${dateTime.day}/${dateTime.month}/${dateTime.year}',
                    'incidentTime': '${time.hour}:${time.minute}',
                    'incidentDetails':incidentDetails.text,
                    'incidentVisuals': photoUrl,
                    'incidentVoices': voiceUrl,
                    'status':'New',
                    'views':0,
                    'reportingUserLocation':userLocation,
                    'reportingTime':'${reportingUserTime.hour}:${reportingUserTime.minute}',
                    'reportingDate':'${reportingUserDateTime.day}/${reportingUserDateTime.month}/${reportingUserDateTime.year}'
                  });
                  if(dataInserted){
                    setState(() {
                      loading = false;
                    });
                    showCupertinoDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) => ResCard(
                          iconTitle: true,
                          textContent: true,
                          text: 'YOUR REPORT HAS BEEN SUBMITTED',
                          subText: 'This incident will be broadcast to all nearby crimepotters and added to central crime database',

                        )
                    );
                  }
                }),

              ],
            ),
            SizedBox(height: 15,)
          ],
        ),
      ),
    );
  }
}
