import 'package:flutter/material.dart';

class Record extends StatelessWidget {
  const Record({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Capacity profile',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(onPressed: (){}, child: Text('CV')),
      ],
    );
  }
}