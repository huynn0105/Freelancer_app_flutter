import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';

class Information extends StatelessWidget {
  const Information({
    this.email,
    this.phoneNumber,
    this.contract,
    Key key,
  }) : super(key: key);
  final String email;
  final String phoneNumber;
  final String contract;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding,vertical: kDefaultPadding/2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            'Thông tin',
            style: TEXT_STYLE_PRIMARY,
          ),
          SizedBox(height: 5,),
          Row(
            children: [
              Icon(Icons.mail, color: Colors.black54,),
              SizedBox(width: 10,),
              Text(
                '$email', style: TextStyle(fontSize: 16),)
            ],
          ),
          SizedBox(height: 5,),
          Row(
            children: [
              Icon(Icons.phone, color: Colors.black54,),
              SizedBox(width: 10,),
              Text('$phoneNumber', style: TextStyle(fontSize: 16),)
            ],
          ),
          SizedBox(height: 5,),
          contract != null ? Row(
            children: [
              Icon(Icons.link_sharp, color: Colors.black54,),
              SizedBox(width: 10,),
              Text(contract, style: TextStyle(fontSize: 16),)
            ],
          ): const SizedBox.shrink(),
        ],
      ),
    );
  }
}