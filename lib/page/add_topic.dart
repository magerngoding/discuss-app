// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:d_button/d_button.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:discuss_app/controller/c_add_topic.dart';
import 'package:discuss_app/controller/c_home.dart';
import 'package:discuss_app/controller/c_my_topic.dart';
import 'package:discuss_app/controller/c_user.dart';
import 'package:discuss_app/source/topic_source.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddTopic extends StatelessWidget {
  final controllerTitle = TextEditingController();
  final controllerDescription = TextEditingController();

  AddTopic({super.key});

  addNewTopic(BuildContext context) {
    TopicSource.create(
      controllerTitle.text,
      controllerDescription.text,
      jsonEncode(context.read<CAddTopic>().imageNames),
      jsonEncode(context.read<CAddTopic>().imageBase64codes),
      context.read<CUser>().data!.id,
    ).then(
      (success) {
        if (success) {
          DInfo.snackBarSuccess(context, 'Success Add New Topic!');
          context.read<CHome>().indexMenu = 2;
          context.read<CMyTopic>().setTopics(context.read<CUser>().data!.id);
          context.pop();
        } else {
          DInfo.snackBarError(context, 'Add Topic Failed!');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft('Add Topic'),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: DButtonElevation(
          onClick: () => addNewTopic(context),
          height: 40,
          mainColor: Theme.of(context).primaryColor,
          child: Text(
            'Add Topic',
          ),
        ),
      ),
      body: ListView(
        children: [
          DView.spaceHeight(),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: 16,
            ),
            child: DInput(
              controller: controllerTitle,
              title: 'Title',
            ),
          ),
          DView.spaceHeight(),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: 16,
            ),
            child: DInput(
              controller: controllerDescription,
              title: 'Description',
              minLine: 1,
              maxLine: 5,
            ),
          ),
          DView.spaceHeight(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<CAddTopic>().pickImage(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image),
                  label: Text(
                    'Galerry',
                  ),
                ),
                DView.spaceWidth(),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<CAddTopic>().pickImage(ImageSource.camera);
                  },
                  icon: Icon(Icons.photo_camera),
                  label: Text(
                    'Camera',
                  ),
                ),
              ],
            ),
          ),
          Consumer<CAddTopic>(
            builder: (context, _, child) {
              if (_.imageNames.isEmpty) return DView.nothing();
              return SizedBox(
                height: 150,
                child: ListView.builder(
                  itemCount: _.imageNames.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(index == 0 ? 16 : 8, 8,
                          index == _.imageNames.length - 1 ? 16 : 8, 8),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Image.memory(
                                    _.imageBytes[index],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: DButtonElevation(
                                  onClick: () {
                                    _.removeImage(index);
                                  },
                                  width: 40,
                                  height: 40,
                                  mainColor: Colors.red,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red[900],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
