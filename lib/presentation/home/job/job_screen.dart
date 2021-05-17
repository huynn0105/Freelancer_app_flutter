import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:freelance_app/presentation/routes/navigation.dart';
import 'package:get/get.dart';

class JobScreen extends GetWidget<HomeController> {

  void logout() async {
    await controller.logOut();
    Get.offAllNamed(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      var user= controller.account.value;
      return Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: user.name != null ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(user.name,user.avatarUrl),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Hello ${user.name}',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: [
                          Earning(),
                          Resume(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Project(),
            ],
          ) : const SizedBox.shrink(),
        ),
      );}
    );
  }

  Widget buildHeader(String name,String url) {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[300],
                child: IconButton(
                  icon: Icon(
                    Icons.notifications_outlined,
                  ),
                  onPressed: (){},
                ),
              ),
              Positioned(
                right: 0,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.pinkAccent,
                  child: Text(
                    '1',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: (){
                logout();
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.pinkAccent,
                child: CachedNetworkImage(
                  imageUrl: '$IMAGE/$url',
                  httpHeaders: {HttpHeaders.authorizationHeader: 'Bearer $TOKEN'},
                  placeholder: (context, url) => CupertinoActivityIndicator(),
                  imageBuilder: (context, image) => CircleAvatar(
                    backgroundImage: image,
                    radius: 19,
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: AssetImage('assets/images/avatarnull.png'),
                    radius: 19,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Project extends StatelessWidget {
  const Project({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'Project',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.arrow_drop_down),
                    Spacer(),
                    Text(
                      'See All',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              )),
          Expanded(
            flex: 10,
            child: ListView.builder(itemBuilder: (context, index) {
              return Container(
                height: 120,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            height: 54,
                            width: 54,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  bottom: 0,
                                  right: 0,
                                  top: 0,
                                  child: CircleAvatar(),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    height: 24,
                                    width: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white),

                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Calendar Application Design',style: TextStyle(fontWeight: FontWeight.bold),),
                              Row(
                                children: [
                                  Text('Dream Walker',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 13),),
                                  SizedBox(width: 8,),
                                  Container(
                                    height: 16,
                                    width: 48,
                                    decoration: BoxDecoration(
                                      color: Colors.purple[50],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                      child: Text('Mobile',style: TextStyle(color: Colors.purple,fontSize: 10),),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Spacer(),
                          IconButton(icon: Icon(Icons.keyboard_arrow_right), onPressed: (){})
                        ],
                      ),
                    ),
                    Divider(),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '23',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Days',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 4,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Next Schedule',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 4,
                                        backgroundColor: Colors.purple,
                                      ),
                                      SizedBox(width: 8,),
                                      Text('Upload Prototype',style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('July 25'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class Resume extends StatelessWidget {
  const Resume({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Resume',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        width: double.infinity,
                        child: ListView.builder(itemBuilder: (context, index) {
                          return Container(
                            height: 48,
                            margin: EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 42,
                                    width: 42,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.description,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, top: 4, bottom: 4),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Freelance R..',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        Text(
                                          '123.3MB',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}

class Earning extends StatelessWidget {
  const Earning({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Earning',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Icon(Icons.keyboard_arrow_right),
              ],
            ),
            Text(
              'Yesterday',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text(
                  '\$',
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                ),
                Text(
                  '1,025',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
