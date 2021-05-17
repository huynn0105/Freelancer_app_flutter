import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freelance_app/presentation/home/browse/job_detail/job_detail_screen.dart';
import 'package:freelance_app/presentation/home/browse/widgets/selected_box.dart';
import 'package:freelance_app/presentation/widgets/nav_item.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'browse_controller.dart';
import 'filter_search_screen.dart';

class BrowseScreen extends StatefulWidget {
  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  List<String> tab = [
    'Tất cả công việc',
    'Việc bán thời gian',
    'Việc toàn thời gian',
    'Cuộc thi'
  ];
  int active = 0;
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";
  final controller = Get.put<BrowseController>(BrowseController(
    apiRepositoryInterface: Get.find(),
  ));

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tab.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.blue,
            indicator: BoxDecoration(
                border: Border.all(color: Colors.blue), color: Colors.blue),
            tabs: List.generate(
              tab.length,
              (index) => Tab(
                text: tab[index],
              ),
            ),
          ),
          title: Text(
            'Browse',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            // child: TextField(
                            //   decoration: InputDecoration(
                            //     fillColor: Colors.black38.withAlpha(15),
                            //     prefixIcon: Icon(Icons.search),
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(8),
                            //       borderSide: BorderSide(
                            //         width: 0,
                            //         style: BorderStyle.none,
                            //       ),
                            //     ),
                            //     filled: true,
                            //     contentPadding: EdgeInsets.all(4),
                            //   ),
                            //   style: TextStyle(
                            //     fontSize: 18
                            //   ),
                            // ),
                            child: _buildSearchField(),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.red.shade400),
                            child: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.slidersH,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (builder) {
                                      return Container(
                                        padding: EdgeInsets.all(20),
                                        child: Obx(
                                          () => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Salary range',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Job type',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Wrap(
                                                runSpacing: 12,
                                                spacing: 12,
                                                children: List.generate(
                                                  controller.formOfWorks.length,
                                                  (index) {
                                                    var jobType = controller
                                                        .formOfWorks[index];
                                                    return ItemSelected(
                                                      active: controller
                                                          .jobTypeId.value,
                                                      onTap: () {
                                                        controller.jobTypeId(
                                                            jobType.id);
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
                                              Text(
                                                'Job type',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Wrap(
                                                runSpacing: 5,
                                                spacing: 5,
                                                children: List.generate(
                                                  controller.levels.length,
                                                  (index) {
                                                    var lv = controller
                                                        .levels[index];
                                                    return ItemSelected(
                                                      active: controller
                                                          .levelId.value,
                                                      onTap: () {
                                                        controller
                                                            .levelId(lv.id);
                                                      },
                                                      index: lv.id,
                                                      name: lv.name,
                                                    );
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              RoundedButton(
                                                onTap: () {},
                                                buttonName: 'Show results',
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        return ItemCard(
                          onTap: () {
                            Get.to(JobDetailScreen());
                          },
                        );
                      },
                      shrinkWrap: true,
                      itemCount: 5,
                      physics: NeverScrollableScrollPhysics(),
                    )
                  ],
                ),
              ),
            ),
            Icon(Icons.directions_transit, size: 350),
            Icon(Icons.directions_car, size: 350),
            Icon(Icons.directions_car, size: 350),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      onTap: _startSearch,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        suffixIcon: _isSearching
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _clearSearchQuery();
                },
              )
            : SizedBox.shrink(),
        fillColor: Colors.black38.withAlpha(15),
        hintText: "Search Data...",
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

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
      searchQuery.isEmpty ? _isSearching = false : _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    @required this.onTap,
    Key key,
  }) : super(key: key);
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cần tuyển lập trình viên mobile',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(3),
                      child: Text(
                        'Toàn thời gian',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Hồ Chí Minh')
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.grey[200],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Ngân sách dự kiến',
                            style:
                                TextStyle(color: Colors.black45, fontSize: 15),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('100.000'),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Hạn nhận hồ sơ',
                            style:
                                TextStyle(color: Colors.black45, fontSize: 15),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('3 ngày'),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  child: Wrap(
                    runSpacing: 5,
                    spacing: 5,
                    children: List.generate(
                        4,
                        (index) => NavItem(
                              title: 'Flutter',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final List listWords;

  DataSearch(this.listWords);

  @override
  List<Widget> buildActions(BuildContext context) {
    //Actions for app bar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the app bar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    final suggestionList = listWords;

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Text(listWords[index].titlelist),
        subtitle: Text(listWords[index].definitionlist),
      ),
      itemCount: suggestionList.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something

    final suggestionList = query.isEmpty
        ? listWords
        : listWords
            .where((p) =>
                p.titlelist.contains(RegExp(query, caseSensitive: false)))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {},
        trailing: Icon(Icons.remove_red_eye),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].titlelist.substring(0, query.length),
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text:
                        suggestionList[index].titlelist.substring(query.length),
                    style: TextStyle(color: Colors.grey)),
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}

List<ListWords> listWords = [
  ListWords('oneWord', 'OneWord definition'),
  ListWords('twoWord', 'TwoWord definition.'),
  ListWords('TreeWord', 'TreeWord definition'),
];

class ListWords {
  String titlelist;
  String definitionlist;

  ListWords(String titlelist, String definitionlist) {
    this.titlelist = titlelist;
    this.definitionlist = definitionlist;
  }
}
