import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/browse/tab_view/jobs/job_detail/job_detail_screen.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AsEmployerScreen extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    var _listTextTabToggle = ["Tất cả", "Đang làm", "Đã hoàn thành", "Đã qua"];
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.grey[50],
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              FlutterToggleTab(
                // width in percent
                borderRadius: 10,
                height: 30,
                initialIndex: 0,
                selectedBackgroundColors: [Colors.blue, Colors.blueAccent],
                selectedTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700),
                unSelectedTextStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
                labels: _listTextTabToggle,
                selectedLabelIndex: (index) {},
                isScroll: false,
              ),
              Padding(
                padding: EdgeInsets.all(kDefaultPadding / 2),
                child: controller.account.value.jobRenters != null
                    ? controller.account.value.jobRenters.isNotEmpty
                        ? ListView.builder(
                            itemCount:
                                controller.account.value.jobRenters.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return MyJobCard(
                                job: controller.account.value.jobRenters[index],
                              );
                            })
                        : Center(
                            child: Text('Bạn chưa đăng việc nào!'),
                          )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ],
          ),
        ),
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
        color: job.deadline.difference(DateTime.now()).inDays < 0 ? Colors.grey[400] : Colors.white,
        margin: const EdgeInsets.all(kDefaultPadding / 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding / 2),
        ),
        elevation: 2,
        child: Container(
          padding: EdgeInsets.all(kDefaultPadding / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                job.deadline.difference(DateTime.now()).inDays < 0 ? 'HẾT HẠN' : 'ĐANG TÌM' ,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                job.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TEXT_STYLE_PRIMARY.copyWith(fontSize: 17),
              ),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${formatter.format(job.floorprice)} - ${formatter.format(job.cellingprice)} VNĐ',
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Text(
                    job.deadline.difference(DateTime.now()).inDays >= 0
                        ? 'Đóng trong ${job.deadline.difference(DateTime.now()).inDays == 0 ? '${job.deadline.difference(DateTime.now()).inHours} giờ' : '${job.deadline.difference(DateTime.now()).inDays} ngày'}'
                        : '${DateTime.now().difference(job.deadline).inDays} ngày trước',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              Text(
                'Chưa có freelancer nào chào giá',
                style: TextStyle(
                  color: Colors.black54,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
