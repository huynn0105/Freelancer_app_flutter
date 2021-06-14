import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/capacity_profile.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:freelance_app/presentation/home/profile/capacity_profile/add_capacity_profile.dart';
import 'package:freelance_app/presentation/home/widgets/service.dart';
import 'package:get/get.dart';

class CapacityProfileDetailScreen extends StatelessWidget {
  final CapacityProfile capacityProfile;

  CapacityProfileDetailScreen({@required this.capacityProfile});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.delete_outline_outlined),
              onPressed: () {
                Get.defaultDialog(
                    radius: 10,
                    actions: [
                      ElevatedButton(
                          onPressed: () => Get.back(),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey, minimumSize: Size(120, 40)),
                          child: Text('Huỷ')),
                      ElevatedButton(
                          onPressed: () {
                            controller.deleteCapacityProfile(capacityProfile);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue, minimumSize: Size(120, 40)),
                          child: Text('Xoá')),
                    ],
                    title: 'Xác nhận xoá?',
                    middleText: 'Bạn có chắc là muốn xoá hồ sơ này?');
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  capacityProfile.name,
                  style: TEXT_STYLE_PRIMARY.copyWith(fontSize: 25),
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                Text(
                  capacityProfile.description,
                  style: TEXT_STYLE_ON_FOREGROUND,
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                capacityProfile.imageUrl != null
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: AspectRatio(
                          aspectRatio: 1.7,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              errorWidget: (context, url, error) => Container(
                                child: Icon(
                                  Icons.error,
                                  size: 30,
                                ),
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey[200],
                                ),
                              ),
                              imageUrl: 'http://${capacityProfile.imageUrl}',
                              httpHeaders: {
                                HttpHeaders.authorizationHeader: 'Bearer $TOKEN'
                              },
                              placeholder: (context, url) =>
                                  CupertinoActivityIndicator(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'View web',
                      style: TEXT_STYLE_PRIMARY,
                    )),
                SizedBox(
                  height: kDefaultPadding,
                ),
                capacityProfile.services != null
                    ? Services(
                        freelancerServices: capacityProfile.services,
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'editCapacityProfile',
          onPressed: () {
            Get.to(() => AddCapacityProfile(
                  capacityProfile: capacityProfile,
                ));
          },
          child: Icon(
            Icons.edit,
          ),
        ));
  }
}
