import 'package:flutter/material.dart';
import 'package:freelance_app/presentation/home/browse/tab_view/jobs/jobs_screen.dart';
import 'tab_view/freelancers/freelancer_screen.dart';


class BrowseScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<String> tab = [
      'Project',
      'Freelancer'
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
              (index) => Tab(
                text: tab[index],
              ),
            ),
          ),
          title: Text(
            'Browse',
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: TabBarView(
          children: [
            JobsScreen(),
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
