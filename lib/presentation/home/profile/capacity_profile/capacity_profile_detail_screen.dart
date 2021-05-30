import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/account.dart';
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
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(icon: Icon(Icons.delete_outline_outlined), onPressed: (){
              Get.defaultDialog(
                radius: 10,
                actions: [
                  TextButton(onPressed: ()=>Get.back(), child: Text('Không')),
                  Spacer(),
                  TextButton(onPressed: (){}, child: Text('Có')),
                ],
                title: 'Xác nhận xoá?',
                middleText: 'Bạn muốn xoá hồ sơ này?'

              );
            })
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Card(
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Row(
                //       children: [
                //         account.avatarUrl != null
                //             ? CircleAvatar(
                //                 radius: 45,
                //                 foregroundColor: Colors.transparent,
                //                 backgroundColor: Colors.grey.shade300,
                //                 child: CachedNetworkImage(
                //                   imageUrl: '$IMAGE/${account.avatarUrl}',
                //                   httpHeaders: {
                //                     HttpHeaders.authorizationHeader:
                //                         'Bearer $TOKEN'
                //                   },
                //                   placeholder: (context, url) =>
                //                       CupertinoActivityIndicator(),
                //                   imageBuilder: (context, image) =>
                //                       CircleAvatar(
                //                     backgroundImage: image,
                //                     radius: 40,
                //                   ),
                //                   errorWidget: (context, url, error) =>
                //                       CircleAvatar(
                //                     backgroundColor: Colors.grey,
                //                     backgroundImage: AssetImage(
                //                         'assets/images/avatarnull.jpg'),
                //                     radius: 40,
                //                   ),
                //                 ),
                //               )
                //             : CircularProgressIndicator(),
                //         SizedBox(
                //           width: 20,
                //         ),
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               account.name,
                //               style: TEXT_STYLE_PRIMARY,
                //               maxLines: 1,
                //               overflow: TextOverflow.fade,
                //             ),
                //             account.tile != null
                //                 ? Text(
                //                     account.tile,
                //                     style: TEXT_STYLE_ON_FOREGROUND,
                //                   )
                //                 : SizedBox.shrink(),
                //
                //             account.tile != null
                //                 ? Text(
                //                     account.phone,
                //                     style: TEXT_STYLE_ON_FOREGROUND,
                //                   )
                //                 : SizedBox.shrink(),
                //
                //             // Text(
                //             //   '$money VNĐ',
                //             //   style: TextStyle(
                //             //       color: Color(0xFF0fe19b),
                //             //       fontWeight: FontWeight.bold,
                //             //       fontSize: 18),
                //             // ),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 35,
                ),
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
                                child: Icon(Icons.error,size: 30,),
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey[200],
                                ),
                              ),
                              imageUrl: '$IMAGE/${capacityProfile.imageUrl}',
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
