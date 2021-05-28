import 'package:flutter/material.dart';
import 'package:freelance_app/presentation/admin/main_screen.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(child: Image.asset('assets/images/logo.png')),
            DrawerListTile(
              title: 'Dashboard',
              svgSrc: 'assets/icons/menu_dashboard.svg',
              press: () {},
            ),
            DrawerListTile(
              title: 'Lĩnh vực',
              svgSrc: 'assets/icons/menu_tran.svg',
              press: () {},
            ),
            DrawerListTile(
              title: 'Dịch vụ',
              svgSrc: 'assets/icons/menu_task.svg',
              press: () {},
            ),
            DrawerListTile(
              title: 'Kĩ năng',
              svgSrc: 'assets/icons/menu_doc.svg',
              press: () {},
            ),
            DrawerListTile(
              title: 'Người dùng',
              svgSrc: 'assets/icons/menu_store.svg',
              press: () {},
            ),
            DrawerListTile(
              title: 'Thông báo',
              svgSrc: 'assets/icons/menu_notification.svg',
              press: () {},
            ),
            DrawerListTile(
              title: 'Hồ sơ',
              svgSrc: 'assets/icons/menu_profile.svg',
              press: () {},
            )
          ],
        ),
      ),
    );
  }
}