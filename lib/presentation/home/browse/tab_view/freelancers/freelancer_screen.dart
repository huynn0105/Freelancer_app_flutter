import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freelance_app/data/data.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/freelancer.dart';
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/domain/models/skill.dart';
import 'package:freelance_app/domain/models/specialty.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/browse/browse_controller.dart';
import 'package:freelance_app/presentation/home/browse/filter_search_screen.dart';
import 'package:freelance_app/presentation/home/browse/tab_view/freelancers/freelancer_controller.dart';
import 'package:freelance_app/presentation/home/browse/widgets/search_box_filter.dart';
import 'file:///F:/Code/freelance_app/lib/presentation/home/browse/tab_view/freelancers/freelancer_detail/freelancer_detail_screen.dart';
import 'package:freelance_app/presentation/widgets/nav_item.dart';
import 'package:freelance_app/presentation/widgets/rate.dart';
import 'package:get/get.dart';

class FreelancersScreen extends StatelessWidget {
  final controllerBrowse = Get.find<BrowseController>();

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
                    Expanded(
                      child: Obx(
                        () => SearchBoxFilter(
                          controller: controllerBrowse,
                          searchQueryController:
                              controllerBrowse.searchQueryController,
                          isSearching: controllerBrowse.isSearching.value,
                        ),
                      ),
                    ),
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
                    avatarUrl: freelancer.avatarUrl,
                    name: freelancer.name,
                    specialty: freelancer.specialty,
                    rate: freelancers[index].rate,
                    freelancerSkills: freelancer.freelancerSkills,
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
    @required this.avatarUrl,
    @required this.name,
    @required this.specialty,
    @required this.rate,
    @required this.freelancerSkills,
    @required this.onTap,
    Key key,
  }) : super(key: key);

  final String avatarUrl;
  final String name;
  final Specialty specialty;
  final int rate;
  final List<Skill> freelancerSkills;
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
                      child: avatarUrl != null
                          ? CircleAvatar(
                              radius: 75,
                              foregroundColor: Colors.transparent,
                              backgroundColor: Colors.grey.shade300,
                              child: CachedNetworkImage(
                                imageUrl: '$IMAGE/$avatarUrl',
                                httpHeaders: {
                                  HttpHeaders.authorizationHeader:
                                      'Bearer $TOKEN'
                                },
                                placeholder: (context, url) =>
                                    CupertinoActivityIndicator(),
                                imageBuilder: (context, image) => CircleAvatar(
                                  backgroundImage: image,
                                  radius: 70,
                                ),
                                errorWidget: (context, url, error) =>
                                    CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: AssetImage(
                                      'assets/images/avatarnull.jpg'),
                                  radius: 70,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                      ),
                      specialty != null
                          ? Text(specialty.name)
                          : SizedBox.shrink(),
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
              freelancerSkills != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 4, left: 10),
                      child: Wrap(
                        runSpacing: 5,
                        spacing: 5,
                        children: List.generate(
                          freelancerSkills.length,
                          (index) => NavItem(
                            title: freelancerSkills[index].name,
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
