import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/data/data.dart';
import 'package:freelance_app/presentation/widgets/nav_item.dart';
import 'package:freelance_app/presentation/widgets/rate.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'job_detail_controller.dart';
import 'job_offers/job_offers_screen.dart';

class JobDetailScreen extends StatelessWidget {
  final int idJob;

  JobDetailScreen({@required this.idJob});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<JobDetailController>(
        JobDetailController(apiRepositoryInterface: Get.find(), jobId: idJob));

    final df = new DateFormat('dd-MM-yyyy');
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'JOB DETAIL',
          ),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(
              right: kDefaultPadding,
              left: kDefaultPadding,
              bottom: kDefaultPadding),
          child: Obx(
            () => controller.progressState.value == sState.initial
                ? Stack(
                    children: [
                      SingleChildScrollView(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: kDefaultPadding,
                              ),
                              CircleAvatar(
                                radius: 55,
                                foregroundColor: Colors.transparent,
                                backgroundColor: Colors.grey.shade300,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://res.cloudinary.com/practicaldev/image/fetch/s--ZUMyUgWZ--/c_imagga_scale,f_auto,fl_progressive,h_1080,q_auto,w_1080/https://dev-to-uploads.s3.amazonaws.com/i/am6lv2x37bole6x4poz3.jpg',
                                  // httpHeaders: {
                                  //   HttpHeaders.authorizationHeader: 'Bearer $TOKEN'
                                  // },
                                  placeholder: (context, url) =>
                                      CupertinoActivityIndicator(),
                                  imageBuilder: (context, image) =>
                                      CircleAvatar(
                                    backgroundImage: image,
                                    radius: 50,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    backgroundImage: AssetImage(
                                        'assets/images/avatarnull.png'),
                                    radius: 50,
                                  ),
                                ),
                              ),
                              SizedBox(height: kDefaultPadding / 2),
                              Text(controller.job.value.name,
                                  style: TEXT_STYLE_PRIMARY.copyWith(
                                      fontSize: 22)),
                              SizedBox(height: kDefaultPadding / 2),
                              Text(
                                controller.job.value.specialty.name,
                                style: TEXT_STYLE_ON_FOREGROUND.copyWith(
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: kDefaultPadding / 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  NavItem(
                                    title: controller.job.value.typeOfWork.name,
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                    backgroundColor: Colors.pinkAccent.shade200,
                                  ),
                                  NavItem(
                                      title:
                                          controller.job.value.formOfWork.name,
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                      backgroundColor: Colors.green.shade400),
                                  NavItem(
                                      title: controller.job.value.payform.name,
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                      backgroundColor:
                                          Colors.blueAccent.shade400),
                                ],
                              ),
                              Divider(),
                            ],
                          ),
                          Text('Service', style: TEXT_STYLE_PRIMARY),
                          SizedBox(height: kDefaultPadding / 4),
                          Text(controller.job.value.service.name,
                              style: TEXT_STYLE_FOREIGN.copyWith(
                                  color: Colors.blue)),
                          SizedBox(height: kDefaultPadding),
                          Text('Description', style: TEXT_STYLE_PRIMARY),
                          SizedBox(height: kDefaultPadding / 4),
                          Text(
                            controller.job.value.details,
                            style: TEXT_STYLE_ON_FOREGROUND,
                          ),
                          SizedBox(height: kDefaultPadding),
                          Text('Skill Sets Required',
                              style: TEXT_STYLE_PRIMARY),
                          
                          Wrap(
                            children: List.generate(
                              controller.job.value.skills.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(
                                    right: kDefaultPadding / 3,top: kDefaultPadding / 3),
                                child: NavItem(
                                  title:
                                      controller.job.value.skills[index].name,
                                  textStyle: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: kDefaultPadding),
                          Text('Salary', style: TEXT_STYLE_PRIMARY),
                          SizedBox(height: kDefaultPadding / 4),
                          Row(
                            children: [
                              Text('100.000 - ', style: TEXT_STYLE_FOREIGN),
                              Text('200.000 VNĐ', style: TEXT_STYLE_FOREIGN),
                            ],
                          ),
                          SizedBox(height: kDefaultPadding),
                          Text('Deadline', style: TEXT_STYLE_PRIMARY),
                          SizedBox(height: kDefaultPadding / 4),
                          Text('${df.format(controller.job.value.deadline)}',
                              style: TEXT_STYLE_FOREIGN),
                          SizedBox(height: kDefaultPadding),
                          Text('Location', style: TEXT_STYLE_PRIMARY),
                          SizedBox(height: kDefaultPadding / 4),
                          Text('job.province.name', style: TEXT_STYLE_FOREIGN),
                          SizedBox(height: kDefaultPadding),
                          Text('Review', style: TEXT_STYLE_PRIMARY),
                          SizedBox(height: kDefaultPadding / 4),
                          Row(
                            children: [
                              Text(
                                'Nguyen Nhat Huy',
                                style: TEXT_STYLE_FOREIGN,
                              ),
                              Spacer(),
                              Rate(rate: freelancers[1].rate),
                            ],
                          ),
                          SizedBox(height: kDefaultPadding / 5),
                          Text(
                            controller.job.value.details,
                          ),
                          SizedBox(height: kDefaultPadding * 5)
                        ],
                      ),),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: RoundedButton(
                          onTap: () => Get.to(() => JobOffersScreen()),
                          child: Text(
                            'Apply Now',
                            style: TEXT_STYLE_PRIMARY.copyWith(
                                color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ));
  }
}
