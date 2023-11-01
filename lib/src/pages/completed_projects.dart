import 'package:arrant_construction_vendor/src/controllers/project_controller.dart';
import 'package:arrant_construction_vendor/src/helpers/helper.dart';
import 'package:arrant_construction_vendor/src/models/project.dart';
import 'package:arrant_construction_vendor/src/models/vendor_project.dart';
import 'package:arrant_construction_vendor/src/pages/project_details.dart';
import 'package:arrant_construction_vendor/src/pages/show_projects_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arrant_construction_vendor/src/repositories/user_repo.dart'
    as user_repo;

class CompletedProjects extends StatefulWidget {
  const CompletedProjects({
    Key? key,
  }) : super(key: key);

  @override
  _CompletedProjectsState createState() => _CompletedProjectsState();
}

class _CompletedProjectsState extends State<CompletedProjects> {
  final ProjectsController _con = Get.put(ProjectsController());
  void onProjectClick(VendorProject project) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return ProjectDetails(project);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return Helper.slideRightToLeftTransition(child, animation);
        },
      ),
    );
  }

  @override
  void initState() {
    // _con.getAllProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Completed Projects"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return _con.refreshProjects();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Obx(() {
                return _con.vendorCompletedProjects.isEmpty &&
                        _con.doneFetchingProjects.value
                    ? _noProjectsToShow()
                    : _con.vendorCompletedProjects.isEmpty &&
                            !_con.doneFetchingProjects.value
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : ShowProjectsListWidget(
                            _con.vendorCompletedProjects,
                            onProjectClick,
                          );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _noProjectsToShow() {
    Text noProjectsTextWidget =
        const Text("No projects to show! Tap to refresh.");
    IconButton refreshButton = IconButton(
      onPressed: () {
        _con.refreshProjects();
      },
      icon: const Icon(Icons.refresh),
    );
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          refreshButton,
          noProjectsTextWidget,
        ],
      ),
    );
  }
}
