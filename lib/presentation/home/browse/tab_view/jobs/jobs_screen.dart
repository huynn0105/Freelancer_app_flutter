import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/home/browse/filter/filter_search_screen.dart';
import 'package:freelance_app/presentation/home/browse/tab_view/jobs/jobs_controller.dart';
import 'package:freelance_app/presentation/home/browse/widgets/job_card.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class JobsScreen extends StatelessWidget {
  final controller = Get.put<JobsController>(
      JobsController(apiRepositoryInterface: Get.find()));

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.progressState.value != sState.loading) {
        return Scaffold(
          body: Container(
            padding: EdgeInsets.all(kDefaultPadding/2),
            child: controller.jobs.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return JobCard(job: controller.jobs[index]);
                    },
                    shrinkWrap: true,
                    itemCount: controller.jobs.length,
                  )
                : Center(
                    child: Text(
                      'Empty',
                      style: TEXT_STYLE_PRIMARY,
                    ),
                  ),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                showCupertinoModalBottomSheet(
                    expand: true,
                    context: context,
                    builder: (builder) {
                      return FilterSearchScreen();
                    });
              },
              child: Icon(Icons.search)),
        );
      } else if (controller.progressState.value == sState.failure)
        return Center(
            child: Text(
          'Error',
          style: TEXT_STYLE_PRIMARY,
        ));
      else
        return Center(child: CircularProgressIndicator());
    });
  }
}
