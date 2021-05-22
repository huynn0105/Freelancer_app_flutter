import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/browse/job_detail/job_offers/job_offers_screen.dart';
import 'package:freelance_app/presentation/widgets/nav_item.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class JobDetailScreen extends StatelessWidget {

  final Job job;
  JobDetailScreen({@required this.job});

  @override
  Widget build(BuildContext context) {
    final df = new DateFormat('dd-MM-yyyy');
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Job Detail',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.blue,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 20,left: 20,right: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.name,
                        style: TextStyle(
                            fontSize: 27, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                            text: "Specialty: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                            children: <TextSpan>[
                              TextSpan(
                                  text: job.specialty.name,
                                  style: TextStyle(
                                      color: Color(0xff3277D8), fontSize: 20))
                            ]),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w500),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          job.details,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10,bottom: 10),
                              child: Text(
                                'Skills:',
                                style: TextStyle(
                                    fontSize: 19,
                                    color: Color(0xff3277D8),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),

                            Wrap(
                              runSpacing: 8,
                              spacing: 8,
                              children: List.generate(
                                job.skills.length,
                                (index) => NavItem(
                                  title: job.skills[index].name,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(0.65),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Job information',
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w500),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ID Job',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'Ngày đăng',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'Deadline',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'Location',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'Salary',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'Form of work',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'Type of job',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'Pay form',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${job.id}',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      '2020-3-21',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      '${df.format(job.deadline)}',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'job.province.name',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${job.floorprice} - ',
                                          style: TextStyle(fontSize: 19),
                                        ),
                                        Text(
                                          '${job.cellingprice}',
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      job.formOfWork.name,
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      job.typeOfWork.name,
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      job.payform.name,
                                      style: TextStyle(fontSize: 19),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Render infomation',
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w500),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: CircleAvatar(
                                      radius: 55,
                                      foregroundColor: Colors.transparent,
                                      backgroundColor: Colors.grey.shade300,
                                      child: CachedNetworkImage(
                                        imageUrl: '$IMAGE/',
                                        httpHeaders: {
                                          HttpHeaders.authorizationHeader: 'Bearer $TOKEN'
                                        },
                                        placeholder: (context, url) =>
                                            CupertinoActivityIndicator(),
                                        imageBuilder: (context, image) => CircleAvatar(
                                          backgroundImage: image,
                                          radius: 50,
                                        ),
                                        errorWidget: (context, url, error) => CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          backgroundImage:
                                          AssetImage('assets/images/avatarnull.png'),
                                          radius: 50,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  job.renter.name,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Đến từ',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Đến từ',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Đã đăng',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'TP Hồ Chí Minh',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      '30/10/2020',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      '1 việc',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(JobOffersScreen());
                },
                style: ElevatedButton.styleFrom(

                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  'Ứng tuyển',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ));
  }
}
