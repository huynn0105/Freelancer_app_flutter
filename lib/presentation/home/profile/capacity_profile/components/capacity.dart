import 'package:flutter/material.dart';
import 'package:freelance_app/domain/models/capacity_profile.dart';
import 'package:freelance_app/presentation/home/profile/capacity_profile/capacity_profiles_screen.dart';
import 'package:get/get.dart';
import 'capacity_card.dart';

class Capacity extends StatefulWidget {
  const Capacity({
    Key key,
    @required this.capacityProfiles,
    @required this.onTap,
  }) : super(key: key);

  final List<CapacityProfile> capacityProfiles;
  final GestureTapCallback onTap;

  @override
  _CapacityState createState() => _CapacityState();
}

class _CapacityState extends State<Capacity> {
  int currentSlider = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Expanded(
            flex: 7,
            child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentSlider = value;
                  });
                },
                controller:
                    PageController(viewportFraction: 0.8, initialPage: 0),
                itemCount: widget.capacityProfiles.length + 1,
                itemBuilder: (context, index) {
                  return index == widget.capacityProfiles.length
                      ? IconButton(
                          icon: Icon(Icons.more_horiz),
                          onPressed: widget.onTap,)
                      : CapacityCard(
                          capacityProfile: widget.capacityProfiles[index],
                        );
                }),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.capacityProfiles.length + 1,
                  (index) => buildDotNav(index: index)),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildDotNav({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentSlider == index ? 24 : 6,
      decoration: BoxDecoration(
          color:
              currentSlider == index ? Colors.blue : Colors.blue.withAlpha(70),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
