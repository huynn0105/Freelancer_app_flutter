import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/job_offer.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/browse/tab_view/jobs/job_detail/job_detail_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';



class MyJobCard extends StatelessWidget {
  const MyJobCard({
    Key key,
    @required this.jobOffer,
  }) : super(key: key);
  final JobOffer jobOffer;

  @override
  Widget build(BuildContext context) {
    final df = new DateFormat('dd - MM - yyyy');
    return InkWell(
      onTap: ()=> Get.to(()=>JobDetailScreen(jobId: jobOffer.jobId,)),
      child: Card(
        margin: const EdgeInsets.all(kDefaultPadding / 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding / 2),
        ),
        elevation: 2,
        child: Container(
          height: 130,
          padding: EdgeInsets.all(kDefaultPadding / 3),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      foregroundColor: Colors.transparent,
                      backgroundColor: Colors.grey.shade300,
                      child: CachedNetworkImage(
                        imageUrl: 'http://${jobOffer.job.renter.avatarRenter}',
                        httpHeaders: {
                          HttpHeaders.authorizationHeader: 'Bearer $TOKEN'
                        },
                        placeholder: (context, url) =>
                            CupertinoActivityIndicator(),
                        imageBuilder: (context, image) => CircleAvatar(
                          backgroundImage: image,
                          radius: 27,
                        ),
                        errorWidget: (context, url, error) => CircleAvatar(
                          backgroundColor: Colors.grey,
                          backgroundImage:
                          AssetImage('assets/images/avatarnull.png'),
                          radius: 27,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: kDefaultPadding / 2,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          jobOffer.job.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TEXT_STYLE_PRIMARY.copyWith(fontSize: 20),
                        ),
                        Text(
                          jobOffer.job.renter.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 13),
                        )
                      ],
                    ),
                    Spacer(),
                    Icon(Icons.keyboard_arrow_right),
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
                            '${jobOffer.job.deadline.difference(DateTime.now()).inDays}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Ngày',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: kDefaultPadding / 3),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${jobOffer.offerPrice} VNĐ',
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
                              '${jobOffer.job.status}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${df.format(jobOffer.job.deadline)}'),
                        ),
                      ],
                    )
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
