import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {

  final String title;
  final Color backgroundColor;
  final TextStyle textStyle;

  NavItem({
    @required this.title,
    this.backgroundColor = Colors.black12,
    this.textStyle,
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 7),

      child: Text(
        title,
        style: textStyle,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(7),
      ),
    );
  }
}