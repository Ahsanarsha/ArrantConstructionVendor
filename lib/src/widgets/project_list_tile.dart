import 'package:arrant_construction_vendor/src/models/project.dart';
import 'package:arrant_construction_vendor/src/models/vendor_project.dart';
import 'package:arrant_construction_vendor/src/widgets/user_circular_avatar.dart';
import 'package:flutter/material.dart';

class ProjectListTileWidget extends StatelessWidget {
  final VendorProject vendorProject;
  final Function onClick;
  final bool isShowForward;
  const ProjectListTileWidget(
    this.vendorProject,
    this.onClick, {
    Key? key,
    this.isShowForward = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Theme.of(context).primaryColor,
    );
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(left: 3.0),
        child: Text(
          vendorProject.project!.name!,
          style: titleStyle,
        ),
      ),
      subtitle: _subtitleWidget(context),
      // leading: _leadingWidget(context),
      trailing: isShowForward ? _trailingWidget(context) : const SizedBox(),
      tileColor: Colors.white,
      minVerticalPadding: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      isThreeLine: true,
      onTap: () {
        onClick(vendorProject);
      },
    );
  }

  Widget _subtitleWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(
              width: 3,
            ),
            Icon(
              Icons.calendar_today_outlined,
              size: 14,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(
              width: 3,
            ),
            Text(vendorProject.project!.requestDate!),
          ],
        ),
        const SizedBox(
          height: 5.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.place,
              size: 18,
              color: Theme.of(context).primaryColor,
            ),
            Expanded(
              child: Text(
                vendorProject.project!.location!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _trailingWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.navigate_next_rounded,
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }

  // Widget _leadingWidget(BuildContext context) {
  //   return SizedBox(
  //     width: MediaQuery.of(context).size.width * 0.2,
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: Column(
  //             children: [
  //               Expanded(
  //                 flex: 4,
  //                 child: UserCircularAvatar(
  //                   imgUrl: project.client!.imageUrl!,
  //                   adjustment: BoxFit.fill,
  //                   // height: 40,
  //                   // width: 40,
  //                 ),
  //               ),
  //               Expanded(
  //                 flex: 1,
  //                 child: Text(
  //                   project.client!.name!,
  //                   style: const TextStyle(
  //                     fontSize: 12,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         VerticalDivider(
  //           color: Colors.grey[200],
  //           thickness: 3,
  //           width: 0,
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
