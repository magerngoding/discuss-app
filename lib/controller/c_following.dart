import 'package:discuss_app/model/user.dart';
import 'package:discuss_app/source/follow_source.dart';
import 'package:discuss_app/source/topic_source.dart';
import 'package:discuss_app/source/user_source.dart';
import 'package:flutter/foundation.dart';

import '../model/topic.dart';

class CFollowing extends ChangeNotifier {
  List<User> _list = [];
  List<User> get list => _list;
  setList(String idUser) async {
    _list = await FollowSource.readFollowing(idUser);
    notifyListeners();
  }
}
