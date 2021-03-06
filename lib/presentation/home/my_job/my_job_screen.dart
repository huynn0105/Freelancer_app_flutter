import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/presentation/home/my_job/tab_view/as_employer_screen.dart';
import 'package:freelance_app/presentation/home/my_job/tab_view/as_freelancer_screen.dart';

import '../../../responsive.dart';

class MyJobScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> tab = [
      'Nhà tuyển dụng',
      'Freelancer'
    ];
    return DefaultTabController(
      length: tab.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Công việc của tôi'),
          centerTitle: true,
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.blue,
            indicator: BoxDecoration(
                 color: Colors.blue),
            tabs: List.generate(
              tab.length,
                  (index) => Container(
                    height: 38,
                    alignment: Alignment.center,
                    child: Tab(
                text: tab[index],
              ),
                  ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            AsEmployerScreen(),
            AsFreelancerScreen(),
          ],
        ),
      ),
    );
  }
}