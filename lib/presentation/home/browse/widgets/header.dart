import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freelance_app/presentation/home/browse/filter/filter_search_screen.dart';
import 'package:freelance_app/presentation/home/browse/widgets/wheel_selected_page.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: Text('Previous'),
          style: ElevatedButton.styleFrom(minimumSize: Size(75, 36)),
        ),

        ElevatedButton(
          onPressed: () {
            showBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (context) => WheelSelectedPage());
          },
          child: Text(
            '1',
            style: TextStyle(fontSize: 18, color: Colors.blue),
          ),
          style: ElevatedButton.styleFrom(
              primary: Colors.white,
              side: BorderSide(width: 2.0, color: Colors.blue),
              minimumSize: Size(75, 36)),
        ),

        ElevatedButton(
            onPressed: () {},
            child: Text('Next'),
            style: ElevatedButton.styleFrom(minimumSize: Size(75, 36))),


      ],
    );
  }
}
