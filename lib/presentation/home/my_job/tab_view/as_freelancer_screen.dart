import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/domain/models/job_offer.dart';
import 'package:freelance_app/presentation/home/browse/tab_view/jobs/job_detail/job_detail_screen.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../responsive.dart';
class AsFreelancerScreen extends GetWidget<HomeController> {
  @override

  Widget build(BuildContext context) {
    var _listTextTabToggle = ["Đã nhận", "Đang nhận", "Chào giá", "Đã qua"];
    var size = MediaQuery.of(context).size;
    Color selectedColor(String status) {
      switch (status) {
        case 'Waiting':
          return Color(0xFFEAB802);
        case 'In progress':
          return Colors.blue;
        case 'Request rework':
          return Colors.blue;
        case 'Request cancellation':
          return Colors.blue;
        case 'Finished':
          return Colors.green;
        case 'Closed':
          return Colors.black.withOpacity(0.6);
        case 'Cancellation':
          return Colors.black.withOpacity(0.6);
        default:
          return Colors.brown;
      }
    }
    return Obx(
      ()=> Scaffold(
        floatingActionButton: controller.tabSelectedFreelancer.value == 2 ? FloatingActionButton.extended(label: Text('Lịch sử chào giá'), onPressed: () {
          controller.loadOfferHistories().then((value) => Get.to(()=>OfferHistories(offers: controller.offers)));
           },icon: Icon(Icons.filter_alt_rounded),) : null,
        body: Column(

          children: [
            SizedBox(height: kDefaultPadding/2,),
            FlutterToggleTab(
              borderRadius: 10,
              width:  Responsive.isMobile(context) ? null : size.width/24,
              height: 30,
              initialIndex: controller.tabSelectedFreelancer.value,
              isScroll: false,
              selectedBackgroundColors: [Colors.blue, Colors.blueAccent],
              selectedIndex: controller.tabSelectedFreelancer.value,
              selectedTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
              unSelectedTextStyle: TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
              labels: _listTextTabToggle,
              selectedLabelIndex: (int) {
                controller.tabSelectedFreelancer(int);
                  controller.loadJobsFreelancer(int);
              },
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                child: RefreshIndicator(
                  onRefresh: ()async{
                    controller.loadJobsFreelancer(controller.tabSelectedFreelancer.value);
                  },
                  child: controller.progressState.value == sState.initial
                      ? controller.jobsFreelancer[controller.tabSelectedFreelancer.value].isNotEmpty
                      ? ListView.builder(
                      itemCount: controller.jobsFreelancer[controller.tabSelectedFreelancer.value].length,
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        if(controller.tabSelectedFreelancer.value == 2)
                        return MyOfferCard(
                          jobOffer: controller.jobsFreelancer[controller.tabSelectedFreelancer.value][index],
                        );
                        return MyJobCard(
                          job: controller.jobsFreelancer[controller.tabSelectedFreelancer.value][index],
                          color:  selectedColor(controller.jobsFreelancer[controller.tabSelectedFreelancer.value][index].status),
                        );
                      }) : SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 40),
                            Image.asset(
                              'assets/images/postjob.jpg',
                              height: 250,
                            ),
                            controller.tabSelectedFreelancer.value != 2 ?
                            Text(
                              'Bạn chưa có việc nào!',
                              style: TextStyle(fontSize: 18),
                            ) : Text(
                              'Không có chào giá',
                              style: TextStyle(fontSize: 18),
                            ),
                            ElevatedButton(
                              child: Text('Tìm việc ngay'),
                              onPressed: () {
                                controller.updateIndexSelected(1);
                              },
                            )
                          ],
                        ),
                      ) : Padding(
              padding: const EdgeInsets.only(top: 100),
        child: Center(child: CircularProgressIndicator(),),
        ),
                )
              ),
            ),
          ],
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
                color:  color,
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
                      if(job.status == 'Closed')
                        Text('Đã đóng'),
                      if(job.status == 'In progress')
                        Text('Đang giao'),
                      if(job.status == 'Done')
                        Text('Đã hoàn thành'),
                      if(job.status == 'Waiting')
                        Text(job.deadline.difference(DateTime.now()).inDays >= 0
                            ? job.deadline.difference(DateTime.now()).inDays == 0
                            ? job.deadline.difference(DateTime.now()).inHours <= 0
                            ? 'Hết hạn nhận hồ sơ'
                            : 'Đóng trong ${job.deadline.difference(DateTime.now()).inHours} giờ'
                            : 'Đóng trong ${job.deadline.difference(DateTime.now()).inDays} ngày'
                            : 'Hết hạn nhận hồ sơ',
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
                  if(job.status == 'Finished')
                    Text('Đã hoàn thành bởi freelancer ${job.freelancer.name}'),
                  if(job.status == 'In progress')
                    Text('Đang thực hiện bởi freelancer ${job.freelancer.name}'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class OfferHistories extends StatelessWidget {
  const OfferHistories({
    Key key,
    this.offers,
  }) : super(key: key);
  final List<JobOffer> offers;

  @override
  Widget build(BuildContext context) {
    return Container(
      color:  Colors.grey[100],
      padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? 0.0 : 250),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lịch sử chào giá'),
        ),
        backgroundColor: Colors.grey[100],
        body: offers.isNotEmpty ? ListView.builder(
          itemCount:  offers.length,
            itemBuilder: (_,index)=>OfferCard(jobOffer: offers[index],)) : Center(child: Text('Bạn chưa chào giá công việc nào!'),),
      ),
    );
  }
}
class MyOfferCard extends StatelessWidget {
  const MyOfferCard({
    Key key,
    @required this.jobOffer,
  }) : super(key: key);
  final JobOffer jobOffer;

