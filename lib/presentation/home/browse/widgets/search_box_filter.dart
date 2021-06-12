import 'package:flutter/material.dart';
class SearchBoxFilter extends StatelessWidget {
  const SearchBoxFilter({
    Key key,
    this.searchQueryController,
  }) : super(key: key);
  final TextEditingController searchQueryController;



  @override
  Widget build(BuildContext context) {
    return TextField(
          controller: searchQueryController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            suffixIcon: searchQueryController.text != ''
                ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                searchQueryController.text = '';
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
    );
  }

}