import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/post_job/widgets/input_text.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RatingScreen extends StatelessWidget {

  final Account freelancer;
  const RatingScreen({this.freelancer});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  Column(
          children: [
            Text('Đánh giá Freelancer',style: TEXT_STYLE_PRIMARY,),
            SizedBox(height: kDefaultPadding,),
            CircleAvatar(
              radius: 36,
              foregroundColor: Colors.transparent,
              backgroundColor: Colors.grey.shade300,
              child: CachedNetworkImage(
                imageUrl: 'https://thecastofcheers.com/images/9-best-online-avatars-and-how-to-make-your-own-[2020]-4.png',
                httpHeaders: {
                  HttpHeaders.authorizationHeader:
                  'Bearer $TOKEN'
                },
                placeholder: (context, url) =>
                    CupertinoActivityIndicator(),
                imageBuilder: (context, image) => CircleAvatar(
                  backgroundImage: image,
                  radius: 33,
                ),
                errorWidget: (context, url, error) =>
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: AssetImage(
                          'assets/images/avatarnull.png'),
                      radius: 33,
                    ),
              ),
            ),
            SizedBox(height: kDefaultPadding/2,),
            Text('Nguyễn Nhật Huy',style: TEXT_STYLE_PRIMARY.copyWith(fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,),
            SizedBox(height: kDefaultPadding/2,),
            SmoothStarRating(
              allowHalfRating: false,
              starCount: 5,
              rating: 0,
              size: 40,
              onRated: (value){
              },
              color: Colors.yellow,
              borderColor: Colors.yellow,
            ),
            SizedBox(height: kDefaultPadding),
            InputText(
              hint: 'Nhập bình luận...',
              maxLines: 8,
            ),
            Spacer(),
            RoundedButton(onTap: (){}, child: Text('Gửi đánh giá',style: TEXT_STYLE_PRIMARY.copyWith(color: Colors.white),))
          ],
        ));
  }
}
