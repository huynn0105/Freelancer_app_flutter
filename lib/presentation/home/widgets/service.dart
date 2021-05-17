import 'package:flutter/material.dart';

class Service extends StatelessWidget {
  const Service({
    Key key,
    this.servicesList,
  }) : super(key: key);
  final List<String> servicesList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Service',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        ListView.builder(
          itemBuilder: (context, index) => ItemService(
            nameService: servicesList[index],
          ),
          itemCount: servicesList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        ),
      ],
    );
  }
}

class ItemService extends StatelessWidget {
  const ItemService({
    Key key,
    this.nameService,
  }) : super(key: key);
  final String nameService;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            Icons.check,
            color: Color(0xFF0fe19b),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            nameService,
            style: TextStyle(color: Color(0xFF0fe19b), fontSize: 16),
          ),
        ],
      ),
    );
  }
}
