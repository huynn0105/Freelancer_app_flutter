import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/home/browse/browse_controller.dart';
import 'package:freelance_app/presentation/home/browse/widgets/item_selected.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';

import 'package:get/get.dart';

import 'widgets/search_box_filter.dart';

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
              SearchBoxFilter(
                controller: controller,
                searchQueryController: controller.searchQueryController,
                isSearching: controller.isSearching.value,),
              SizedBox(
                height: 10,
              ),
              Text(
                'Salary range',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                    Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: controller.floorPriceTextController,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'VNĐ',
                              style: TextStyle(color: Colors.black54),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: controller.cellingPriceTextController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'VNĐ',
                              style: TextStyle(color: Colors.black54),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ItemFilter(
                title: 'Form of work',
                controller: controller,
                list: List.generate(
                  controller.formOfWorks.length,
                      (index) {
                    var jobType = controller.formOfWorks[index];
                    return ItemSelected(
                      activeColor: Colors.red.shade400,
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
                title: 'Type of work',
                controller: controller,
                list: List.generate(
                  controller.typeOfWorks.length,
                      (index) {
                    var typeOfWork = controller.typeOfWorks[index];
                    return ItemSelected(
                      activeColor: Colors.red.shade400,
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
                title: 'Level',
                controller: controller,
                list: List.generate(
                  controller.levels.length,
                      (index) {
                    var lv = controller.levels[index];
                    return ItemSelected(
                      activeColor: Colors.red.shade400,
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

              SizedBox(
                height: 220,
              ),
              RoundedButton(
                onTap: () {},
                backgroundColor: Colors.red.shade400,
                child: Text('Show result',style: TEXT_STYLE_PRIMARY.copyWith(color: Colors.white),),
              )
            ],
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

  final BrowseController controller;
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
