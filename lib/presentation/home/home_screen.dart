
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freelance_app/presentation/home/dashboard/dashboard_screen.dart';
import 'package:freelance_app/presentation/home/messages/chats_screen.dart';
import 'package:freelance_app/presentation/home/my_job/my_job_screen.dart';
import 'browse/browse_screen.dart';
import 'home_controller.dart';
import 'post_job/post_job_screen.dart';
import 'package:get/get.dart';

import 'profile/profile_screen.dart';

class HomeScreen extends GetWidget<HomeController>  {

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      MyJobScreen(),
      BrowseScreen(),
      PostJobScreen(),
      ChatsScreen(),
      ProfileScreen(),
    ];
    return Obx(
      ()=> Scaffold(
        body: _children[controller.indexSelected.value],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black54,
          iconSize: 28,
          onTap: (index){
            controller.updateIndexSelected(index);
          }, // new
          currentIndex: controller.indexSelected.value, // new
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list_alt_outlined),label: 'Home',),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.search),label: 'Tìm',),
            BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline_sharp),label:'Đăng việc',),
            BottomNavigationBarItem(icon: Icon(Icons.message_outlined),label: 'Tin nhắn',),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled),label: 'Hồ sơ',),
          ],
        ),),
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
