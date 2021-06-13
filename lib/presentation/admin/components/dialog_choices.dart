import 'package:flutter/material.dart';
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/domain/models/specialty.dart';
import 'package:freelance_app/presentation/admin/admin_controller.dart';
import 'package:get/get.dart';

class DiaLogChoices extends StatefulWidget {

  @override
  _DiaLogChoicesState createState() => _DiaLogChoicesState();

  final List<dynamic> listChoice;
  final List<dynamic> listSelected;
  DiaLogChoices({this.listChoice,this.listSelected});
}

class _DiaLogChoicesState<T> extends State<DiaLogChoices> {
  var controller = Get.find<AdminController>();
  var _searchEdit = new TextEditingController();


  bool _isSearch = true;

  String _searchText = "";

  List<dynamic> _searchListItems;

  _DiaLogChoicesState(){
    _searchEdit.addListener(() {
      if (_searchEdit.text.isEmpty) {
        setState(() {
          _isSearch = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearch = true;
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Chọn dịch vụ'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
          onPressed: (){
            controller.selectedList(widget.listSelected,widget.listChoice);
            Get.back();
          },)
        ],
      ),
      body: AnimatedContainer(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            searchBar(),
            list(),
          ],
        ),
      ),
    );
  }

  Widget searchBar() {
    return TextField(
        controller: _searchEdit,
        onChanged: (value){
          if(value.isNotEmpty)
            _isSearch = true;
          else
            _isSearch = false;
          setState(() {

          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          suffixIcon: _searchEdit.text.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchEdit.clear();
            },
          )
              : SizedBox.shrink(),
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
    );
  }

  Widget list() {
    return Obx(
      ()=> Expanded(
        child: Scrollbar(
          child:  !_isSearch ? widget.listChoice.isNotEmpty ?  ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.listChoice.length,
              itemBuilder: (context, index) {
                var item = widget.listChoice[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CheckboxListTile(
                      title: new Text(item.name),
                      value: item.isValue,
                      onChanged: (bool value) {
                        if(item is Service)
                        controller.changeValueService(
                            item.copyWith(isValue: value));
                        else if(item is Specialty)
                          controller.changeValueSpecialty(
                              item.copyWith(isValue: value));
                      })
                );
              }) : _searchListView(): Center(child: CircularProgressIndicator(),),
        ),
      ),
    );
  }

  Widget _searchListView() {
    _searchListItems = [];
    widget.listChoice.forEach((element) {
      if (element.name.toLowerCase().contains(_searchText.toLowerCase())) {
        _searchListItems.add(element);
      }
    });
    return _searchAddList();
  }

  Widget _searchAddList() {
    return _searchListItems.isNotEmpty ? ListView.builder(
        itemCount: _searchListItems.length,
        itemBuilder: (BuildContext context, int index) {
          var item = _searchListItems[index];
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child:  CheckboxListTile(
                title: Text(item.name),
                value: item.isValue,
                onChanged: (bool value) {
                  if(item is Service)
                    controller.changeValueService(
                        item.copyWith(isValue: value));
                  else if(item is Specialty)
                    controller.changeValueSpecialty(
                        item.copyWith(isValue: value));
                })
          );
        }): Center(child: CircularProgressIndicator(),);
  }
}

