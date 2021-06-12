import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';

class ItemFilter extends StatelessWidget {
  const ItemFilter({
    Key key,
    @required this.title,
    @required this.list,
    @required this.onChanged,
    @required this.selected,

  }) : super(key: key);


  final String title;
  final List list;
  final Function onChanged;
  final selected;

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Container(
          width: 90,
          child: Text(
            title,
            style: TEXT_STYLE_ON_FOREGROUND,
          ),
        ),
        SizedBox(width: 50,),
        Container(
          width: 210,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: selected,
              onChanged: (newValue) {
                onChanged(newValue);
              },
              items: list.map<DropdownMenuItem>(( value) {
                return DropdownMenuItem(
                  value: value,
                  child: Container(child: Text(value.name,style: TextStyle(fontSize: 16),),width: 170,),
                );
              }).toList(),
            ),
          ),
        )

      ],
    );
  }
}
