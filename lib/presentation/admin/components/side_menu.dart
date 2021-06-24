import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/admin/admin_controller.dart';
import 'package:freelance_app/presentation/admin/admin_screen.dart';
import 'package:get/get.dart';

class SideMenu extends GetWidget<AdminController> {
  const SideMenu({
    Key key,
    this.enable = true,
  }) : super(key: key);
  final bool enable;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Image.asset('assets/images/logo.png')),
          DrawerListTile(
            title: 'Dashboard',
            svgSrc: 'assets/icons/menu_dashboard.svg',
            press: () {
              controller.onReady();
              controller.indexSelected(0);
              if(enable) Get.back();
            },
          ),
          ExpansionTile(
            title: Transform.translate(
              child: Text("Quản lý dự án"),
              offset: Offset(-16, 0),
            ),
            leading: SvgPicture.asset(
              'assets/icons/menu_task.svg',
              color: Colors.black87,
            ),
            children: [
              SubItem(title: 'Tổng dự án',svgSrc: 'assets/icons/menu_doc.svg',
                press: () {
                  controller.loadJobs();
                  controller.indexSelected(1);
                  if(enable) Get.back();
                },
              ),
              SubItem(title: 'Quản lý yêu cầu',svgSrc: 'assets/icons/menu_notification.svg',
                press: () {
                  controller.loadRequest();
                  controller.indexSelected(6);
                  if(enable) Get.back();
                },
              ),
            ],

          ),


          ExpansionTile(
            title: Transform.translate(
              child: Text("Quản lý chuyên ngành và dịch vụ cung cấp"),
              offset: Offset(-16, 0),
            ),
            leading: SvgPicture.asset(
              'assets/icons/menu_task.svg',
              color: Colors.black87,
            ),
            children: [
              SubItem(title: 'Quản lý chuyên ngành',svgSrc: 'assets/icons/menu_task.svg',
                press: () {
                  controller.loadSpecialties();
                  controller.indexSelected(2);
                  if(enable) Get.back();
                },
              ),
              SubItem(title: 'Quản lý dịch vụ',svgSrc: 'assets/icons/menu_store.svg',
                press: () {
                  controller.loadServices();
                  controller.indexSelected(3);
                  if(enable) Get.back();
                },
              ),
            ],
          ),
          DrawerListTile(
            title: 'Quản lý kỹ năng cung cấp',
            svgSrc: 'assets/icons/menu_tran.svg',
            press: () {
              controller.loadSkills();
              controller.indexSelected(4);
              if(enable) Get.back();
            },
          ),
          DrawerListTile(
            title: 'Quản lý tài khoản người dùng',
            svgSrc: 'assets/icons/menu_profile.svg',
            press: () {
              controller.loadFreelancers();
              controller.indexSelected(5);
              if(enable) Get.back();
            },
          ),


        ],
      ),
    );
  }
}

class SubItem extends StatelessWidget {
  const SubItem({
    Key key,
    @required this.title,
    @required this.svgSrc,
    @required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: Row(
          children: [
            SizedBox(
              width: kDefaultPadding*2,
            ),
            SvgPicture.asset(
              svgSrc,
              color: Colors.black87,
            ),
            SizedBox(
              width: kDefaultPadding / 2,
            ),
            Expanded(child: Text(title)),
          ],
        ),
      ),
    );
  }
}