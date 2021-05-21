import 'package:flutter/material.dart';


class ItemSelected extends StatelessWidget {
   ItemSelected({
    Key key,
    @required this.active,
    @required this.onTap,
    @required this.index,
    @required this.name,
    this.activeColor =  Colors.blue,
  }) : super(key: key);

  final int active;
  final int index;
  final Color activeColor ;
  final VoidCallback onTap;
  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: active == index ? activeColor : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(5)
        ),
        child: Text(
          name,
          style: TextStyle(
              color: active == index ? Colors.white : Colors.black87,
            fontSize: 15
          ),
        ),
      ),
    );
  }
}
