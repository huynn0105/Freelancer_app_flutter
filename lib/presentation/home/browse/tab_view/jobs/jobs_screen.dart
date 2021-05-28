import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/browse/filter/filter_search_screen.dart';
import 'package:freelance_app/presentation/home/browse/tab_view/jobs/jobs_controller.dart';
import 'package:freelance_app/presentation/widgets/nav_item.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'job_detail/job_detail_screen.dart';

class JobsScreen extends StatelessWidget {
  final controller = Get.put<JobsController>(JobsController(apiRepositoryInterface: Get.find()));

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.progressState.value != sState.loading) {
        return Scaffold(
          body: Container(
            padding: EdgeInsets.all(kDefaultPadding / 2),
            child: controller.jobs.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return JobCard(job: controller.jobs[index]);
                    },
                    shrinkWrap: true,
                    itemCount: controller.jobs.length,
                  )
                : Center(
                    child: Icon(Icons.error_outline)
                  ),
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
      } else if (controller.progressState.value == sState.failure)
        return Center(
            child: Text(
          'Lỗi, thử lại sau',
          style: TEXT_STYLE_PRIMARY,
        ));
      else
        return Center(child: CircularProgressIndicator());
    });
  }
}

class JobCard extends StatelessWidget {
  const JobCard({
    @required this.job,
    Key key,
  }) : super(key: key);
  final Job job;

  @override
  Widget build(BuildContext context) {
    final formatter = new NumberFormat("#,###");

    return InkWell(
      onTap: () => Get.to(() => JobDetailScreen(jobId: job.id)),
      child: Card(
        margin: const EdgeInsets.all(kDefaultPadding / 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding / 2),
        ),
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding / 3),
          child: Column(
            children: [
              Row(

                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        foregroundColor: Colors.transparent,
                        backgroundColor: Colors.grey.shade300,
                        child: CachedNetworkImage(
                          imageUrl: '$IMAGE/${job.avatarRenter}',
                          httpHeaders: {
                            HttpHeaders.authorizationHeader: 'Bearer $TOKEN'
                          },
                          placeholder: (context, url) =>
                              CupertinoActivityIndicator(),
                          imageBuilder: (context, image) => CircleAvatar(
                            backgroundImage: image,
                            radius: 40,
                          ),
                          errorWidget: (context, url, error) => CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage:
                                AssetImage('assets/images/avatarnull.png'),
                            radius: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: kDefaultPadding / 2),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            job.name,
                            style:
                                TEXT_STYLE_FOREIGN.copyWith(color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: kDefaultPadding / 5),
                        Row(
                          children: [
                            Icon(
                              Icons.person_outline,
                              size: 20,
                              color: Theme.of(context).primaryColor,
                            ),
                            Text('12 chào giá',
                                style: TEXT_STYLE_FOREIGN.copyWith(fontSize: 16)),
                          ],
                        ),
                        SizedBox(height: kDefaultPadding / 5),
                        Row(
                          children: [
                            Icon(Icons.access_time_outlined,
                                size: 20,
                                color: Theme.of(context).primaryColor),
                            SizedBox(width: 4),
                            Text('hạn nhận hồ sơ ${job.deadline.difference(DateTime.now()).inDays} ngày',
                                style:
                                    TEXT_STYLE_FOREIGN.copyWith(fontSize: 16)),
                            SizedBox(width: kDefaultPadding * 2),
                          ],
                        ),
                        SizedBox(height: kDefaultPadding / 5),
                        Row(
                          children: [
                            Icon(CupertinoIcons.money_dollar_circle,
                                size: 20,
                                color: Theme.of(context).primaryColor),
                            SizedBox(width: 4),
                            Text('${formatter.format(job.floorprice)} - ${formatter.format(job.cellingprice)} VNĐ',
                                style:
                                    TEXT_STYLE_FOREIGN.copyWith(fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class JobType extends StatelessWidget {
  const JobType({
    Key key,
    @required this.job,
  }) : super(key: key);

  final Job job;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavItem(
          title: job.typeOfWork.name,
          textStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: Colors.pinkAccent.shade200,
        ),
        SizedBox(
          width: kDefaultPadding / 2,
        ),
        NavItem(
            title: job.formOfWork.name,
            textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            backgroundColor: Colors.green.shade400),
        SizedBox(
          width: kDefaultPadding / 2,
        ),
        NavItem(
            title: job.payform.name,
            textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            backgroundColor: Colors.blueAccent.shade400),
      ],
    );
  }
}
