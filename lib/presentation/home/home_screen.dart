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
    final List<Widget> _children = [
      DashboardScreen(),
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
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 28,
          onTap: (index){
            controller.updateIndexSelected(index);
          }, // new
          currentIndex: controller.indexSelected.value, // new
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard),label: 'Dashboard',),
            BottomNavigationBarItem(icon: Icon(Icons.work),label: 'Browse',),
            BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline),label:'Post Job',),
            BottomNavigationBarItem(icon: Icon(Icons.message),label: 'Message',),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile',),
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
