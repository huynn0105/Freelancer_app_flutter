import 'package:flutter/material.dart';
import 'package:freelance_app/presentation/widgets/nav_item.dart';

class SelectedBox extends StatelessWidget {
  int itemCount;
  String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Skill',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Wrap(
          runSpacing: 5,
          spacing: 5,
          children: List.generate(
            itemCount,
            (index) => ItemSelected(
              active: 1,
              onTap: (){

              },
              index: index,
              name: name,
            ),
          ),
        ),
      ],
    );
  }
}

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
