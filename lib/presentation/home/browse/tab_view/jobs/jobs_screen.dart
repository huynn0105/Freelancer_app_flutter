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
    return Obx(
      ()=> controller.progressState.value != sState.loading ? Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: controller.jobs.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return JobCard(job: controller.jobs[index]);
                  },
                  shrinkWrap: true,
                  itemCount: controller.jobs.length,
                )
              : Center(child: Text('Empty',style: TEXT_STYLE_PRIMARY,),),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showCupertinoModalBottomSheet(
                expand: true,
                context: context,
                builder: (builder) {
                  return FilterSearchScreen();
                });
          },
          child: Icon(
            Icons.search
          )
        ),

      ) : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
