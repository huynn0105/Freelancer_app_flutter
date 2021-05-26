import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/capacity_profile.dart';
import 'package:freelance_app/presentation/home/profile/capacity_profile/add_capacity_profile.dart';
import 'package:freelance_app/presentation/home/profile/capacity_profile/capacity_profile_controller.dart';
import 'package:freelance_app/presentation/home/profile/capacity_profile/capacity_profiles_screen.dart';
import 'package:freelance_app/presentation/home/profile/capacity_profile/components/capacity.dart';
import 'package:get/get.dart';
class CProfile extends StatelessWidget {
  final controller = Get.put<CapacityProfileController>(CapacityProfileController(
    apiRepositoryInterface: Get.find(),
  ));

  final List<CapacityProfile> capacityProfiles;

  CProfile({this.capacityProfiles});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                'Capacity profile',
                style: TEXT_STYLE_PRIMARY,
                overflow: TextOverflow.fade,
              ),
              Spacer(),
              TextButton(
                onPressed: () async {
                  controller.getCapacityProfiles();
                  Get.to(() => CapacityProfilesScreen());
                },
                child:capacityProfiles.isNotEmpty
                    ? Text('Show all')
                    : const SizedBox.shrink(),
              ),
            ],
          ),
          capacityProfiles.isNotEmpty
              ? Capacity(
            capacityProfiles: capacityProfiles
          )
              : Text('My Capacity Profile is Empty',),
          Center(
            child: TextButton(
              child: Text('Add more service'),
              onPressed: () {
                Get.to(() => AddCapacityProfile());
              },
            ),
          ),
        ],
      ),
    );
  }
}