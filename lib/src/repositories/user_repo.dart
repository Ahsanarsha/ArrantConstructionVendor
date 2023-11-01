import 'dart:convert';
import 'dart:io';
import 'package:arrant_construction_vendor/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../helpers/helper.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/app_constants.dart' as constants;

var currentUser = User().obs;
const String _errorString = "Vendor Repo Error: ";

Future<User> login(User user) async {
  String url = "${constants.apiBaseUrl}vendor/login";
  print("Login Url: $url");
  var body = {
    "email": user.email,
    "password": user.password,
  };
  print(body);
  Uri uri = Uri.parse(url);
  final client = http.Client();
  try {
    final response = await client.post(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json;charset=utf-8'
      },
      body: json.encode(body),
    );
    print(response.statusCode);
    print(response.body);

    Map jsonBody = json.decode(response.body);
    if (response.statusCode == 200 &&
        jsonBody['data'][0]['access_token'] != null) {
      setCurrentUserInSP(response.body);
      currentUser.value = User.fromJSON(json.decode(response.body)['data'][0]);

      // return currentUser;
    } else {
      print("throws exception");
      // return currentUser;
    }
    return currentUser.value;
  } catch (e) {
    print(_errorString + e.toString());
    return currentUser.value;
  }
}

Future<User> updateUser(User user, {File? imageFile}) async {
  String url = "${constants.apiBaseUrl}vendor/profile/update";

  Map<String, String> body = {
    "first_name": user.fname ?? '',
    "last_name": user.lname ?? '',
    "shop_address": user.shopAddress ?? '',
    "past_experience": user.pastExperience ?? '',
    "password": user.password ?? '',
    "contact_no": user.contactNumber ?? '',
  };

  Map<String, String> requestHeaders = {
    'Content-type': 'multipart/form-data',
    "Authorization": "Bearer ${Helper.getUserAuthToken()}",
  };

  try {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll(body);
    request.headers.addAll(requestHeaders);

    // adding image
    if (imageFile != null) {
      print("adding image");
      String imageType = imageFile.path.split('.').last;
      request.files.add(
        await http.MultipartFile.fromPath("profile_url", imageFile.path,
            contentType: MediaType("image", imageType)),
      );
    }

    var response = await request.send();
    //print("response: $response");

    var res = await http.Response.fromStream(response);

    print(response.statusCode);
    print(res.body);
    Map jsonBody = json.decode(res.body);

    if (response.statusCode == 200 &&
        jsonBody['data'][0]['access_token'] != null) {
      setCurrentUserInSP(res.body);
      print("user updated successfully");
      return User.fromJSON(jsonBody['data'][0]);
    } else {
      print("no updated");
      return User.fromJSON({});
      // throw Exception(res.body);
    }
    // return currentUser;
  } catch (e) {
    print("error updating user caught");
    print(e);
    return User.fromJSON({});
  }
}

void setCurrentUserInSP(jsonString) async {
  print("setting current user in SF");
  if (json.decode(jsonString)['data'][0] != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userObject = json.decode(jsonString)['data'][0];
    await prefs.setString('current_user', json.encode(userObject));
    print("user saved in SP");
  }
}

Future<User> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey("current_user")) {
    print("User Repo: user found from shared prefs");
    // print(prefs.get("current_user"));
    currentUser.value = User.fromJSON(
      json.decode(prefs.get("current_user").toString()),
    );
  } else {
    print("User Repo: user not found from shared prefs");
    currentUser.value = User.fromJSON({});
  }
  return currentUser.value;
}

Future<bool> removeCurrentUser() async {
  // reset user object
  currentUser.value = User.fromJSON({});
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // remove data
  try {
    await prefs.remove('current_user');
    print("User Repo: user data removed successfully");
    return true;
  } catch (e) {
    print("User Repo error: $e");
    return false;
  }
}
