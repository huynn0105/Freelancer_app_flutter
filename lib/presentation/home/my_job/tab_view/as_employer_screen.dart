import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/presentation/home/browse/tab_view/jobs/job_detail/job_detail_screen.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AsEmployerScreen extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    var _listTextTabToggle = ["Tất cả", "Đang giao", "Đang chờ", "Đã qua"];

    Color selectedColor(String status) {
      switch (status) {
        case 'Waiting':
          return Color(0xFFEAB802);
        case 'In progeress':
          return Colors.blue;
        case 'Done':
          return Colors.green;
        case 'Closed':
          return Colors.black.withOpacity(0.6);
        default:
          return Colors.amber;
      }
    }

    return Obx(
      () => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              SizedBox(height: 10),
              FlutterToggleTab(
                // width in percent
                borderRadius: 10,
                height: 30,
                initialIndex: controller.tabSelectedRenter.value,
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
                selectedIndex: controller.tabSelectedRenter.value,
                isScroll: false,
                selectedLabelIndex: (int) {
                  controller.tabSelectedRenter(int);
                  if (controller.jobsRenter[int].isEmpty)
                    controller.loadJobsRenter(int);
                },
              ),
              Obx(
                () => Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      controller.loadJobsRenter(controller.tabSelectedRenter.value);
                    },
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Padding(
                          padding: EdgeInsets.all(kDefaultPadding / 4),
                          child: controller.progressState.value ==
                                  sState.initial
                              ? controller
                                      .jobsRenter[
                                          controller.tabSelectedRenter.value]
                                      .isNotEmpty
                                  ? ListView.builder(
                                      itemCount: controller
                                          .jobsRenter[controller
                                              .tabSelectedRenter.value]
                                          .length,
                                      shrinkWrap: true,
                                      reverse: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        var job = controller.jobsRenter[
                                            controller.tabSelectedRenter
                                                .value][index];
                                        return MyJobCard(
                                          job: job,
                                          color: selectedColor(job.status),
                                        );
                                      })
                                  : controller.tabSelectedRenter.value != 1
                                      ? Column(
                                          children: [
                                            Image.asset(
                                              'assets/images/postjob.jpg',
                                              height: 250,
                                            ),
                                            Text(
                                              'Bạn chưa đăng việc nào!',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            ElevatedButton(
                                              child: Text('Đăng việc ngay'),
                                              onPressed: () {
                                                controller
                                                    .updateIndexSelected(2);
                                              },
                                            )
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            Image.asset(
                                              'assets/images/postjob.jpg',
                                              height: 250,
                                            ),
                                            Text(
                                              'Không có việc nào đang giao!',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        )
                              : Padding(
                                  padding: const EdgeInsets.only(top: 100),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )),
                    ),
                  ),
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
    this.color,
    @required this.job,
  }) : super(key: key);
  final Job job;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final formatter = new NumberFormat("#,###");
    return InkWell(
      onTap: () => Get.to(() => JobDetailScreen(jobId: job.id)),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.all(8),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding / 2, vertical: 8),
              child: Text(
                job.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TEXT_STYLE_PRIMARY.copyWith(
                    fontSize: 16, color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding / 2, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                        job.status != 'Close'
                            ? job.deadline.difference(DateTime.now()).inDays >=
                                    0
                                ? job.deadline
                                            .difference(DateTime.now())
                                            .inDays ==
                                        0
                                    ? job.deadline
                                                .difference(DateTime.now())
                                                .inHours <=
                                            0
                                        ? 'Đã đóng'
                                        : 'Đóng trong ${job.deadline.difference(DateTime.now()).inHours} giờ'
                                    : 'Đóng trong ${job.deadline.difference(DateTime.now()).inDays} ngày'
                                : 'Đã đóng'
                            : 'Đã đóng',
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
                    job.bidCount == 0
                        ? 'Chưa có freelancer nào chào giá'
                        : 'Có ${job.bidCount} chào giá',
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
