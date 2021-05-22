import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';

class Earning extends StatelessWidget {
  const Earning({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Earning',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Icon(Icons.keyboard_arrow_right,color: Colors.white,),
              ],
            ),
            SizedBox(height: kDefaultPadding),
            Row(
              children: [
                Text(
                  '\$',
                  style: TEXT_STYLE_PRIMARY.copyWith(color: Colors.white),
                ),
                Text(
                  '1,025',
                  style: TEXT_STYLE_PRIMARY.copyWith(color: Colors.white)
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}