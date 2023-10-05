// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:d_button/d_button.dart';
import 'package:d_view/d_view.dart';
import 'package:discuss_app/config/app_format.dart';
import 'package:discuss_app/config/app_route.dart';
import 'package:flutter/material.dart';

import 'package:discuss_app/model/topic.dart';
import 'package:go_router/go_router.dart';

import '../config/api.dart';

class DetailTopicPage extends StatelessWidget {
  final Topic topic;

  DetailTopicPage({
    Key? key,
    required this.topic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> images = List<String>.from(jsonDecode(topic.images));

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  '${Api.imageUser}/${topic.user!.image}',
                  width: 36.0,
                  height: 36.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            DView.spaceWidth(),
            Text(topic.user!.username),
          ],
        ),
      ),
      extendBody: true,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DView.textTitle(topic.title),
          DView.spaceHeight(4),
          Row(
            children: [
              const Icon(
                Icons.event,
                size: 15.0,
              ),
              DView.spaceWidth(4),
              Text(
                AppFormat.fullDateTime(topic.createdAt),
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          DView.spaceHeight(),
          Text(topic.description),
          DView.spaceHeight(),
          if (images.isNotEmpty)
            ...images.map((e) {
              return Container(
                margin: const EdgeInsets.fromLTRB(
                  16,
                  0,
                  16,
                  16,
                ),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (contextDialog) {
                        return Column(
                          children: [
                            DView.spaceHeight(),
                            DButtonCircle(
                              diameter: 40,
                              onClick: () => Navigator.pop(contextDialog),
                              child: Icon(
                                Icons.clear,
                              ),
                            ),
                            Expanded(
                              // Buat clik zoom
                              child: InteractiveViewer(
                                child: Image.network(
                                  '${Api.imageTopic}/$e',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        '${Api.imageTopic}/$e',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: DButtonElevation(
          onClick: () {
            // context.push(
            //   AppRoute.comment,
            //   extra: topic,
            // );
          },
          height: 40,
          mainColor: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Comments',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              DView.spaceWidth(4),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
