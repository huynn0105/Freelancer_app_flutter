import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/level.dart';
import 'package:freelance_app/domain/services/http_service.dart';
class Header extends StatelessWidget {

  final String avatarUrl;
  final String name;
  final String tile;
  final Level level;
  Header({this.avatarUrl,this.name,this.tile,this.level});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 75,
            foregroundColor: Colors.transparent,
            backgroundColor: Colors.grey.shade300,
            child: CachedNetworkImage(
              imageUrl: '$IMAGE/$avatarUrl',
              httpHeaders: {
                HttpHeaders.authorizationHeader: 'Bearer $TOKEN'
              },
              placeholder: (context, url) =>
                  CupertinoActivityIndicator(),
              imageBuilder: (context, image) => CircleAvatar(
                backgroundImage: image,
                radius: 70,
              ),
              errorWidget: (context, url, error) => CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage:
                AssetImage('assets/images/avatarnull.png'),
                radius: 70,
              ),
            ),
          ),

          SizedBox(
            height: kDefaultPadding/2,
          ),
          Text(
            '$name',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          tile != null
              ? Text(
            tile,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.black54,
            ),
          )
              : const SizedBox.shrink(),
          level != null
              ? Text(
            level.name,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.black54,
            ),
          )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}