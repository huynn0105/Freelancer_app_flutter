import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freelance_app/data/data.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/freelancer.dart';
import 'package:freelance_app/presentation/home/browse/browse_controller.dart';
import 'package:freelance_app/presentation/home/browse/filter_search_screen.dart';
import 'package:freelance_app/presentation/home/browse/widgets/search_box_filter.dart';
import 'package:freelance_app/presentation/home/freelancers/freelancer_detail/freelancer_detail_screen.dart';
import 'package:freelance_app/presentation/widgets/nav_item.dart';
import 'package:freelance_app/presentation/widgets/rate.dart';
import 'package:get/get.dart';

class FreelancersScreen extends StatelessWidget {
  final controller = Get.find<BrowseController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Container(
                child: Row(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
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
              SizedBox(height: 10,),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: freelancers.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    Freelancer freelancer = freelancers[index];
                    return ItemFreelancer(
                      avatar: freelancer.avatar,
                      name: freelancer.name,
                      serviceName: freelancer.work,
                      city: freelancer.city,
                      rate: freelancer.rate,
                      money: freelancer.money,
                      skills: freelancer.skills,
                      onTap: () {
                        Get.to(FreelancerDetailScreen(
                          account: Account(),
                        ));
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}

class ItemFreelancer extends StatelessWidget {
  const ItemFreelancer({
    @required this.avatar,
    @required this.name,
    @required this.serviceName,
    @required this.rate,
    @required this.money,
    @required this.skills,
    @required this.onTap,
    @required this.city,
    Key key,
  }) : super(key: key);
  final String avatar;
  final String name;
  final String serviceName;
  final int rate;
  final double money;
  final String city;
  final List<String> skills;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: avatar != null
                            ? AssetImage(avatar)
                            : AssetImage('assets/images/avatarnull.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style:
                            TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                      ),
                      Text(city),
                      Text(serviceName),
                      Rate(rate: rate),
                      Text(
                        '$money VNĐ',
                        style: TextStyle(
                            color: Color(0xFF0fe19b),
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.keyboard_arrow_right),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 10),
                child: Wrap(
                  runSpacing: 5,
                  spacing: 5,
                  children: List.generate(
                    skills.length,
                    (index) => NavItem(
                      title: skills[index],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(0.65),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
