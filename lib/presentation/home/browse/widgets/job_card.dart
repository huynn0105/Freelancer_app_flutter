import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/presentation/home/browse/tab_view/jobs/job_detail/job_detail_screen.dart';
import 'package:freelance_app/presentation/widgets/nav_item.dart';
import 'package:get/get.dart';

class JobCard extends StatelessWidget {
  const JobCard({
    @required this.job,
    Key key,
  }) : super(key: key);
  final Job job;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => JobDetailScreen(idJob: job.id));
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
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        foregroundColor: Colors.transparent,
                        backgroundColor: Colors.grey.shade300,
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://assets.materialup.com/uploads/3a91ac9f-f60f-4370-b58b-171d988c3b4b/preview.jpg',
                          // httpHeaders: {
                          //   HttpHeaders.authorizationHeader:
                          //   'Bearer $TOKEN'
                          // },
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
                      Row(
                        children: [
                          Icon(Icons.person_outline, size: 20,color: Theme.of(context).primaryColor,),
                          Text('99 bids',
                              style: TEXT_STYLE_FOREIGN.copyWith(fontSize: 16)),
                        ],
                      )
                    ],
                  ),
                  SizedBox(width: kDefaultPadding/2),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.name,
                          style:
                              TEXT_STYLE_FOREIGN.copyWith(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: kDefaultPadding / 5),
                        // JobType(job: job),
                        SizedBox(height: kDefaultPadding / 5),
                        Row(
                          children: [
                            Icon(Icons.access_time_outlined, size: 20,color: Theme.of(context).primaryColor),
                            SizedBox(width: 4),
                            Text('closes in 6 days',
                                style: TEXT_STYLE_FOREIGN.copyWith(fontSize: 16)),
                            SizedBox(width: kDefaultPadding*2),
                          ],
                        ),
                        SizedBox(height: kDefaultPadding / 5),
                        Row(
                          children: [
                            Icon(CupertinoIcons.money_dollar_circle, size: 20,color: Theme.of(context).primaryColor),
                            SizedBox(width: 4),
                            Text('1.000.000 - 2.000.000 VNĐ',
                                style: TEXT_STYLE_FOREIGN.copyWith(fontSize: 16)),
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
