import 'package:flutter/material.dart';
class InputText extends StatelessWidget {
  const InputText({
    this.maxLines ,
    this.hint,
    this.controller,
    this.icon,
    this.label,
    this.maxLength,
    this.validator,
    Key key,
  }) : super(key: key);
  final int maxLines;
  final String hint;
  final String label;
  final Widget icon;
  final int maxLength;
  final Function validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        maxLength: maxLength,
        validator: validator,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          labelText: hint,
          prefixIcon: icon,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),

          ),

          contentPadding: EdgeInsets.all(16),
        ),
      ),
    );
  }
}
