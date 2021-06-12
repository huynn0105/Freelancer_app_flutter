import 'package:flutter/material.dart';
import 'package:freelance_app/domain/models/skill.dart';
import 'package:freelance_app/presentation/home/post_job/post_job_controller.dart';
import 'package:freelance_app/presentation/home/post_job/type_of_work/type_of_work_screen.dart';
import 'package:freelance_app/presentation/home/widgets/search_box.dart';
import 'package:get/get.dart';

class JobSkillsScreen extends StatefulWidget {
  const JobSkillsScreen({Key key, this.id}) : super(key: key);

  @override
  _JobSkillsScreenState createState() => _JobSkillsScreenState();
  final int id;

}


class _JobSkillsScreenState extends State<JobSkillsScreen> {
  final controller = Get.find<PostJobController>();
  var _searchEdit = new TextEditingController();

  bool _isSearch = true;

  String _searchText = "";

  List<Skill> _searchListItems;

  _JobSkillsScreenState() {
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
            'Chọn kỹ năng',
          ),
          actions: [
            TextButton(
              onPressed:  () {
                controller.skillSelected();
                if(widget.id == 1){
                  controller.getTypeOfWorks();
                  Get.to(() => TypeOfWorkScreen());
                }else{
                  Get.back();
                }
              },
              child: Text(
                widget.id == 1 ? 'Tiếp theo' : 'Hoàn thành',
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
                                  controller.changeValue(
                                      skill.copyWith(isValue: value),controller.skills);
                                });
                          })
                          : _searchListView(),
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
                controller.changeValue(skill.copyWith(isValue: value),controller.skills);
              });
        });
  }
}
