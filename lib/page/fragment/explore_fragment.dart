import 'dart:convert';

import 'package:d_button/d_button.dart';
import 'package:d_view/d_view.dart';
import 'package:discuss_app/config/app_route.dart';
import 'package:discuss_app/controller/c_explore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../controller/c_user.dart';
import '../../model/topic.dart';
import '../../widget/item_topic.dart';

class ExploreFragment extends StatelessWidget {
  const ExploreFragment({super.key});
  @override
  Widget build(BuildContext context) {
    final cUser = context.read<CUser>();
    if (cUser.data == null) return DView.loadingCircle();
    context.read<CExplore>().setTopics();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DView.textTitle('Explore', size: 24),
                DButtonElevation(
                  mainColor: Theme.of(context).primaryColor,
                  onClick: () {
                    context.push(AppRoute.search);
                  },
                  height: 36,
                  width: 36,
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Consumer<CExplore>(
            builder: (contextConsumer, _, child) {
              if (_.topics.isEmpty) return DView.empty();

              return ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: _.topics.length,
                itemBuilder: (context, index) {
                  Topic topic = _.topics[index];
                  List images = jsonDecode(topic.images);
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                      16,
                      8,
                      16,
                      index == _.topics.length - 1 ? 30 : 8,
                    ),
                    child: ItemTopic(
                      topic: topic,
                      images: images,
                    ),
                  );
                },
              );
            },
          ))
        ],
      ),
    );
  }
}
