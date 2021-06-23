import 'package:flutter/material.dart';
import 'package:freelance_app/domain/models/province.dart';
import 'package:freelance_app/presentation/home/post_job/pay_form/pay_form_screen.dart';
import 'package:freelance_app/presentation/home/widgets/search_box.dart';

import 'package:get/get.dart';

import '../../../../responsive.dart';

class JobLocationScreen extends StatefulWidget {
  @override
  _JobLocationScreenState createState() => _JobLocationScreenState();
  final int id;
  JobLocationScreen({this.id,this.controller});
  final controller;
}

class _JobLocationScreenState extends State<JobLocationScreen> {


  var _searchEdit = new TextEditingController();
  bool _isSearch = true;
  String _searchText = "";
  List<Province> _searchListItems;

  _JobLocationScreenState() {
    _searchEdit.addListener(() {
      if (_searchEdit.text.isEmpty) {
        setState(() {
          _isSearch = true;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearch = false;
          _searchText = _searchEdit.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var controller = widget.controller;
    return Container(
      color:  Colors.grey[100],
      padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? 0.0 : 250),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Địa điểm',
          ),
        ),
        body: Obx(
          ()=> controller.provinces.length != 1 ? Container(
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                Text(
                  'Cần tuyển freelancer làm việc tại',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Column(children: [
                    SearchBox(
                      controller: _searchEdit,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: _isSearch ? ListView.builder(
                        itemCount: controller.provinces.length,
                        itemBuilder: (context, index) {
                          var province = controller.provinces[index];
                          return ItemLocation(
                            name: province.name,
                            onTap: () {
                              controller.provinceId.value = province.provinceId;
                              controller.locationTextController.text = province.name;
                              if(widget.id == 1){
                                controller.getPayForms();
                                Get.to(() => PayFormScreen());
                              }else if(widget.id==0){
                                Get.back();
                              }
                            },
                          );
                        },
                      ) : _searchListView(controller),
                    ),
                  ]),
                )
              ],
            ),
          ) : const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  Widget _searchListView(controller) {
    _searchListItems = [];
    for (int i = 0; i < controller.provinces.length; i++) {
      var item = controller.provinces[i];
      if (item.name.toLowerCase().contains(_searchText.toLowerCase())) {
        _searchListItems.add(item);
      }
    }
    return _searchAddList(controller);
  }

  Widget _searchAddList(controller) {
    return ListView.builder(
        itemCount: _searchListItems.length,
        itemBuilder: (BuildContext context, int index) {
          var province = _searchListItems[index];
          return ItemLocation(
            name: province.name,
            onTap: () {
              controller.provinceId.value = province.provinceId;
              controller.locationTextController.text = province.name;
              if(widget.id == 1){
                controller.getPayForms();
                Get.to(() => PayFormScreen());
              }else if(widget.id == 0){
                Get.back();
              }
            },
          );
        });
  }
}

class ItemLocation extends StatelessWidget {
  const ItemLocation({
    @required this.name,
    @required this.onTap,
    Key key,
  }) : super(key: key);
  final String name;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }


}
