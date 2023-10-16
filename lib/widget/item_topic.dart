// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:d_view/d_view.dart';
import 'package:discuss_app/config/api.dart';
import 'package:discuss_app/config/app.color.dart';
import 'package:discuss_app/config/app_format.dart';
import 'package:discuss_app/config/app_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../model/topic.dart';

class ItemTopic extends StatelessWidget {
  final Topic topic;
  final List images;

  const ItemTopic({
    Key? key,
    required this.topic,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.push(AppRoute.profile, extra: topic.user);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      '${Api.imageUser}/${topic.user!.image}',
                      fit: BoxFit.cover,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
                DView.spaceWidth(8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topic.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'by ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          children: [
                            TextSpan(
                              text: topic.user!.username,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.push(AppRoute.detailTopic, extra: topic);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.primay.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: EdgeInsets.fromLTRB(
                      12,
                      3,
                      8,
                      4,
                    ),
                    child: DView.textAction(
                      () {},
                      text: 'Detail',
                      size: 14,
                      color: Theme.of(context).primaryColor,
                      iconRight: Icons.navigate_next,
                      iconRightSize: 17,
                      iconRightColor: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              topic.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 12,
            ),
            if (images.isNotEmpty)
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.network(
                            '${Api.imageTopic}/${images[0]}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    if (images.length > 1)
                      Container(
                        width: 60,
                        height: double.infinity,
                        margin: const EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[300],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '+${images.length - 1}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              AppFormat.publish(
                topic.createdAt,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
