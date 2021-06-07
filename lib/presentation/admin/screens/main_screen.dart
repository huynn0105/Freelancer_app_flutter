
import 'package:flutter/material.dart';
import 'package:freelance_app/presentation/admin/admin_controller.dart';
import 'package:freelance_app/presentation/admin/components/side_menu.dart';
import 'package:freelance_app/presentation/admin/screens/main/report/report_screen.dart';
import 'package:freelance_app/presentation/admin/screens/main/user/user_screen.dart';
import 'package:freelance_app/responsive.dart';
import 'package:get/get.dart';

import 'dashboard/dashboard_screen.dart';
import 'main/components/header.dart';
import 'main/manage_job/manage_job_screen.dart';
import 'main/service/service_screen.dart';
import 'main/skill/skill_screen.dart';
import 'main/specialty/specialty_screen.dart';

class MainScreen extends GetWidget<AdminController> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      DashboardScreen(),
      ManageJobScreen(),
      SpecialtyScreen(),
      ServiceScreen(),
      SkillScreen(),
      UserScreen(),
      ReportScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Header(),
      ),
      drawer: !Responsive.isDesktop(context) ?ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 300,
        ),
        child: SideMenu(enable: true,),
      ):null,
      body: Obx(()=> _children[controller.indexSelected.value]),
    );
  }


}
