import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  SearchBox({
    this.hint,
    Key key,
    this.controller,
  }) : super(key: key);
  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.grey[300],
          prefixIcon:  Icon(Icons.search),
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          contentPadding: EdgeInsets.all(4),
        ),
      ),
    );
  }
}