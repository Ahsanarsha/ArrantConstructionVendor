import 'package:arrant_construction_vendor/src/controllers/comments_controller.dart';
import 'package:arrant_construction_vendor/src/widgets/loading_card_widgets.dart';
import 'package:arrant_construction_vendor/src/widgets/project_comments_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectComments extends StatefulWidget {
  final String projectId;
  final CommentsController _con;
  const ProjectComments(this.projectId, this._con, {Key? key})
      : super(key: key);

  @override
  _ProjectCommentsState createState() => _ProjectCommentsState();
}

class _ProjectCommentsState extends State<ProjectComments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
        centerTitle: true,

      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await widget._con.refreshProjectComments(widget.projectId);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Obx(() {
                return widget._con.projectComments.isEmpty &&
                        widget._con.doneFetchingProjectComments.value
                    ? const Center(child: Text("No comments"))
                    : widget._con.projectComments.isEmpty &&
                            !widget._con.doneFetchingProjectComments.value
                        ? LoadingCardWidget(
                            cardCount: 10,
                            width: MediaQuery.of(context).size.width * 0.90,
                            adjustment: BoxFit.fill,
                          )
                        : ProjectCommentsListWidget(
                            widget._con.projectComments);
              })
            ],
          ),
        ),
      ),
    );
  }
}
