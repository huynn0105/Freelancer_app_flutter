import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonName;
  final EdgeInsets padding;
  final Color backgroundColor;

  const RoundedButton(
      {Key key,
      @required this.onTap,
      @required this.buttonName,
      this.backgroundColor = Colors.blue,
      this.padding = const EdgeInsets.all(16.0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: backgroundColor,
        ),
        width: size.width * 0.9,
        height: size.height * 0.073,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Text(
            buttonName,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
