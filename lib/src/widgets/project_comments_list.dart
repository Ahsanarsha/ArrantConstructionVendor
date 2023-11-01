import 'package:arrant_construction_vendor/src/models/project_comment.dart';
import 'package:arrant_construction_vendor/src/widgets/comment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProjectCommentsListWidget extends StatelessWidget {
  final List<ProjectComment> projectComments;
  const ProjectCommentsListWidget(this.projectComments, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: projectComments.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CommentCardWidget(projectComments[index]),
        );
      },
    );
  }
}
