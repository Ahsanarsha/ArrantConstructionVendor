import 'dart:io';

class User {
  String? id;
  String? fname;
  String? lname;
  String? email;
  String? password;
  String? shopAddress;
  String? contactNumber;
  String? imageUrl;
  String? authToken;
  String? pastExperience;
  int? status;
  File? imageFile;

  User();

  User.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : '';
      fname = jsonMap['first_name'] ?? '';
      lname = jsonMap['last_name'] ?? '';
      email = jsonMap['email'] ?? '';
      shopAddress = jsonMap['shop_address'] ?? '';
      contactNumber =
          jsonMap['contact_no'] != null ? jsonMap['contact_no'].toString() : '';

      imageUrl = jsonMap['profile_url'] ?? '';
      authToken = jsonMap['access_token'] ?? '';
      pastExperience = jsonMap['past_experience'] ?? '';
      status = jsonMap['status'] != null
          ? int.parse(jsonMap['status'].toString())
          : 0;
    } catch (e) {
      print("User Model Error: $e");
    }
  }
}
