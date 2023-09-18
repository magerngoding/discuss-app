import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:http/http.dart';

import '../config/api.dart';

class TopicSource {
  static Future<bool> create(
    String title,
    String description,
    String images,
    String base64code,
    String idUser,
  ) async {
    String url = '${Api.topic}/create.php'; //topic adalah nama folder
    try {
      Response response = await Client().post(
        Uri.parse(url),
        body: {
          'title': title,
          'description': description,
          'images': images,
          'base64code': base64code,
          'id_user': idUser,
        },
      );
      DMethod.printTitle('Topic Source - create', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (e) {
      DMethod.printTitle('Topic Source - create', e.toString());
      return false;
    }
  }

  static Future<bool> update(
    String id,
    String title,
    String description,
  ) async {
    String url = '${Api.topic}/update.php';
    try {
      Response response = await Client().post(
        Uri.parse(url),
        body: {
          'id': id,
          'title': title,
          'description': description,
        },
      );
      DMethod.printTitle('Topic Source - update', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (e) {
      DMethod.printTitle('Topic Source - update', e.toString());
      return false;
    }
  }

  static Future<bool> delete(
    String id,
    String images,
  ) async {
    String url = '${Api.topic}/delete.php';
    try {
      Response response = await Client().post(
        Uri.parse(url),
        body: {
          'id': id,
          'images': images,
        },
      );
      DMethod.printTitle('Topic Source - delete', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (e) {
      DMethod.printTitle('Topic Source - delete', e.toString());
      return false;
    }
  }
}