// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';

class ErorrPage extends StatelessWidget {
  final String title;
  final String description;

  const ErorrPage({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(
          16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DView.textTitle(title),
            DView.spaceHeight(),
            DView.error(description),
          ],
        ),
      ),
    );
  }
}
