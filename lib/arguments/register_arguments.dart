import 'dart:io';

class RegisterArguments {
  final String fullName;
  final String familyName;
  final String dob;
  final String martialStatus;
  final String title;
  final String nextToKin;
  final String phone;
  // final String email;
  final String village;
  final dynamic id;
  final dynamic photo;
  final DateTime createdAt;
  final String docId;

  RegisterArguments({this.fullName, this.createdAt, this.docId, this.familyName, this.dob, this.martialStatus, this.title, this.nextToKin, this.phone, this.village, this.id, this.photo});

}