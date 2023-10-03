// ignore_for_file: prefer_const_constructors

import 'package:d_view/d_view.dart';
import 'package:discuss_app/config/app_route.dart';
import 'package:discuss_app/config/session.dart';
import 'package:discuss_app/controller/c_home.dart';
import 'package:discuss_app/page/fragment/account_fragment.dart';
import 'package:discuss_app/page/fragment/explore_fragment.dart';
import 'package:discuss_app/page/fragment/feed_fragment.dart';
import 'package:discuss_app/page/fragment/my_topic_fragment.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List menu = [
      {
        'icon': Icons.feed,
        'label': 'Feed',
        'view': FeedFragment(),
      },
      {
        'icon': Icons.public,
        'label': 'Feed',
        'view': ExploreFragment(),
      },
      {
        'icon': Icons.library_books,
        'label': 'Feed',
        'view': MyTopicFragment(),
      },
      {
        'icon': Icons.account_circle,
        'label': 'Feed',
        'view': AccountFragment(),
      },
    ];

    return Consumer<CHome>(
      builder: (context, _, child) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              top: 30,
            ),
            child: menu[_.indexMenu]['view'],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.push(AppRoute.addTopic);
            },
            mini: true,
            tooltip: 'Create New Topic',
            child: Icon(Icons.create),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigationBar(
              onTap: (newIndex) {
                _.indexMenu = newIndex;
              },
              currentIndex: _.indexMenu,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: menu.map(
                (e) {
                  return BottomNavigationBarItem(
                    icon: Icon(e['icon']),
                    label: e['label'],
                  );
                },
              ).toList()),
        );
      },
    );
  }
}
