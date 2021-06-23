import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/messages/chat_controller.dart';
import 'package:freelance_app/presentation/home/messages/rating/job_finished.dart';
import 'package:freelance_app/presentation/home/post_job/widgets/input_text.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../../../constant.dart';
import '../../../../responsive.dart';
class RatingScreen extends StatelessWidget {
  final Account freelancer;
  final int jobId;
  RatingScreen({this.freelancer,this.jobId});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();
    final ctrlComment = TextEditingController();
    int star = 0;
    return Container(
      color:  Colors.grey[100],
      padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? 0.0 : 250),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(title: Text('Đánh giá Freelancer'),centerTitle: true,),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    CircleAvatar(
                      radius: 40,
                      foregroundColor: Colors.transparent,
                      backgroundColor: Colors.grey.shade300,
                      child: CachedNetworkImage(
                        imageUrl: 'http://${freelancer.avatarUrl}',
                        httpHeaders: {
                          HttpHeaders.authorizationHeader:
                          'Bearer $TOKEN'
                        },
                        placeholder: (context, url) =>
                            CupertinoActivityIndicator(),
                        imageBuilder: (context, image) => CircleAvatar(
                          backgroundImage: image,
                          radius: 35,
                        ),
                        errorWidget: (context, url, error) =>
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              backgroundImage: AssetImage(
                                  'assets/images/avatarnull.png'),
                              radius: 35,
                            ),
                      ),
                    ),
                    SizedBox(height: kDefaultPadding/2,),
                    Text(freelancer.name,style: TEXT_STYLE_PRIMARY.copyWith(fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,),
                    SizedBox(height: kDefaultPadding/2,),
                    SmoothStarRating(
                      allowHalfRating: false,
                      starCount: 5,
                      rating: 0,
                      size: 40,
                      onRated: (value){
                        star = value.toInt();
                      },
                      color: Colors.yellow,
                      borderColor: Colors.yellow,
                    ),
                    SizedBox(height: kDefaultPadding),
                    InputText(
                      hint: 'Nhập bình luận...',
                      maxLines: 6,
                    ),
                    SizedBox(height: kDefaultPadding),
                    RoundedButton(onTap: (){
                        controller.sendRating(jobId, ctrlComment.text, star, freelancer.id).then((value){
                          Get.to(()=> JobFinished());
                        });
                      }, child: Text('Gửi đánh giá',style: TEXT_STYLE_PRIMARY.copyWith(color: Colors.white),)),

                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Obx(() {
              if (controller.progress.value  == sState.loading) {
                return Container(
                  color: Colors.black26,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          )
        ],
      ),
    );
  }
}
