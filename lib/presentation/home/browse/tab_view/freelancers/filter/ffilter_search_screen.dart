import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/home/browse/tab_view/freelancers/freelancer_controller.dart';
import 'package:freelance_app/presentation/home/browse/widgets/item_filter.dart';
import 'package:get/get.dart';

class FFilterSearchScreen extends StatelessWidget {
  final controller = Get.put<FreelancerController>(FreelancerController(
    apiRepositoryInterface: Get.find(),
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Tìm kiếm'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          TextButton(
            child: Text(
              'Tìm',
              style: TextStyle(fontSize: 17),
            ),
            onPressed: () {
              controller.sendSearch();
              Get.back();

            },
          )
        ],
        elevation: 0,
      ),
      body: Container(

        padding: EdgeInsets.all(20),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  ()=> TextField(
                    controller: controller.searchQueryController,
                    onChanged: (value){
                      value.isNotEmpty ? controller.isSearching(true) : controller.isSearching(false);
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: controller.isSearching.value ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          controller.searchQueryController.text = '';
                          controller.isSearching(false);
                        },
                      ) : SizedBox.shrink(),
                      fillColor: Colors.black38.withAlpha(15),
                      hintText: "Tìm kiếm...",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.all(4),
                    ),
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                SizedBox(height: kDefaultPadding),
                controller.levels.isNotEmpty ? ItemFilter(
                  title: 'Trình độ',
                  list: controller.levels,
                  selected: controller.level.value,
                  onChanged: (newValue){
                    controller.level(newValue);
                  },
                ): SizedBox(),
                SizedBox(height: kDefaultPadding),
                controller.specialties.isNotEmpty ? ItemFilter(
                  title: 'Chuyên ngành',
                  list: controller.specialties,
                  selected: controller.specialty.value,
                  onChanged: (newValue){
                    controller.specialty(newValue);
                  },
                ): SizedBox(),
                SizedBox(height: kDefaultPadding),
                controller.services.isNotEmpty ? ItemFilter(
                  title: 'Dịch vụ',
                  list: controller.services,
                  selected: controller.service.value,
                  onChanged: (newValue){
                    controller.service(newValue);
                  },
                ): SizedBox(),
                SizedBox(height: kDefaultPadding),
                controller.provinces.isNotEmpty ? ItemFilter(
                  title: 'Địa điểm làm việc',
                  list: controller.provinces,
                  selected: controller.province.value,
                  onChanged: (newValue){
                    controller.province(newValue);
                  },
                ): SizedBox(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

