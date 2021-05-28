import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/home/browse/filter/filter_controller.dart';
import 'package:freelance_app/presentation/home/browse/widgets/item_selected.dart';
import 'package:freelance_app/presentation/home/browse/widgets/search_box_filter.dart';
import 'package:freelance_app/presentation/home/post_job/job_location/job_location_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class FilterSearchScreen extends StatelessWidget {
  final controller = Get.put<FilterController>(FilterController(
    apiRepositoryInterface: Get.find(),
  ));

  @override
  Widget build(BuildContext context) {
    final formatter = new NumberFormat("#,###");
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
              'Hoàn thành',
              style: TextStyle(fontSize: 17),
            ),
            onPressed: () {},
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
              children: [
                SearchBoxFilter(
                  controller: controller,
                  searchQueryController: controller.searchQueryController,
                  isSearching: controller.isSearching.value,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text('Ngân sách nhỏ nhất'),
                    Spacer(),
                    Text('Ngân sách lớn nhất'),
                  ],
                ),
                Obx(
                  () => RangeSlider(
                    values: controller.currentRangeValues.value,
                    min: 1,
                    max: 50,
                    onChanged: (RangeValues values) {
                      controller.currentRangeValues.value = values;
                      // setState(() {
                      //   _currentRangeValues = values;
                      // });
                    },
                  ),
                ),
                Obx(
                  () => Row(
                    children: [
                      Text(
                        '${formatter.format(controller.currentRangeValues.value.start)}M VNĐ',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Text(
                          '${formatter.format(controller.currentRangeValues.value.end)}M VNĐ',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ItemFilter(
                  title: 'Loại hình làm việc',
                  controller: controller,
                  list: List.generate(
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
                ItemFilter(
                  title: 'Hình thức làm việc',
                  controller: controller,
                  list: List.generate(
                    controller.typeOfWorks.length,
                    (index) {
                      var typeOfWork = controller.typeOfWorks[index];
                      return ItemSelected(
                        active: controller.typeOfWorkId.value,
                        onTap: () {
                          controller.typeOfWorkId(typeOfWork.id);
                        },
                        index: typeOfWork.id,
                        name: typeOfWork.name,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ItemFilter(
                  title: 'Trình độ',
                  controller: controller,
                  list: List.generate(
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
                TextField(
                  controller: controller.locationTextController,
                  decoration: InputDecoration(
                    labelText: 'Địa điểm',
                    prefixIcon: Icon(
                      Icons.location_on,
                    ),
                  ),
                  onTap: () {
                    if (controller.provinces.isEmpty) {
                      controller.loadProvinces();
                    }
                    Get.to(() => JobLocationScreen(
                          id: 0,
                          controller: controller,
                        ),preventDuplicates: false);
                  },
                  readOnly: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemFilter extends StatelessWidget {
  const ItemFilter({
    Key key,
    @required this.controller,
    this.title,
    this.list,
  }) : super(key: key);

  final controller;
  final String title;
  final List<Widget> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: TEXT_STYLE_PRIMARY,
        ),
        SizedBox(
          height: 6,
        ),
        Wrap(
          runSpacing: 6,
          spacing: 6,
          children: list,
        ),
      ],
    );
  }
}
