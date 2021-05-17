import 'package:flutter/material.dart';
import 'package:freelance_app/domain/models/skill.dart';
import 'package:freelance_app/presentation/home/profile/profile_controller.dart';
import 'package:freelance_app/presentation/home/widgets/search_box.dart';
import 'package:get/get.dart';

class SkillsScreen extends StatefulWidget {
  @override
  _SkillsScreenState createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  final controller = Get.find<ProfileController>();
  var _searchEdit = new TextEditingController();

  bool _isSearch = true;

  String _searchText = "";

  List _searchListItems;

  _SkillsScreenState() {
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
    return new Scaffold(
        appBar: AppBar(
          title: Text(
            'Select Skills',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          actions: [
            TextButton(
              onPressed: () {
                controller.selectedSkills();
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
          () => controller.skills.isNotEmpty
              ? Container(
                  padding: EdgeInsets.all(30),
                  child: Column(children: [
                    SearchBox(
                      controller: _searchEdit,
                    ),
                    Expanded(
                      child: _isSearch
                          ? ListView.builder(
                              itemCount: controller.skills.length,
                              itemBuilder: (context, index) {
                                var skill = controller.skills[index];
                                return CheckboxListTile(
                                    title: new Text(skill.name),
                                    value: skill.isValue,
                                    onChanged: (bool value) {
                                      controller.changeValueSkill(
                                          skill.copyWith(isValue: value),
                                          controller.skills);
                                    });
                              })
                          :  _searchListView(),
                    )
                  ]),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }

  Widget _searchListView() {
    _searchListItems = [];
    for (int i = 0; i < controller.skills.length; i++) {
      var item = controller.skills[i];
      if (item.name.toLowerCase().contains(_searchText.toLowerCase())) {
        _searchListItems.add(item);
      }
    }
    return _searchAddList();
  }

  Widget _searchAddList() {
    return ListView.builder(
        itemCount: _searchListItems.length,
        itemBuilder: (BuildContext context, int index) {
          var skill = _searchListItems[index];
          return CheckboxListTile(
              title: Text(skill.name),
              value: skill.isValue,
              onChanged: (bool value) {
                controller.changeValueSkill(skill.copyWith(isValue: value),controller.skills);
              });
        });
  }
}

