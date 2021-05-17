import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({
    Key key,
    this.description
  }) : super(key: key);
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,

      children: [
        Text(
          'About',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        ExpandableText(description, style: TextStyle(fontSize: 14),
          expandText: 'show more',
          collapseText: 'show less',
          maxLines: 3,
        ),
      ],
    );
  }
}