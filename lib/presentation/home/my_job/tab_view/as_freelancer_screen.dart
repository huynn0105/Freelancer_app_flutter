import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/job_offer.dart';
import 'package:freelance_app/presentation/home/browse/tab_view/jobs/job_detail/job_detail_screen.dart';
import 'package:freelance_app/presentation/home/browse/tab_view/jobs/job_detail/job_offers/job_offers_detail.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class AsFreelancerScreen extends GetWidget<HomeController> {
  @override

  Widget build(BuildContext context) {
    var _listTextTabToggle = ["Đã nhận", "Đang nhận", "Chào giá", "Đã qua"];
    return Obx(
      ()=> Scaffold(
        floatingActionButton: controller.tabSelectedFreelancer.value == 2 ? FloatingActionButton.extended(label: Text('Lịch sử chào giá'), onPressed: () { Get.to(()=>OfferHistories(offers: controller.offers)); },icon: Icon(Icons.filter_alt_rounded),) : null,
        body: Column(
          children: [
            SizedBox(height: kDefaultPadding/2,),
            FlutterToggleTab(
              borderRadius: 10,
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
                if (controller.jobsFreelancer[int].isEmpty)
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
                        return MyJobCard(
                          jobOffer: controller.jobsFreelancer[controller.tabSelectedFreelancer.value][index],
                        );
                      }) : Center(
                    child: Column(
                      children: [
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

class OfferHistories extends StatelessWidget {
  const OfferHistories({
    Key key,
    this.offers,
  }) : super(key: key);
  final List<JobOffer> offers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch sử chào giá'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: offers.isNotEmpty ? ListView.builder(
          itemCount:  offers.length,
            itemBuilder: (_,index)=>OfferCard(jobOffer: offers[index],)) : Center(child: Text('Bạn chưa chào giá công việc nào!'),),),
    );
  }
}
class MyJobCard extends StatelessWidget {
  const MyJobCard({
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Chào giá của tôi'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 20),
        child: OfferCard(jobOffer: jobOffer),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    Text(
                      jobOffer.job.renter.name,
                      style: TEXT_STYLE_ON_FOREGROUND.copyWith(
                          fontWeight: FontWeight.w500),
                    ),
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
    );
  }
}