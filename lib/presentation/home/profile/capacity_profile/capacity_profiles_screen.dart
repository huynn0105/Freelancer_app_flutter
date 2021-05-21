import 'package:flutter/material.dart';
import 'package:freelance_app/domain/models/capacity_profile.dart';
import 'package:freelance_app/presentation/home/profile/components/capacity_card.dart';
import 'package:get/get.dart';

import 'capacity_profile_detail_screen.dart';

class CapacityProfilesScreen extends StatelessWidget {
  final List<CapacityProfile> capacityProfiles;

  const CapacityProfilesScreen({
    @required this.capacityProfiles,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Capacity Profiles'),
      ),
      body: ListView.builder(
        itemCount: capacityProfiles.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: CapacityCard(
              capacityProfile: capacityProfiles[index],
            ),
          );
        },
      ),
    );
  }
}
