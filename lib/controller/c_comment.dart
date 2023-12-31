import 'dart:convert';

import 'package:discuss_app/source/comment_source.dart';
import 'package:discuss_app/source/topic_source.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../model/comment.dart';
import '../model/topic.dart';
import '../model/user.dart';

class CComment extends ChangeNotifier {
  List<Comment> _comments = [];
  List<Comment> get comments => _comments;
  setComment(Topic topic) async {
    _image = '';
    _imageBase64code = '';
    _comments = await CommentSource.read(topic.id);
    setReplyTo(topic.user!);
    notifyListeners();
  }

  User? _replyTo;
  User? get replyTo => _replyTo;
  setReplyTo(User user) {
    _replyTo = user;
    notifyListeners();
  }

  String _image = '';
  String get image => _image;

  String _imageBase64code = '';
  String get imageBase64code => _imageBase64code;

  pickImage(ImageSource source) async {
    XFile? result = await ImagePicker().pickImage(source: source);
    if (result != null) {
      _image = result.name;
      _imageBase64code = base64Encode(await result.readAsBytes());
      notifyListeners();
    }
  }
}
