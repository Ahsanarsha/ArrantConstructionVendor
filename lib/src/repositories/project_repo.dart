import 'package:arrant_construction_vendor/src/models/vendor_project.dart';

import '../helpers/helper.dart';
import '../models/project.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../helpers/app_constants.dart' as constants;

Future<Stream<VendorProject>> getVendorProjects() async {
  String url = "${constants.apiBaseUrl}vendor/project/get";

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Authorization": "Bearer ${Helper.getUserAuthToken()}",
  };

  Uri uri = Uri.parse(url);

  final client = http.Client();
  try {
    var request = http.Request('get', uri);
    request.headers.addAll(requestHeaders);

    final streamedRest = await client.send(request);

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) {
          print(data);
          return Helper.getData(data as Map<String, dynamic>);
        })
        .expand((data) => (data as List))
        .map((data) {
          print(data);
          return VendorProject.fromJSON(data);
        });
  } on SocketException {
    throw const SocketException("Socket exception");
  } catch (e) {
    return Stream.value(VendorProject.fromJSON({}));
  }
}
