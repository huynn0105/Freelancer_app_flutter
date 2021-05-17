import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/data/data.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:freelance_app/presentation/home/profile/edit_profile.dart';
import 'package:freelance_app/presentation/home/widgets/about.dart';
import 'package:freelance_app/presentation/home/widgets/information.dart';
import 'package:freelance_app/presentation/home/widgets/record.dart';
import 'package:freelance_app/presentation/home/widgets/service.dart';
import 'package:freelance_app/presentation/home/widgets/skills.dart';
import 'package:freelance_app/presentation/home/widgets/summary.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {

  final controllerHome = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {

    return Obx(()  {
      var user = controllerHome.account.value;

      return Scaffold(
          appBar: AppBar(
            title: Text('Hồ Sơ'),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  user.avatarUrl != null ? CircleAvatar(
                    radius: 75,
                    foregroundColor: Colors.transparent,
                    backgroundColor: Colors.grey.shade300,
                    child:CachedNetworkImage(
                        imageUrl: '$IMAGE/${user.avatarUrl}',
                        httpHeaders: {HttpHeaders.authorizationHeader: 'Bearer $TOKEN'},
                        placeholder: (context, url) => CupertinoActivityIndicator(),
                        imageBuilder: (context, image) => CircleAvatar(
                          backgroundImage: image,
                          radius: 70,
                        ),
                        errorWidget: (context, url, error) => CircleAvatar(
                          backgroundColor: Colors.grey,
                          backgroundImage: AssetImage('assets/images/avatarnull.jpg'),
                          radius: 70,
                        ),
                      ),
                  ) : CircularProgressIndicator(),

                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${user.name}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  user.tile != null ? Text(
                    user.tile ,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ) : const SizedBox.shrink(),
                  controllerHome.level.value != null ? Text(
                      controllerHome.level.value,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ) : const SizedBox.shrink(),
                  user.city != null ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.black54,
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${user.website}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                        ),
                      )
                    ],
                  ) : const SizedBox.shrink(),
                  SizedBox(height: 15,),
                  Information(
                    email: user.email,
                    contract: user.website,
                    phoneNumber: user.phone,
                  ),
                  SizedBox(height: 15),
                  user.description != null ? About(
                    description: '${user.description}',
                  ) : const SizedBox.shrink(),
                  SizedBox(height: 15),
                  Skills(
                    skillsList: controllerHome.skillsFreelancer,
                  ),
                  SizedBox(height: 15),
                  Service(
                    servicesList: me.services,
                  ),
                  SizedBox(height: 15),
                  Record(),
                  SizedBox(height: 15),
                  Summary(
                    rate: me.rate,
                    totalMoney: user.balance,
                    totalVote: 3,
                    workValue: 99,
                  ),
                  SizedBox(height: 100,),

                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(EditProfileScreen());
            },
            child: Icon(
              Icons.edit,
            ),
          )
      );
    }
    );
  }
}
















