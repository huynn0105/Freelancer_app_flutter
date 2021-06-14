import 'package:flutter/material.dart';
import 'package:freelance_app/domain/models/capacity_profile.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:freelance_app/constant.dart';
import 'capacity_profile_controller.dart';
import 'components/capacity_card.dart';
class CapacityProfilesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller =  Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Hồ sơ năng lực'),
      ),
      body: Obx(
        ()=> controller.capacityProfiles.isNotEmpty ? ListView.builder(
                itemCount: controller.capacityProfiles.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: CapacityCard(
                      capacityProfile: controller.capacityProfiles[index],
                    ),
                  );
                },
              ) : Center(
                child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
