import 'dart:convert';
import 'dart:io';

import 'package:community_support/localization/demo_localization.dart';
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
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart' as permission;
import 'package:record_mp3/record_mp3.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:path_provider/path_provider.dart';
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
  String statusText = "";
  String recordLabel = 'Record Voice';
  bool isComplete = false;
  bool isRecording = false;

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
    'sex',
    'stalking',
    'robbery',
    'violence'
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
    List<String> crime = [
      DemoLocalization.of(context).getTranslatedValue('intruders'),
      DemoLocalization.of(context).getTranslatedValue('child_abuse'),
      DemoLocalization.of(context).getTranslatedValue('burglary'),
      DemoLocalization.of(context).getTranslatedValue('murder'),
      DemoLocalization.of(context).getTranslatedValue('sexual_assault'),
      DemoLocalization.of(context).getTranslatedValue('stalking'),
      DemoLocalization.of(context).getTranslatedValue('robbery'),
      DemoLocalization.of(context).getTranslatedValue('domestic_violence')
    ];

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar:AppBar(
        title: Text(DemoLocalization.of(context).getTranslatedValue('report_incident')),
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
                itemCount: crime.length,
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
              label: add == null ? DemoLocalization.of(context).getTranslatedValue('location'): '$add',
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
                    label: dateTime == null ? DemoLocalization.of(context).getTranslatedValue('dob') : "${dateTime.day}/${dateTime.month}/${dateTime.year}",
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
                    label: time == null ? DemoLocalization.of(context).getTranslatedValue('time') : "${time.hour}:${time.minute}",
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
              label: DemoLocalization.of(context).getTranslatedValue('add_detail'),
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
                label: Text(DemoLocalization.of(context).getTranslatedValue('upload_photo_video'),
                    style: TextStyle(decoration: TextDecoration.underline),),),
            FlatButton.icon(
                onPressed: () async {
                    isRecording ? stopRecord() : startRecord();
                },
                icon: Icon(Icons.mic),
                label: Text(recordLabel+statusText+(!isComplete ? '' : DemoLocalization.of(context).getTranslatedValue('exporting')),
                    style: TextStyle(decoration: TextDecoration.underline),),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Heading(
                fontSize: 14,
                text: DemoLocalization.of(context).getTranslatedValue('term_accept'),
                color: Colors.grey,
                align: TextAlign.justify,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedButton(label: DemoLocalization.of(context).getTranslatedValue('cancel'), onPressed: () => Navigator.pop(context)),
                SizedBox(width: 5,),
                RoundedButton(label: DemoLocalization.of(context).getTranslatedValue('submit'), onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  final prefs = await SharedPreferences.getInstance();
                  String uid = prefs.getString('user');
                  String profile = prefs.getString('profile');
                  Map<String, dynamic> decodedProfile = jsonDecode(profile);
                  uid = uid.replaceAll('"', '');
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
                          text: DemoLocalization.of(context).getTranslatedValue('your_report_submitted'),
                          subText: DemoLocalization.of(context).getTranslatedValue('incident_broadcast'),
                        )
                    ).then((value) => Navigator.pop(context));
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

  Future<bool> checkPermission() async {
    if (!await permission.Permission.microphone.isGranted) {
      permission.PermissionStatus status = await permission.Permission.microphone.request();
      if (status != permission.PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      isRecording = true;
      recordLabel = '';
      statusText = DemoLocalization.of(context).getTranslatedValue('recording_tap_to_stop');
      recordFilePath = await getFilePath();
      isComplete = false;
      RecordMp3.instance.start(recordFilePath, (type) {
        statusText = "Record error--->$type";
        setState(() {});
      });
    } else {
      statusText = DemoLocalization.of(context).getTranslatedValue('no_microphone_permission');
    }
    setState(() {});
  }

  void stopRecord() async {
    bool s = RecordMp3.instance.stop();
    if (s) {
      isRecording = false;
      statusText = "";
      recordLabel = 'Record Voice';
      RecordMp3.instance.status == RecordStatus.IDEL ? isComplete = false : isComplete = true ;
      voiceRecording = File(recordFilePath);
      setState(() {});
    }
  }

  String recordFilePath;
  String filename;

  Future<String> getFilePath() async {
    filename = "${DateTime.now().millisecond}";
    print(filename);
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/${filename}.mp3";
  }

}
