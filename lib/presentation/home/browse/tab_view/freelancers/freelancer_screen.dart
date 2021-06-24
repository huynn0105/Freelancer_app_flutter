import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/browse/tab_view/freelancers/freelancer_controller.dart';
import 'package:freelance_app/presentation/widgets/rate.dart';
import 'package:freelance_app/responsive.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'filter/ffilter_search_screen.dart';
import 'freelancer_detail/freelancer_detail_screen.dart';

class FreelancersScreen extends StatelessWidget {


  var controller = Get.put<FreelancerController>(FreelancerController(apiRepositoryInterface: Get.find()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: ()async{
          await controller.loadFreelancer();
        },
        child: SingleChildScrollView(

          physics: AlwaysScrollableScrollPhysics(),
          child: Obx(
            ()=> Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (controller.progressState.value == sState.initial)
                   Padding(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: controller.freelancers.isNotEmpty
                        ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.freelancers.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return FreelancerCard(
                          freelancer: controller.freelancers[index],
                        );
                      },
                    )
                        : Center(child: Icon(Icons.error_outline),
                    ),
                  ),
                 if(controller.progressState.value == sState.loading)
                  Center(child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: CircularProgressIndicator(),
                  ))
],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if(controller.services.length==1)
            controller.loadServices();
            if(controller.levels.length==1)
            controller.loadLevels();
            if(controller.specialties.length==1)
            controller.loadSpecialties();
            if(controller.provinces.length==1)
            controller.loadProvinces();

            showCupertinoModalBottomSheet(
                context: context,
                builder: (builder) {
                  return Container(
                    height: 450,
                    child: FFilterSearchScreen(),
                  );
                });
          },
          child: Icon(Icons.search)),
    );
  }
}

class FreelancerCard extends StatelessWidget {
  const FreelancerCard({
    @required this.freelancer,
    Key key,
  }) : super(key: key);
  final Account freelancer;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          () => FreelancerDetailScreen(freelancer: freelancer),
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
                                imageUrl: 'http://${freelancer.avatarUrl}',
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
                        if(freelancer.totalRating!=null)
                          if(freelancer.totalRating.count!=0)
                            Rate(rate: freelancer.totalRating.avg),
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
