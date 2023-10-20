import 'package:d_view/d_view.dart';
import 'package:discuss_app/controller/c_follower.dart';
import 'package:discuss_app/controller/c_following.dart';
import 'package:discuss_app/widget/item_user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';

class FollowingPage extends StatelessWidget {
  final User user;
  const FollowingPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    context.read<CFollowing>().setList(user.id);
    return Scaffold(
      appBar: DView.appBarLeft('${user.username} following...'),
      body: Consumer<CFollowing>(
        builder: (contextConsumer, _, child) {
          if (_.list.isEmpty) return DView.empty();
          return ListView.builder(
            itemCount: _.list.length,
            itemBuilder: (context, index) {
              return ItemUser(user: _.list[index]);
            },
          );
        },
      ),
    );
  }
}
