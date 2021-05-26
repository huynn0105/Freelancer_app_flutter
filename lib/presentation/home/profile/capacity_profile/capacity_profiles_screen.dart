import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:freelance_app/constant.dart';
import 'capacity_profile_controller.dart';
import 'components/capacity_card.dart';
class CapacityProfilesScreen extends StatelessWidget {

  final controller = Get.find<CapacityProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Capacity Profiles'),
      ),
      body: Obx(
        (){
          if(controller.progressState.value == sState.initial){
            return controller.capacityProfiles.isNotEmpty
                ? ListView.builder(
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
              child: Text(
                'Empty',
                style: TEXT_STYLE_PRIMARY,
              ),
            );
          }else if((controller.progressState.value != sState.failure))
          return Center(child: Text('Error',style: TEXT_STYLE_PRIMARY,));
          else return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }
}
