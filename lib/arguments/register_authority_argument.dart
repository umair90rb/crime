import 'dart:io';

class RegisterAuthorityArguments {
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
  final String serviceNo;
  final String profileDocId;
  final String type;
  final String docId;

  RegisterAuthorityArguments({this.type, this.docId, this.profileDocId, this.fullName, this.createdAt, this.familyName, this.dob, this.martialStatus, this.title, this.nextToKin, this.phone, this.village, this.id, this.photo, this.serviceNo});

}