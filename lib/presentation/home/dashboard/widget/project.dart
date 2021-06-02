import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/browse/tab_view/jobs/job_detail/job_detail_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Project extends StatelessWidget {
  const Project({
    Key key,
    @required this.jobs,
  }) : super(key: key);
  final List<Job> jobs;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'Project',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.arrow_drop_down),
                    Spacer(),
                    TextButton(
                      child: Text(
                        'See All',
                        style: TextStyle(color: Colors.grey),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 10,
            child: ListView.builder(
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  return MyJobCard(
                    job: jobs[index],
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class MyJobCard extends StatelessWidget {
  const MyJobCard({
    Key key,
    @required this.job,
  }) : super(key: key);
  final Job job;

  @override
  Widget build(BuildContext context) {
    final df = new DateFormat('MMM dd');
    final formatter = new NumberFormat("#,###");
    return InkWell(
      onTap: () => Get.to(() => JobDetailScreen(
            jobId: job.id,
          )),
      child: Card(
        margin: const EdgeInsets.all(kDefaultPadding / 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding / 2),
        ),
        elevation: 2,
        child: Container(
          height: 100,
          padding: EdgeInsets.all(kDefaultPadding / 3),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
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
                          radius: 22,
                        ),
                        errorWidget: (context, url, error) => CircleAvatar(
                          backgroundColor: Colors.grey,
                          backgroundImage:
                              AssetImage('assets/images/avatarnull.png'),
                          radius: 22,
                        ),
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
                            job.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TEXT_STYLE_PRIMARY.copyWith(fontSize: 17),
                          ),
                          Text(
                            job.renter.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 13),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${job.deadline.difference(DateTime.now()).inDays}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Days',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: kDefaultPadding / 3),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${formatter.format(job.floorprice)} - ${formatter.format(job.floorprice)} VNĐ',
                            style: TextStyle(
                                color: Colors.grey, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 4,
                                backgroundColor: Colors.purple,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                job.status,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Text('${df.format(job.deadline)}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
