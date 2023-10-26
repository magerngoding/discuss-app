// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:d_button/d_button.dart';
import 'package:d_view/d_view.dart';
import 'package:discuss_app/config/api.dart';
import 'package:discuss_app/config/app.color.dart';
import 'package:discuss_app/config/app_format.dart';
import 'package:discuss_app/controller/c_comment.dart';
import 'package:discuss_app/controller/c_user.dart';
import 'package:discuss_app/model/comment.dart';
import 'package:discuss_app/source/comment_source.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
    final cComment = context.read<CComment>();
    final cUser = context.read<CUser>();
    final controllerInput = TextEditingController();
    cComment.setComment(topic);
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
                  return Container(
                    margin: EdgeInsets.fromLTRB(
                      8,
                      index == 0 ? 8 : 4,
                      8,
                      index == _.comments.length - 1 ? 80 : 8,
                    ),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                              '${Api.imageUser}/${comment.fromUser.image}'),
                        ),
                        DView.spaceWidth(8),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  comment.fromUser.username,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (comment.toUser.id != topic.idUser)
                                  Text(
                                    ' to',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                if (comment.toUser.id != topic.idUser)
                                  Text(
                                    comment.toUser.username,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                Spacer(),
                                Text(
                                  AppFormat.publish(comment.createdAt),
                                  style: TextStyle(
                                    fontSize: 10.0,
                                  ),
                                ),
                              ],
                            ),
                            DView.spaceHeight(4),
                            Text(comment.description),
                            DView.spaceHeight(8),
                            if (comment.image != '')
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (contextDialog) {
                                      return Column(
                                        children: [
                                          DView.spaceHeight(),
                                          DButtonCircle(
                                            diameter: 40,
                                            onClick: () =>
                                                Navigator.pop(contextDialog),
                                            child: Icon(
                                              Icons.clear,
                                            ),
                                          ),
                                          Expanded(
                                            // Buat clik zoom
                                            child: InteractiveViewer(
                                              child: Image.network(
                                                '${Api.imageComment}/${comment.image}',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                      '${Api.imageComment}/${comment.image}'),
                                ),
                              )
                          ],
                        ))
                      ],
                    ),
                  );
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
                    builder: (contextConsumer, _, child) {
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
                  ),
                  Consumer<CComment>(
                    builder: (contextConsumer, _, child) {
                      if (_.replyTo == null) return DView.nothing();
                      return Padding(
                        padding: EdgeInsets.fromLTRB(8, 4, 4, 0),
                        child: Row(
                          children: [
                            Text(
                              'Image: ${_.image}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => cComment.pickImage(
                          ImageSource.gallery,
                        ),
                        icon: Icon(
                          Icons.image,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () => cComment.pickImage(
                          ImageSource.camera,
                        ),
                        icon: Icon(
                          Icons.photo_camera,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: controllerInput,
                            minLines: 1,
                            maxLines: 5,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 12,
                              ),
                            ),
                            style: TextStyle(
                              height: 1,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          CommentSource.create(
                            topic.id,
                            cUser.data!.id,
                            context.read<CComment>().replyTo!.id,
                            controllerInput.text,
                            context.read<CComment>().image,
                            context.read<CComment>().imageBase64code,
                          ).then((success) {
                            if (success) {
                              controllerInput.clear();
                              cComment.setComment(topic);
                            }
                          });
                        },
                        icon: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
