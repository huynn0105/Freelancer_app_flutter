import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';

class About extends StatelessWidget {
  const About({
    Key key,
    this.description,
    this.name,
  }) : super(key: key);
  final String description;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding,vertical: kDefaultPadding/2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Giới thiệu',
            style: TEXT_STYLE_PRIMARY,
          ),
          SizedBox(
            height: 5,
          ),
          ExpandableText(description!=null ? description : 'Xin chào tôi là $name', style: TextStyle(fontSize: 14),
            expandText: 'Xem thêm',
            collapseText: 'Ẩn đi',
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}