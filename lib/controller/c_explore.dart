import 'package:discuss_app/source/topic_source.dart';
import 'package:flutter/foundation.dart';

import '../model/topic.dart';

class CExplore extends ChangeNotifier {
  List<Topic> _topics = [];
  List<Topic> get topics => _topics;
  setTopics() async {
    _topics = await TopicSource.readExplore();
    notifyListeners();
  }
}
