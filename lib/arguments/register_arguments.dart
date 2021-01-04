import 'dart:io';

class RegisterArguments {
  final String fullName;
  final String familyName;
  final String dob;
  final String martialStatus;
  final String title;
  final String nextToKin;
  final String phone;
  final String email;
  final String village;
  final File id;
  final File photo;

  RegisterArguments({this.fullName, this.familyName, this.dob, this.martialStatus, this.title, this.nextToKin, this.phone, this.email, this.village, this.id, this.photo});

}