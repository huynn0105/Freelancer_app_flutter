import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';

class Information extends StatelessWidget {
  const Information({
    this.email,
    this.phoneNumber,
    this.contract,
    this.location,
    Key key,
  }) : super(key: key);
  final String email;
  final String phoneNumber;
  final String contract;
  final String location;

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
          ListTile(
            leading: Icon(Icons.mail),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            title: Text(email),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            title: Text(phoneNumber),
          ),
          location!=null ? ListTile(
            leading: Icon(Icons.location_on),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            title: Text(location),
          ) : const SizedBox.shrink(),
          contract!=null ?ListTile(
            leading: Icon(Icons.link_sharp),

            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            title: Text(contract),
          ) : const SizedBox.shrink(),
        ],
      ),
    );
  }
}