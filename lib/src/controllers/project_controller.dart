import 'package:arrant_construction_vendor/src/models/project.dart';
import 'package:arrant_construction_vendor/src/models/vendor_project.dart';
import 'package:arrant_construction_vendor/src/repositories/project_repo.dart'
    as project_repo;
import 'package:get/get.dart';

class ProjectsController extends GetxController {
  final String errorString = "Project Controller Error: ";
  var vendorOngoingProjects = <VendorProject>[].obs;
  var vendorCompletedProjects = <VendorProject>[].obs;

  // progress variables
  var doneFetchingProjects = false.obs;

  Future<void> getAllProjects() async {
    doneFetchingProjects.value = false;

    vendorOngoingProjects.clear();
    vendorCompletedProjects.clear();

    Stream<VendorProject> stream = await project_repo.getVendorProjects();
    stream.listen((VendorProject _vendorProject) {
      if (_vendorProject.project?.id != null &&
          _vendorProject.project!.id!.isNotEmpty) {
        if (_vendorProject.project!.status == 3) {
          vendorOngoingProjects.add(_vendorProject);
        }
      }
    }, onError: (e) {
      print(errorString + e.toString());
    }, onDone: () {
      doneFetchingProjects.value = true;
    });
  }

  Future<void> refreshProjects() async {
    getAllProjects();
  }
}
