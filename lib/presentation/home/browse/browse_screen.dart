import 'package:flutter/material.dart';
import 'package:freelance_app/presentation/home/browse/tab_view/jobs/jobs_screen.dart';
import '../../../responsive.dart';
import 'tab_view/freelancers/freelancer_screen.dart';


class BrowseScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<String> tab = [
      'Tìm việc làm',
      'Thuê Freelancer'
    ];
    return DefaultTabController(
      length: tab.length,
      child: Scaffold(

        appBar: AppBar(
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.blue,
            indicator: BoxDecoration(
                border: Border.all(color: Colors.blue), color: Colors.blue),
            tabs: List.generate(
              tab.length,
              (index) => Container(
                height: 38,
                child: Tab(
                  text: tab[index],
                ),
              ),
            ),
          ),
          title: Text(
            'Tìm',
          ),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            JobsScreen(),
            FreelancersScreen(),
          ],
        ),

      ),
    );
  }

}
