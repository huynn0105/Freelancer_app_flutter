import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelance_app/presentation/admin/screens/main_screen.dart';
import 'package:freelance_app/responsive.dart';

import 'components/side_menu.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(Responsive.isDesktop(context))
              Expanded(child: SideMenu(),),
            Expanded(flex: 4, child: MainScreen(),
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
      leading: SvgPicture.asset(svgSrc,color: Colors.black87,),
      title: Transform.translate(
        child:  Text(title,style: TextStyle(color: Colors.black87),),
        offset: Offset(-16, 0),
      ),
    );
  }
}
