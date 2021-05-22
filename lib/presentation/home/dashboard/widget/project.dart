import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/presentation/home/browse/job_detail/job_detail_screen.dart';
import 'package:freelance_app/presentation/home/post_job/post_job_detail/post_job_detail_screen.dart';
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
                  return JobCard(
                    job: jobs[index],
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  const JobCard({
    Key key,
    @required this.job,
  }) : super(key: key);
  final Job job;

  @override
  Widget build(BuildContext context) {
    final df = new DateFormat('MMM dd');
    return InkWell(
      onTap: (){
        Get.to(()=>JobDetailScreen(job: job,));
      },
      child: Container(
        height: 130,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    height: 54,
                    width: 54,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          bottom: 0,
                          right: 0,
                          top: 0,
                          child: CircleAvatar(),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                      ],
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
                        '${job.name}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TEXT_STYLE_PRIMARY.copyWith(fontSize: 20),
                      ),
                      Row(
                        children: [
                          Text(
                            '${job.renter.name}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 13),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            padding: EdgeInsets.all(kDefaultPadding / 4),
                            decoration: BoxDecoration(
                              color: Colors.purple[50],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                '${job.specialty.name}',
                                style:
                                    TextStyle(color: Colors.purple, fontSize: 12),
                              ),
                            ),
                          )
                        ],
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Next Schedule',
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
                            '${job.status}',
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
                        child: Text('${df.format(job.deadline)}'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
