// ignore_for_file: prefer_const_constructors

import 'package:discuss_app/controller/c_add_topic.dart';
import 'package:discuss_app/controller/c_comment.dart';
import 'package:discuss_app/controller/c_follower.dart';
import 'package:discuss_app/controller/c_following.dart';
import 'package:discuss_app/controller/c_profile.dart';
import 'package:discuss_app/controller/c_search.dart';
import 'package:discuss_app/model/topic.dart';
import 'package:discuss_app/page/add_topic.dart';
import 'package:discuss_app/page/comment_page.dart';
import 'package:discuss_app/page/detail_topic_page.dart';
import 'package:discuss_app/page/follower_page.dart';
import 'package:discuss_app/page/following_page.dart';
import 'package:discuss_app/page/home_page.dart';
import 'package:discuss_app/page/profile_page.dart';
import 'package:discuss_app/page/search_page.dart';
import 'package:discuss_app/page/update_topic_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../page/erorr_page.dart';
import '../page/login_page.dart';
import '../page/register_page.dart';
import 'session.dart';

class AppRoute {
  static const home = '/';
  static const login = '/login';
  static const register = '/register';
  static const addTopic = '/add-topic';
  static const profile = '/profile';
  static const search = '/search';
  static const follower = '/follower';
  static const following = '/following';
  static const comment = '/comment';
  static const detailTopic = '/detail-topic';
  static const updateTopic = '/update-topic';

  static GoRouter routerConfig = GoRouter(
    errorBuilder: (context, state) => ErorrPage(
      title: 'Something Erorr',
      description: state.error.toString(),
    ),
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      User? user = await Session.getUser();
      if (user == null) {
        if (state.location == login || state.location == register) {
          return null;
        }

        return login;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => RegisterPage(),
      ),
      GoRoute(
        path: addTopic,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => CAddTopic(),
          child: AddTopic(),
        ),
      ),
      GoRoute(
        path: profile,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => CProfile(),
          child: ProfilePage(
            user: state.extra as User,
          ),
        ),
      ),
      GoRoute(
        path: search,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => CSearch(),
          child: SearchPage(),
        ),
      ),
      GoRoute(
        path: follower,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => CFollower(),
          child: FollowerPage(
            user: state.extra as User,
          ),
        ),
      ),
      GoRoute(
        path: following,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => CFollowing(),
          child: FollowingPage(
            user: state.extra as User,
          ),
        ),
      ),
      GoRoute(
        path: comment,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => CComment(),
          child: CommenPage(
            topic: state.extra as Topic,
          ),
        ),
      ),
      GoRoute(
        path: detailTopic,
        builder: (context, state) => DetailTopicPage(
          topic: state.extra as Topic,
        ),
      ),
      GoRoute(
        path: updateTopic,
        builder: (context, state) => UpdateTopicPage(
          topic: state.extra as Topic,
        ),
      ),
    ],
  );
}
