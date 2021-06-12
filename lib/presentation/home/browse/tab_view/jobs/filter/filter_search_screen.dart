import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/home/browse/tab_view/jobs/jobs_controller.dart';
import 'package:freelance_app/presentation/home/browse/widgets/item_filter.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';



class FilterSearchScreen extends StatelessWidget {
  final controller = Get.put<JobsController>(JobsController(
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
                SizedBox(
                  height: kDefaultPadding,
                ),
                Text('Ngân sách',style: TEXT_STYLE_ON_FOREGROUND,),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.floorPriceTextController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [ThousandsFormatter()],
                        decoration: InputDecoration(
                          hintText: 'Từ...',
                          suffixIcon: Padding(padding: EdgeInsets.all(15), child: Text('VNĐ',style: TextStyle(color: Colors.black54),)),
                        ),
                      ),
                    ),
                    SizedBox(width: kDefaultPadding,),

                    Expanded(
                      child: TextFormField(
                        controller: controller.cellingPriceTextController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [ThousandsFormatter()],
                        decoration: InputDecoration(
                          hintText: 'Từ...',
                          suffixIcon: Padding(padding: EdgeInsets.all(15), child: Text('VNĐ',style: TextStyle(color: Colors.black54),)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: kDefaultPadding),
                controller.specialties.isNotEmpty ? ItemFilter(
                  title: 'Lĩnh vực',
                  list: controller.specialties,
                  selected: controller.specialty.value,
                  onChanged: (newValue){
                    controller.specialty(newValue);
                  },
                ): SizedBox(),
                controller.services.isNotEmpty ? ItemFilter(
                  title: 'Dịch vụ',
                  list: controller.services,
                  selected: controller.service.value,
                  onChanged: (newValue){
                    controller.service(newValue);
                  },
                ): SizedBox(),

                controller.payForms.isNotEmpty ? ItemFilter(
                  title: 'Hình thức trả lương',
                  list: controller.payForms,
                  selected: controller.payForm.value,
                  onChanged: (newValue){
                    controller.payForm(newValue);
                  },
                ): SizedBox(),
                controller.formOfWorks.isNotEmpty ? ItemFilter(
                  title: 'Hình thức làm việc',
                  list: controller.formOfWorks,
                  selected: controller.formOfWork.value,
                  onChanged: (newValue){
                    controller.formOfWork(newValue);
                  },
                ): SizedBox(),
                controller.typeOfWorks.isNotEmpty ? ItemFilter(
                  title: 'Loại hình làm việc',
                  list: controller.typeOfWorks,
                  selected: controller.typeOfWork.value,
                  onChanged: (newValue){
                    controller.typeOfWork(newValue);
                  },
                ): SizedBox(),
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

