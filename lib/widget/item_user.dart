// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:discuss_app/config/api.dart';
import 'package:discuss_app/config/app_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../model/user.dart';

class ItemUser extends StatelessWidget {
  final User user;
  const ItemUser({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.push(
          AppRoute.profile,
          extra: user,
        );
      },
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          '${Api.imageUser}/${user.image}',
        ),
        radius: 18,
      ),
      horizontalTitleGap: 5,
      title: Text(user.username),
      trailing: Icon(Icons.navigate_next),
    );
  }
}
