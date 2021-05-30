import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/domain/services/http_service.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    Key key,
    this.url,
    this.onTap,
  }) : super(key: key);

  final String url;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      InkWell(
        onTap: onTap,
        child: CircleAvatar(
          radius: 75,
          foregroundColor: Colors.transparent,
          backgroundColor: Colors.grey.shade300,
          child: CachedNetworkImage(
            imageUrl: '$IMAGE/$url',
            httpHeaders: {HttpHeaders.authorizationHeader: 'Bearer $TOKEN'},
            placeholder: (context, url) => CupertinoActivityIndicator(),
            imageBuilder: (context, image) => CircleAvatar(
              backgroundImage: image,
              radius: 70,
            ),
            errorWidget: (context, url, error) => CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: AssetImage('assets/images/avatarnull.png'),
              radius: 70,
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 5,
        right: -17,
        child: MaterialButton(
          onPressed: onTap,
          color: Colors.grey[300],
          child: Icon(
            Icons.camera_alt,
            color: Colors.black,
          ),
          padding: EdgeInsets.all(10),
          shape: CircleBorder(),
        ),
      )
    ]);
  }
}
