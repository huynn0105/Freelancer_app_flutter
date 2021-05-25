import 'package:flutter/material.dart';
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/presentation/home/profile/profile_controller.dart';
import 'package:freelance_app/presentation/home/widgets/search_box.dart';
import 'package:get/get.dart';

class ServiceScreen extends StatefulWidget {
   ServiceScreen({Key key,this.controller}) : super(key: key);
  @override
  _ServiceScreenState createState() => _ServiceScreenState();

  final controller ;
}


class _ServiceScreenState extends State<ServiceScreen> {

  var _searchEdit = new TextEditingController();

  bool _isSearch = true;

  String _searchText = "";

  List<Service> _searchListItems;

  _ServiceScreenState() {
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
  void initState() {
    _isSearch = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = widget.controller;
    return new Scaffold(
        appBar: AppBar(
          title: Text(
            'Select Service',
          ),

          actions: [
            TextButton(
              onPressed:  () {
                controller.selectedServices();
                  Get.back();
              },
              child: Text(
                'Done',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        body: Obx(
          () => controller.services.isNotEmpty
              ? Container(
                  padding: EdgeInsets.all(30),
                  child: Column(children: [
                    SearchBox(
                      controller: _searchEdit,
                    ),
                    Expanded(
                      child: _isSearch
                          ? ListView.builder(
                              itemCount: controller.services.length,
                              itemBuilder: (context, index) {
                                var service = controller.services[index];
                                return CheckboxListTile(
                                    title: new Text(service.name),
                                    value: service.isValue,
                                    onChanged: (bool value) {
                                      controller.changeValueService(
                                          service.copyWith(isValue: value),controller.services);
                                    });
                              })
                          : _searchListView(controller),
                    )
                  ]),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }

  Widget _searchListView(controller) {
    _searchListItems = new List<Service>();
    for (int i = 0; i < controller.services.length; i++) {
      var item = controller.services[i];
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
          var services = _searchListItems[index];
          return CheckboxListTile(
              title: Text(services.name),
              value: services.isValue,
              onChanged: (bool value) {
                controller.changeValueService(services.copyWith(isValue: value),controller.services);
              });
        });
  }
}
