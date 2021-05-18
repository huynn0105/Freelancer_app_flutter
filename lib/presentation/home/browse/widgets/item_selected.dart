import 'package:flutter/material.dart';


class ItemSelected extends StatelessWidget {
  const ItemSelected({
    Key key,
    @required this.active,
    @required this.onTap,
    @required this.index,
    @required this.name,
  }) : super(key: key);

  final int active;
  final int index;
  final VoidCallback onTap;
  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: active == index ? Colors.blue : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Text(
          name,
          style: TextStyle(
              color: active == index ? Colors.white : Colors.black87,
            fontSize: 17
          ),
        ),
      ),
    );
  }
}
