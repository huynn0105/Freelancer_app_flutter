import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'browse_controller.dart';
import 'tab_view/freelancers/freelancer_screen.dart';
import 'tab_view/projects/project_screen.dart';

class BrowseScreen extends StatelessWidget {

  List<String> tab = [
    'Project',
    'Freelancer'
  ];



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tab.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.blue,
            indicator: BoxDecoration(
                border: Border.all(color: Colors.blue), color: Colors.blue),
            tabs: List.generate(
              tab.length,
              (index) => Tab(
                text: tab[index],
              ),
            ),
          ),
          title: Text(
            'Browse',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            ProjectScreen(),
            FreelancersScreen(),

          ],
        ),
          // floatingActionButton: FloatingActionButton(
          //   heroTag: 'search',
          //   onPressed: () {
          //     showCupertinoModalBottomSheet(
          //         expand: false,
          //         context: context,
          //         builder: (builder) {
          //           return FilterSearchScreen();
          //         });
          //   },
          //   child: Icon(
          //     Icons.search,
          //   ),
          // )
      ),
    );
  }

}
