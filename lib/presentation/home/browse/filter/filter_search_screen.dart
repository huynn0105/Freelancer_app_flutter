import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/home/browse/filter/filter_controller.dart';
import 'package:freelance_app/presentation/home/browse/widgets/search_box_filter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';


class FilterSearchScreen extends StatelessWidget {
  final controller = Get.put<FilterController>(FilterController(
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


                SizedBox(
                  height: 20,
                ),
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

class ItemFilter extends StatelessWidget {
  const ItemFilter({
    Key key,
    @required this.title,
    @required this.list,
    @required this.onChanged,
    @required this.selected,

  }) : super(key: key);


  final String title;
  final List list;
  final Function onChanged;
  final selected;

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Container(
          width: 90,
          child: Text(
            title,
            style: TEXT_STYLE_ON_FOREGROUND,
          ),
        ),
        SizedBox(width: 50,),
        Container(
          width: 210,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: selected,
              onChanged: (newValue) {
                onChanged(newValue);
              },
              items: list.map<DropdownMenuItem>(( value) {
                return DropdownMenuItem(
                  value: value,
                  child: Container(child: Text(value.name,style: TextStyle(fontSize: 16),),width: 170,),
                );
              }).toList(),
            ),
          ),
        )

      ],
    );
  }
}
