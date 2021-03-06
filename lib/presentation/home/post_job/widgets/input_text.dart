import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class InputText extends StatelessWidget {
  const InputText({
    this.maxLines ,
    this.hint,
    this.controller,
    this.icon,
    this.label,
    this.maxLength,
    this.validator,
    this.suffixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.onTap,
    this.readOnly = false,
    Key key,
  }) : super(key: key);
  final int maxLines;
  final String hint;
  final String label;
  final Widget icon;
  final int maxLength;
  final Function validator;
  final TextEditingController controller;
  final Widget suffixIcon;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final VoidCallback onTap;
  final bool readOnly;

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
        inputFormatters: inputFormatters,
        onTap: onTap,
        readOnly: readOnly,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon,
          hintText: hint,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: EdgeInsets.all(16),
        ),
      ),
    );
  }
}
