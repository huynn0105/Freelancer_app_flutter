import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/presentation/home/dashboard/dashboard_screen.dart';
import 'package:freelance_app/presentation/home/messages/chats_screen.dart';
import 'browse/browse_screen.dart';
import 'home_controller.dart';
import 'post_job/post_job_screen.dart';
import 'package:get/get.dart';

import 'profile/profile_screen.dart';

class HomeScreen extends GetWidget<HomeController>  {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Obx(
        (){
          return IndexedStack(
            index: controller.indexSelected.value,
            children: [
              DashboardScreen(),
              BrowseScreen(),
              ChatsScreen(),
              ProfileScreen(),
              PostJobScreen(),
            ],
          );
        },
      ),
      bottomNavigationBar: getFooter(),
        floatingActionButton: FloatingActionButton(
          heroTag: "home",
            onPressed: () {
              controller.indexSelected.value = 4;
            },
            child: Icon(
              Icons.add,
              size: 25,
            ),
          //params
        ),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked);
  }

  Widget getFooter() {
    List<IconData> iconItems = [
      Icons.dashboard,
      Icons.work,
      Icons.message,
      Icons.person,
    ];

    return Obx(
      ()=> AnimatedBottomNavigationBar(
        activeColor: Colors.blue,
        splashColor: Colors.white,
        inactiveColor: Colors.black.withOpacity(0.5),
        icons: iconItems,
        activeIndex: controller.indexSelected.value,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 10,
        iconSize: 25,
        rightCornerRadius: 10,
        onTap: (index) {
          controller.updateIndexSelected(index);
        },
      ),
    );
  }
}
