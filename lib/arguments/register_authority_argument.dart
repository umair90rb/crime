import 'dart:io';

class RegisterAuthorityArguments {
  final String fullName;
  final String phone;
  final String email;
  final File id;
  final File photo;
  final String serviceNo;

  RegisterAuthorityArguments({this.fullName, this.phone, this.email, this.id, this.photo, this.serviceNo});

}