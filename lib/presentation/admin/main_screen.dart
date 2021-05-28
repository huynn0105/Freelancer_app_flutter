import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/admin/screens/dashboard/dashboard_screen.dart';
import 'package:freelance_app/responsive.dart';

import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(Responsive.isDesktop(context))
              Expanded(child: SideMenu(),),
            Expanded(flex: 5, child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}



class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key key,
    @required this.title,
    @required this.svgSrc,
    @required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(svgSrc,color: Colors.black87,),
      title: Text(title,style: TextStyle(color: Colors.black87),),
    );
  }
}
