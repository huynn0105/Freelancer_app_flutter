import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/home/messages/chat_controller.dart';
import 'package:freelance_app/presentation/home/messages/chats_screen.dart';
import 'package:freelance_app/presentation/home/my_job/my_job_screen.dart';
import 'package:freelance_app/presentation/home/post_job/post_job_controller.dart';
import 'package:freelance_app/responsive.dart';
import 'browse/browse_screen.dart';
import 'browse/tab_view/freelancers/freelancer_controller.dart';
import 'browse/tab_view/jobs/jobs_controller.dart';
import 'home_controller.dart';
import 'post_job/post_job_screen.dart';
import 'package:get/get.dart';

import 'profile/profile_screen.dart';

class HomeScreen extends GetWidget<HomeController> {


  @override
  Widget build(BuildContext context) {
    final jobController = Get.put<JobsController>(JobsController(apiRepositoryInterface: Get.find()));
    final freelancerController = Get.put<FreelancerController>(FreelancerController(apiRepositoryInterface: Get.find()));
    final postJobController = Get.put<PostJobController>(PostJobController(apiRepositoryInterface: Get.find()));
    var chatController = Get.put<ChatController>(ChatController(apiRepositoryInterface: Get.find()));

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

                          jobController.loadJobs();
                          freelancerController.loadFreelancer();
                        }),
                    TextButton(
                        style: TextButton.styleFrom(minimumSize: Size(100, 50)),
                        child: Text('Đăng việc', style: TextStyle(fontSize: 18)),
                        onPressed: () {
                          controller.updateIndexSelected(2);
                          postJobController.getFormOfWorks();
                        }),
                    TextButton(
                        style: TextButton.styleFrom(minimumSize: Size(100, 50)),
                        child: Text('Tin nhắn', style: TextStyle(fontSize: 18)),
                        onPressed: () {
                          chatController.loadMessageUser();
                          controller.updateIndexSelected(3);
                        }),
                    TextButton(
                        style: TextButton.styleFrom(minimumSize: Size(100, 50)),
                        child: Text('Hồ Sơ', style: TextStyle(fontSize: 18)),
                        onPressed: () {
                          controller.updateIndexSelected(4);
                        }),
                    SizedBox(
                      width: kDefaultPadding * 2,
                    ),
                  ],
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
                    if(index == 0)
                      controller.onReady();
                    if(index == 1){
                      jobController.loadJobs();
                      freelancerController.loadFreelancer();
                    }
                    if(index == 2)
                      postJobController.getFormOfWorks();
                    if(index == 3)
                      chatController.loadMessageUser();
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
