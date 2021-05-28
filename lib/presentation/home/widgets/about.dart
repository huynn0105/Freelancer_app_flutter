import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';

class About extends StatelessWidget {
  const About({
    Key key,
    this.description
  }) : super(key: key);
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Giới thiệu',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          ExpandableText(description, style: TextStyle(fontSize: 14),
            expandText: 'Xem thêm',
            collapseText: 'Ẩn đi',
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}