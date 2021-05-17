import 'package:flutter/material.dart';
import 'package:freelance_app/presentation/home/browse/browse_controller.dart';
import 'package:freelance_app/presentation/home/browse/widgets/selected_box.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';

import 'package:get/get.dart';

class FilterSearchScreen extends StatelessWidget {
  final controller = Get.put<BrowseController>(BrowseController(
    apiRepositoryInterface: Get.find(),
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Salary range',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Job type',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Wrap(
                runSpacing: 12,
                spacing: 12,
                children: List.generate(
                  controller.formOfWorks.length,
                  (index) {
                    var jobType = controller.formOfWorks[index];
                    return ItemSelected(
                      active: controller.jobTypeId.value,
                      onTap: () {
                        controller.jobTypeId(jobType.id);
                      },
                      index: jobType.id,
                      name: jobType.name,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Job type',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Wrap(
                runSpacing: 5,
                spacing: 5,
                children: List.generate(
                  controller.levels.length,
                  (index) {
                    var lv = controller.levels[index];
                    return ItemSelected(
                      active: controller.levelId.value,
                      onTap: () {
                        controller.levelId(lv.id);
                      },
                      index: lv.id,
                      name: lv.name,
                    );
                  },
                ),
              ),
              SizedBox(height: 20,),
              RoundedButton(
                onTap: () {},
                buttonName: 'Show results',
              )
            ],
          ),
        ),
      ),
    );
  }
}
