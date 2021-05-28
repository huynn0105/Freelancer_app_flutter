import 'package:flutter/material.dart';
import 'package:freelance_app/presentation/home/browse/browse_controller.dart';
import 'package:get/get.dart';
class SearchBoxFilter extends StatelessWidget {
  const SearchBoxFilter({
    Key key,
    this.controller,
    this.searchQueryController,
    this.isSearching,
  }) : super(key: key);
  final  controller;
  final TextEditingController searchQueryController;
  final bool isSearching;


  @override
  Widget build(BuildContext context) {
    return TextField(
          controller: searchQueryController,
          onTap: (){
            _startSearch(context);
          },
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            suffixIcon: isSearching
                ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _clearSearchQuery();
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
          style: TextStyle(fontSize: 18.0),
          onChanged: (query) {
            updateSearchQuery(query);
          },
    );
  }

  void _startSearch(context) {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    controller.isSearching(false);
  }

  void updateSearchQuery(String newQuery) {
    controller.searchQuery(newQuery);
    controller.searchQuery.value.isEmpty ? controller.isSearching(false) : controller.isSearching(true);
  }

  void _stopSearching() {
    _clearSearchQuery();
    controller.isSearching(false);
  }

  void _clearSearchQuery() {
    controller.searchQueryController.clear();
  }

}