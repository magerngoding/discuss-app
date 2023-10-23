// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:d_view/d_view.dart';
import 'package:discuss_app/config/app.color.dart';
import 'package:discuss_app/controller/c_comment.dart';
import 'package:discuss_app/model/comment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/topic.dart';

class CommenPage extends StatelessWidget {
  final Topic topic;
  const CommenPage({
    super.key,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              topic.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            Text(
              topic.user!.username,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Consumer<CComment>(
            builder: (contextConsumer, _, child) {
              if (_.comments.isEmpty) {
                return DView.empty('This topic not have comment yet!');
              }
              return ListView.builder(
                itemCount: _.comments.length,
                itemBuilder: (context, index) {
                  Comment comment = _.comments[index];
                  return SizedBox();
                },
              );
            },
          ),
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Material(
              elevation: 8,
              color: AppColor.primay,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<CComment>(
                    builder: (context, _, child) {
                      if (_.replyTo == null) return DView.nothing();
                      return Padding(
                        padding: EdgeInsets.fromLTRB(
                          8,
                          4,
                          4,
                          0,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'To: ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            ),
                            Text(
                              _.replyTo!.username,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
