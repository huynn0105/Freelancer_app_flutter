import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/data/data.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/browse/filter/filter_search_screen.dart';
import 'package:freelance_app/presentation/home/browse/tab_view/freelancers/freelancer_controller.dart';
import 'package:freelance_app/presentation/widgets/rate.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'freelancer_detail/freelancer_detail_screen.dart';

class FreelancersScreen extends StatelessWidget {
  final controller = Get.put<FreelancerController>(FreelancerController(
    apiRepositoryInterface: Get.find(),
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (controller.progressState.value == sState.initial)
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: controller.freelancers.isNotEmpty
                  ? ListView.builder(
                shrinkWrap: true,
                itemCount: controller.freelancers.length,
                itemBuilder: (context, index) {
                  return FreelancerCard(
                    freelancer: controller.freelancers[index],
                    rate: freelancers[index].rate,
                  );
                },
              )
                  : Center(child: Icon(Icons.error_outline),
              ),
            );
          else if (controller.progressState.value == sState.failure)
            return Center(child: Text('Lỗi, thử lại sau!',style: TEXT_STYLE_PRIMARY,));
          else
            return Center(child: CircularProgressIndicator());
        }
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showCupertinoModalBottomSheet(
                expand: true,
                context: context,
                builder: (builder) {
                  return FilterSearchScreen();
                });
          },
          child: Icon(Icons.search)),
    );
  }
}

class FreelancerCard extends StatelessWidget {
  const FreelancerCard({
    @required this.rate,
    @required this.freelancer,
    Key key,
  }) : super(key: key);
  final Account freelancer;
  final int rate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          () => FreelancerDetailScreen(freelancerId: freelancer.id),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding / 2),
        ),
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding / 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: freelancer.avatarUrl != null
                          ? CircleAvatar(
                              radius: 36,
                              foregroundColor: Colors.transparent,
                              backgroundColor: Colors.grey.shade300,
                              child: CachedNetworkImage(
                                imageUrl: '$IMAGE/${freelancer.avatarUrl}',
                                httpHeaders: {
                                  HttpHeaders.authorizationHeader:
                                      'Bearer $TOKEN'
                                },
                                placeholder: (context, url) =>
                                    CupertinoActivityIndicator(),
                                imageBuilder: (context, image) => CircleAvatar(
                                  backgroundImage: image,
                                  radius: 33,
                                ),
                                errorWidget: (context, url, error) =>
                                    CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: AssetImage(
                                      'assets/images/avatarnull.png'),
                                  radius: 33,
                                ),
                              ),
                            )
                          : CupertinoActivityIndicator(),
                    ),
                  ),
                  SizedBox(
                    width: kDefaultPadding / 2,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          freelancer.name,
                          style: TEXT_STYLE_PRIMARY,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                        freelancer.level != null
                            ? Container(
                                child: Text(
                                  freelancer.level.name,
                                  style: TextStyle(color: Colors.white),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(5)),
                                padding: EdgeInsets.all(kDefaultPadding / 5),
                                margin: EdgeInsets.symmetric(
                                    vertical: kDefaultPadding / 6),
                              )
                            : SizedBox.shrink(),
                        freelancer.specialty != null
                            ? Text(
                                freelancer.specialty.name,
                                overflow: TextOverflow.ellipsis,
                              )
                            : SizedBox.shrink(),
                        SizedBox(height: kDefaultPadding / 4),
                        Rate(rate: rate),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
