import 'package:arrant_construction_vendor/src/controllers/project_controller.dart';
import 'package:arrant_construction_vendor/src/helpers/helper.dart';
import 'package:arrant_construction_vendor/src/models/vendor_project.dart';
import 'package:arrant_construction_vendor/src/pages/project_details.dart';
import 'package:arrant_construction_vendor/src/pages/show_projects_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnGoingProjects extends StatefulWidget {
  const OnGoingProjects({
    Key? key,
  }) : super(key: key);

  @override
  _OnGoingProjectsState createState() => _OnGoingProjectsState();
}

class _OnGoingProjectsState extends State<OnGoingProjects> {
  final ProjectsController _con = Get.put(ProjectsController());
  void onProjectClick(VendorProject vendorProject) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return ProjectDetails(vendorProject);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return Helper.slideRightToLeftTransition(child, animation);
        },
      ),
    );
  }

  @override
  void initState() {
    _con.getAllProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ongoing Projects"),
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
                return _con.vendorOngoingProjects.isEmpty &&
                        _con.doneFetchingProjects.value
                    ? _noProjectsToShow()
                    : _con.vendorOngoingProjects.isEmpty &&
                            !_con.doneFetchingProjects.value
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : ShowProjectsListWidget(
                            _con.vendorOngoingProjects,
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
