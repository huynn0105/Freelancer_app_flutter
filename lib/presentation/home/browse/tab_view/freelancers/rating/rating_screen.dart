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
  const RatingScreen({@required this.freelancer});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(kDefaultPadding),
          topRight: const Radius.circular(kDefaultPadding),
        ),
      ),
      child: Column(
        children: [
          Text('Rate Freelancer',style: TEXT_STYLE_PRIMARY,),
          SizedBox(height: kDefaultPadding,),
          CircleAvatar(
            radius: 36,
            foregroundColor: Colors.transparent,
            backgroundColor: Colors.grey.shade300,
            child: CachedNetworkImage(
              imageUrl: '$IMAGE/${freelancer.avatarUrl}',
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
          Text(freelancer.name,style: TEXT_STYLE_PRIMARY.copyWith(fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,),
          SizedBox(height: kDefaultPadding/2,),
          SmoothStarRating(
            allowHalfRating: false,
            starCount: 5,
            rating: 4,
            size: 40,
            onRated: (value){
            },
            color: Colors.yellow,
            borderColor: Colors.yellow,
          ),
          SizedBox(height: kDefaultPadding),
          InputText(
            hint: 'Type you review...',
            maxLines: 6,
          ),
          Spacer(),
          RoundedButton(onTap: (){}, child: Text('Rate',style: TEXT_STYLE_PRIMARY.copyWith(color: Colors.white),))
        ],
      ),
    );
  }
}
