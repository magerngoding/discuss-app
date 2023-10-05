// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:d_button/d_button.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:discuss_app/controller/c_my_topic.dart';
import 'package:discuss_app/source/topic_source.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../model/topic.dart';

class UpdateTopicPage extends StatefulWidget {
  final Topic topic;

  UpdateTopicPage({
    Key? key,
    required this.topic,
  }) : super(key: key);

  @override
  State<UpdateTopicPage> createState() => _UpdateTopicPageState();
}

class _UpdateTopicPageState extends State<UpdateTopicPage> {
  final controllerTitle = TextEditingController();
  final controllerDescription = TextEditingController();

  updateTopic() {
    TopicSource.update(
            widget.topic.id, controllerTitle.text, controllerDescription.text)
        .then((success) {
      if (success) {
        context.read<CMyTopic>().setTopics(widget.topic.idUser);
        DInfo.snackBarSuccess(context, 'Update Success!');
        context.pop();
      } else {
        DInfo.snackBarError(context, 'Update Erorr!');
      }
    });
  }

  @override
  void initState() {
    controllerTitle.text = widget.topic.title;
    controllerDescription.text = widget.topic.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft('Update Topic'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DInput(
            title: 'Title',
            controller: controllerTitle,
          ),
          DView.spaceHeight(),
          DInput(
            title: 'Title',
            controller: controllerDescription,
            minLine: 1,
            maxLine: 5,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: DButtonElevation(
            onClick: () => updateTopic(),
            height: 40,
            mainColor: Theme.of(context).primaryColor,
            child: Text(
              'Update Topic',
              style: TextStyle(
                color: Colors.white,
              ),
            )),
      ),
    );
  }
}
