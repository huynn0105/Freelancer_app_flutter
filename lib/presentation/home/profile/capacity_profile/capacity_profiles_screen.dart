import 'package:flutter/material.dart';
import 'package:freelance_app/domain/models/capacity_profile.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:freelance_app/constant.dart';
import '../../../../responsive.dart';
import 'capacity_profile_controller.dart';
import 'components/capacity_card.dart';
class CapacityProfilesScreen extends StatelessWidget {


  final List<CapacityProfile> capacityProfiles;
  CapacityProfilesScreen({this.capacityProfiles});

  @override
  Widget build(BuildContext context) {
    return Container(
      color:  Colors.grey[100],
      padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? 0.0 : 250),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Hồ sơ năng lực'),
        ),
        body: capacityProfiles.isNotEmpty ? ListView.builder(
                  itemCount: capacityProfiles.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: CapacityCard(
                        capacityProfile: capacityProfiles[index],
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
