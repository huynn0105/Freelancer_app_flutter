import 'package:flutter/material.dart';

class ItemBox extends StatelessWidget {
  const ItemBox({
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
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: active == index ? Colors.blue : Colors.white,
            border: Border.symmetric(horizontal: BorderSide(width: 2,color: Colors.blue),vertical: BorderSide(width: 1,color: Colors.blue)),
          ),
          height: 34,
          child: Center(
            child: Text(
              name,
              style: TextStyle(
                  color: active == index ? Colors.white : Colors.blue),
            ),
          ),
        ),
      ),
    );
  }
}
