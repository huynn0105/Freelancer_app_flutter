import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/post_job/widgets/input_text.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../../../constant.dart';

class RateFreelancer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Đánh giá Freelancer',style: TEXT_STYLE_PRIMARY,),
                SizedBox(height: kDefaultPadding,),
                Text('Đánh giá Freelancer',style: TEXT_STYLE_PRIMARY,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