  @override
  Widget build(BuildContext context) {
    final df = new DateFormat('dd - MM - yyyy');
    final formatter = new NumberFormat("#,###");
    return InkWell(
      onTap: ()=> Get.to(()=>MyOffer(jobOffer: jobOffer)),
      child: Card(
        margin: const EdgeInsets.all(kDefaultPadding/2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding / 2),
        ),
        elevation: 3,
        child: Container(
          padding: EdgeInsets.all(kDefaultPadding / 2),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    foregroundColor: Colors.transparent,
                    backgroundColor: Colors.grey.shade300,
                    child: CachedNetworkImage(
                      imageUrl: 'http://${jobOffer.job.avatarUrl}',
                      placeholder: (context, url) =>
                          CupertinoActivityIndicator(),
                      imageBuilder: (context, image) => CircleAvatar(
                        backgroundImage: image,
                        radius: 23,
                      ),
                      errorWidget: (context, url, error) => CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage:
                        AssetImage('assets/images/avatarnull.png'),
                        radius: 23,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: kDefaultPadding / 2,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          jobOffer.job.name,
                          style: TEXT_STYLE_PRIMARY.copyWith(fontSize: 18),
                        ),
                        Text(
                          jobOffer.job.renter.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 14),
                        )
                      ],
                    ),
                  ),

                ],
              ),
              Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.money_dollar_circle,
                      size: 20,
                      color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '${formatter.format(jobOffer.offerPrice)} VNĐ',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold,fontSize: 17),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text('${df.format(jobOffer.job.deadline)}'),
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

class MyOffer extends StatelessWidget {
  const MyOffer({
    Key key,
    @required this.jobOffer,
  }) : super(key: key);

  final JobOffer jobOffer;

  @override
  Widget build(BuildContext context) {
    return Container(
      color:  Colors.grey[100],
      padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? 0.0 : 250),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chào giá của tôi'),
        ),
        backgroundColor: Colors.grey[100],
        body: OfferCard(jobOffer: jobOffer),
      ),
    );
  }
}

class OfferCard extends StatelessWidget {
  const OfferCard({
    Key key,
    @required this.jobOffer,
  }) : super(key: key);

  final JobOffer jobOffer;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 0,right: 0,bottom: 10,top: 0),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: (){
                Get.to(()=>JobDetailScreen(jobId: jobOffer.jobId));
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 27,
                    foregroundColor: Colors.transparent,
                    backgroundColor: Colors.grey.shade300,
                    child: CachedNetworkImage(
                      imageUrl:'http://${jobOffer.job.avatarUrl}',
                      placeholder: (context, url) => CupertinoActivityIndicator(),
                      imageBuilder: (context, image) => CircleAvatar(
                        backgroundImage: image,
                        radius: 25,
                      ),
                      errorWidget: (context, url, error) => CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage:
                        AssetImage('assets/images/avatarnull.png'),
                        radius: 25,
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(jobOffer.job.name,
                        style: TEXT_STYLE_PRIMARY.copyWith(color: Colors.blue)),
                        SizedBox(height: 5,),
                        Text(
                          jobOffer.job.renter.name,
                          style: TEXT_STYLE_ON_FOREGROUND.copyWith(
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 5,),
                        Text('Trạng thái: ${jobOffer.job.status == 'Waiting' ?
                        jobOffer.job.deadline.difference(DateTime.now()).inSeconds < 0
                            ? 'Closed' : 'Waiting' : '${jobOffer.job.status}'}')
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(CupertinoIcons.money_dollar_circle),
                SizedBox(width: 6),
                Text(
                  'Chi phí đề xuất: ${jobOffer.offerPrice} VNĐ',
                  style: TEXT_STYLE_ON_FOREGROUND.copyWith(
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.access_time_outlined),
                SizedBox(width: 6),
                Text('Dự kiến hoàn thành trong: ${jobOffer.expectedDay}',
                    style: TEXT_STYLE_ON_FOREGROUND.copyWith(
                        fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: kDefaultPadding / 2),
            Text(
              'Nội dung chào giá',
              style: TEXT_STYLE_PRIMARY,
            ),
            SizedBox(width: 4),
            ExpandableText(
              jobOffer.description,
              expandText: 'Xem thêm',
              collapseText: 'Ẩn đi',
              maxLines: 3,
            ),
            SizedBox(height: kDefaultPadding / 2),
            Text(
              'Kế hoạch thực hiện',
              style: TEXT_STYLE_PRIMARY,
            ),
            SizedBox(width: 4),
            ExpandableText(
              jobOffer.todoList,
              expandText: 'Xem thêm',
              collapseText: 'Ẩn đi',
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}