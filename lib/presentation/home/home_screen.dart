import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/messages/chat_controller.dart';
import 'package:freelance_app/presentation/home/messages/chats_screen.dart';
import 'package:freelance_app/presentation/home/my_job/my_job_screen.dart';
import 'package:freelance_app/presentation/home/post_job/post_job_controller.dart';
import 'package:freelance_app/presentation/login/login_controller.dart';
import 'package:freelance_app/presentation/routes/navigation.dart';
import 'package:freelance_app/responsive.dart';
import 'browse/browse_screen.dart';
import 'browse/tab_view/freelancers/freelancer_controller.dart';
import 'browse/tab_view/freelancers/freelancer_controller.dart';
import 'browse/tab_view/jobs/jobs_controller.dart';
import 'home_controller.dart';
import 'post_job/post_job_controller.dart';
import 'post_job/post_job_screen.dart';
import 'package:get/get.dart';

import 'profile/profile_screen.dart';

class HomeScreen extends GetWidget<HomeController> {


  @override
  Widget build(BuildContext context) {


    final List<Widget> _children = [
      MyJobScreen(),
      BrowseScreen(),
      PostJobScreen(),
      ChatsScreen(),
      ProfileScreen(),
    ];
    return Container(
      color:  Colors.grey[100],
      padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? 0.0 : 250),
      child: Obx(
        () => Scaffold(
          appBar: !Responsive.isMobile(context)
              ? AppBar(
                  actions: [
                    TextButton(
                        style: TextButton.styleFrom(minimumSize: Size(100, 50)),
                        child: Text(
                          'Trang chủ',
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          controller.updateIndexSelected(0);
                          controller.onReady();
                        }),
                    TextButton(
                        style: TextButton.styleFrom(minimumSize: Size(100, 50)),
                        child: Text('Tìm', style: TextStyle(fontSize: 18)),
                        onPressed: () {
                          controller.updateIndexSelected(1);


                        }),
                    TextButton(
                        style: TextButton.styleFrom(minimumSize: Size(100, 50)),
                        child: Text('Đăng việc', style: TextStyle(fontSize: 18)),
                        onPressed: () {
                          controller.updateIndexSelected(2);

                        }),
                    TextButton(
                        style: TextButton.styleFrom(minimumSize: Size(100, 50)),
                        child: Text('Tin nhắn', style: TextStyle(fontSize: 18)),
                        onPressed: () {

                          controller.updateIndexSelected(3);
                        }),

                    Obx(
                      ()=> PopupMenuButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal:kDefaultPadding/2 ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 17,
                                foregroundColor: Colors.transparent,
                                backgroundColor: Colors.grey.shade300,
                                child: CachedNetworkImage(
                                  imageUrl: controller.imageURL.value != ''
                                ? 'http://${controller.imageURL.value}'
                                    : 'http://$AVATAR_CURRENT',
                                  httpHeaders: {
                                    HttpHeaders.authorizationHeader:
                                    'Bearer $TOKEN'
                                  },
                                  placeholder: (context, url) =>
                                      CupertinoActivityIndicator(),
                                  imageBuilder: (context, image) => CircleAvatar(
                                    backgroundImage: image,
                                    radius: 15,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        backgroundImage: AssetImage(
                                            'assets/images/avatarnull.png'),
                                        radius: 15,
                                      ),
                                ),
                              ),
                              SizedBox(
                                width: kDefaultPadding / 2,
                              ),
                              if (Responsive.isDesktop(context) )
                                Text(
                                  '${controller.account.value.name}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              Icon(
                                Icons.keyboard_arrow_down,
                              ),
                            ],
                          ),
                        ),
                        onSelected: (value) {
                          if(value == 1){
                            controller.logOut();
                            Get.offAllNamed(Routes.login);
                          }
                          else if(value == 2){
                            controller.updateIndexSelected(4);
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text('Hồ sơ'),
                            value: 2,
                          ),
                          PopupMenuItem(
                            child: Text('Đăng xuất'),
                            value: 1,
                          ),

                        ],
                      ),
                    ),
                    SizedBox(
                      width: kDefaultPadding * 2,
                    ),
                  ],
            elevation: 2,
                )
              : null,
          body: _children[controller.indexSelected.value],
          bottomNavigationBar: Responsive.isMobile(context)
              ? BottomNavigationBar(
                  selectedItemColor: Colors.blue,
                  unselectedItemColor: Colors.black54,
                  iconSize: 28,

                  onTap: (index) {
                    controller.updateIndexSelected(index);

                  },
                  // new
                  currentIndex: controller.indexSelected.value,
                  // new
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.list_alt_outlined),
                      label: 'Trang chủ',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.search),
                      label: 'Tìm',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.add_circle_outline_sharp),
                      label: 'Đăng việc',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.message_outlined),
                      label: 'Tin nhắn',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.profile_circled),
                      label: 'Hồ sơ',
                    ),
                  ],
                )
              : null,
        ),
      ),
    );
  }
//
// Widget getFooter() {
//   List<IconData> iconItems = [
//     Icons.dashboard,
//     Icons.work,
//     Icons.add_circle_outline,
//     Icons.message,
//     Icons.person,
//   ];
//
//
//
//   return Obx(
//     ()=> AnimatedBottomNavigationBar(
//       activeColor: Colors.blue,
//       splashColor: Colors.white,
//       inactiveColor: Colors.black.withOpacity(0.5),
//       icons: iconItems,
//       activeIndex: controller.indexSelected.value,
//
//       leftCornerRadius: 32,
//       rightCornerRadius: 32,
//
//       onTap: (index) {
//         controller.updateIndexSelected(index);
//       },
//     ),
//   );
// }
}

class NavItem extends StatelessWidget {
  const NavItem({
    @required this.title,
    @required this.tapEvent,
    Key key,
  }) : super(key: key);
  final String title;
  final GestureTapCallback tapEvent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      onTap: tapEvent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          title,
          style:
              TextStyle(fontWeight: FontWeight.w300, color: Color(0XFF282828)),
        ),
      ),
    );
  }
}
