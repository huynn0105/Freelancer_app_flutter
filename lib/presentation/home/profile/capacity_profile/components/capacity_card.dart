import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/domain/models/capacity_profile.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/profile/capacity_profile/capacity_profile_detail_screen.dart';
import 'package:get/get.dart';

class CapacityCard extends StatelessWidget {
  const CapacityCard({
    Key key,
    @required this.capacityProfile,
  }) : super(key: key);

  final CapacityProfile capacityProfile;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => CapacityProfileDetailScreen(
              capacityProfile: capacityProfile,
            ));
      },
      child: CachedNetworkImage(
        imageUrl: '$IMAGE/${capacityProfile.imageUrl}',
        httpHeaders: {HttpHeaders.authorizationHeader: 'Bearer $TOKEN'},
        placeholder: (context, url) => CupertinoActivityIndicator(),
        errorWidget: (context, url, error) => Container(
          child: Icon(Icons.error,size: 30,),
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[200],
          ),
        ),
        imageBuilder: (context, imageProvider) => Container(
          margin: EdgeInsets.only(right: 10),
          width: MediaQuery.of(context).size.width,
          height: 270,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  color: Color(0XFF686868).withOpacity(0.6),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    capacityProfile.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
