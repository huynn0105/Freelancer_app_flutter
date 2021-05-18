import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freelance_app/presentation/home/browse/browse_controller.dart';
import 'package:freelance_app/presentation/home/browse/filter_search_screen.dart';
import 'package:freelance_app/presentation/home/browse/job_detail/job_detail_screen.dart';
import 'package:freelance_app/presentation/home/browse/widgets/item_card.dart';
import 'package:freelance_app/presentation/home/browse/widgets/search_box_filter.dart';
import 'package:get/get.dart';

class ProjectScreen extends StatelessWidget {
  final controller = Get.find<BrowseController>();

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    child: Obx(
                      ()=> SearchBoxFilter(
                        controller: controller,
                        searchQueryController: controller.searchQueryController,
                        isSearching: controller.isSearching.value,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                              return FilterSearchScreen();
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
                    Get.to(() => JobDetailScreen());
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
    );
  }
}
