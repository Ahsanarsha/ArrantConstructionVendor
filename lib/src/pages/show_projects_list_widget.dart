import 'package:arrant_construction_vendor/src/models/project.dart';
import 'package:arrant_construction_vendor/src/models/vendor_project.dart';
import 'package:arrant_construction_vendor/src/widgets/project_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ShowProjectsListWidget extends StatelessWidget {
  final List<VendorProject> vendorProject;
  final Function onTap;
  const ShowProjectsListWidget(this.vendorProject, this.onTap, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: vendorProject.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ProjectListTileWidget(
            vendorProject[index],
            onTap,
          ),
        );
      },
    );
  }
}
