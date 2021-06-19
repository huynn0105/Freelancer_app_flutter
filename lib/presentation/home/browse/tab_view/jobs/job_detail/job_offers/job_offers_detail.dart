import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/offer.dart';
import 'package:freelance_app/presentation/home/browse/tab_view/jobs/job_detail/job_detail_controller.dart';
import 'package:freelance_app/presentation/home/messages/chat_controller.dart';
import 'package:freelance_app/presentation/home/messages/messages_screen.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class JobOffersDetail extends StatelessWidget {
  bool isClose = false;
  JobOffersDetail({this.isClose});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<JobDetailController>();
    var controllerChat = Get.find<ChatController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Nhận chào giá'),
      ),
      body: Obx(
          ()=> controller.progressState.value == sState.initial ? controller.offers.isNotEmpty
            ? ListView.builder(
                itemBuilder: (_, index) {
                  final offer = controller.offers[index];
                  return ItemOffer(offer: offer,
                    isClose: isClose,
                    onPressed: () {
                      // controller.choseFreelancer(
                      //     controller.offers[index].freelancerId);
                      controllerChat.loadMessageChat(offer.jobId, offer.freelancerId).then((value)
                      =>  Get.to(()=>MessagesScreen(userId: offer.freelancerId,)));

                    },
                  );
                },
                itemCount: controller.offers.length,
              )
            :Center(child: Text('Chưa có chào giá nào!'),)
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

class ItemOffer extends StatelessWidget {
  const ItemOffer({Key key, @required this.onPressed,@required this.offer,this.isClose}) : super(key: key);
  final Function onPressed;
  final Offer offer;
  final isClose;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.grey.shade300,
                  child: CachedNetworkImage(
                    imageUrl:'http://${offer.freelancer.avatarUrl}',
                    placeholder: (context, url) => CupertinoActivityIndicator(),
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
                      offer.freelancer.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TEXT_STYLE_PRIMARY.copyWith(fontSize: 20),
                    ),
                    SmoothStarRating(
                      allowHalfRating: false,
                      onRated: (v) {},
                      starCount: 5,
                      rating: 5,
                      size: 18,
                      isReadOnly: true,
                      color: Colors.yellow,
                      borderColor: Colors.yellow,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Icon(CupertinoIcons.money_dollar_circle),
                SizedBox(width: 6),
                Text(
                  'Chi phí đề xuất: ${offer.offerPrice} VNĐ',
                  style: TEXT_STYLE_ON_FOREGROUND.copyWith(
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.access_time_outlined),
                SizedBox(width: 6),
                Text('Dự kiến hoàn thành trong: ${offer.expectedDay}',
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
              offer.description,
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
              offer.todoList,
              expandText: 'Xem thêm',
              collapseText: 'Ẩn đi',
              maxLines: 3,
            ),
            isClose ? ElevatedButton(onPressed: onPressed, child: Text('Thảo luận')) : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
