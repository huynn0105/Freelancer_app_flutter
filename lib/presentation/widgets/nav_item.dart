import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {

  final String title;
  final TextStyle style;

  NavItem({
    @required this.title,
    @required this.style,
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 7),
      child: Text(
        title,
        style: style,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}