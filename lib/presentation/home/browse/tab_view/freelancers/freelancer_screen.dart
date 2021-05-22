import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/data/data.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/browse/filter_search_screen.dart';
import 'package:freelance_app/presentation/home/browse/tab_view/freelancers/freelancer_controller.dart';
import 'package:freelance_app/presentation/widgets/nav_item.dart';
import 'package:freelance_app/presentation/widgets/rate.dart';
import 'package:get/get.dart';

import 'freelancer_detail/freelancer_detail_screen.dart';

class FreelancersScreen extends StatelessWidget {


  final controller = Get.put<FreelancerController>(FreelancerController(
    apiRepositoryInterface: Get.find(),
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    // Expanded(
                    //   child: Obx(
                    //     () => SearchBoxFilter(
                    //       controller: controllerBrowse,
                    //       searchQueryController:
                    //           controllerBrowse.searchQueryController,
                    //       isSearching: controllerBrowse.isSearching.value,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.blue),
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.slidersH,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (builder) {
                                return FilterSearchScreen();
                              });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: controller.freelancers.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  Account freelancer = controller.freelancers[index];
                  return ItemFreelancer(
                    freelancer: freelancer,
                    rate: freelancers[index].rate,
                    onTap: () {
                      Get.to(
                        () => FreelancerDetailScreen(freelancer: freelancer),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}

class ItemFreelancer extends StatelessWidget {
  const ItemFreelancer({
    @required this.rate,
    @required this.freelancer,
    @required this.onTap,
    Key key,
  }) : super(key: key);
  final Account freelancer;
  final int rate;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: freelancer.avatarUrl != null
                          ? CircleAvatar(
                              radius: 45,
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
                                  radius: 40,
                                ),
                                errorWidget: (context, url, error) =>
                                    CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: AssetImage(
                                      'assets/images/avatarnull.jpg'),
                                  radius: 40,
                                ),
                              ),
                            )
                          : CupertinoActivityIndicator(),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
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
                              child: Text(freelancer.level.name,style: TextStyle(color: Colors.white),),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.all(kDefaultPadding/5),
                        margin: EdgeInsets.symmetric(vertical: kDefaultPadding/6),
                            )
                          : SizedBox.shrink(),

                      freelancer.specialty != null
                          ? Text(freelancer.specialty.name)
                          : SizedBox.shrink(),
                      SizedBox(height: kDefaultPadding / 4),
                      Rate(rate: rate),
                    ],
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.keyboard_arrow_right),
                    ),
                  )
                ],
              ),
              freelancer.freelancerSkills != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 4, left: 10),
                      child: Wrap(
                        runSpacing: 5,
                        spacing: 5,
                        children: List.generate(
                          freelancer.freelancerSkills.length,
                          (index) => NavItem(
                            title: freelancer.freelancerSkills[index].name,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.65),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
