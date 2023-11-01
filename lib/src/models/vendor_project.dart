import 'package:arrant_construction_vendor/src/models/project.dart';

class VendorProject {
  String? id;
  String? vendorId;
  String? projectId;
  String? dateAssigned;
  int? status; // 0 or 1
  Project? project;

  VendorProject();

  VendorProject.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : '';
      vendorId =
          jsonMap['vendor_id'] != null ? jsonMap['vendor_id'].toString() : '';
      projectId =
          jsonMap['project_id'] != null ? jsonMap['project_id'].toString() : '';
      dateAssigned = jsonMap['date_assigned'] ?? '';
      status = jsonMap['status'] != null
          ? int.parse(jsonMap['status'].toString())
          : 0;
      project = jsonMap['project'] != null
          ? Project.fromJSON(jsonMap['project'])
          : Project.fromJSON({});
    } catch (e) {
      print("Vendor Project Error: $e");
    }
  }
}
