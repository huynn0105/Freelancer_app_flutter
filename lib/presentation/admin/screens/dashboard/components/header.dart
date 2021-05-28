import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/responsive.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if(!Responsive.isDesktop(context))
          IconButton(icon: Icon(Icons.menu), onPressed: (){
            Scaffold.of(context).openDrawer();
          }),
        if(!Responsive.isMobile(context))
          Text('Dashboard',
            style: Theme.of(context)
                .textTheme
                .headline6
                ),
        SizedBox(width: kDefaultPadding,),
        if(!Responsive.isMobile(context))
        Spacer(flex: Responsive.isDesktop(context)? 2: 1,),
        Expanded(child: SearchField()),
        ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: kDefaultPadding),
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 3),
      decoration: BoxDecoration(
          color: secondaryColor,
          border: Border.all(color: Colors.white10),
          borderRadius:
          BorderRadius.all(Radius.circular(kDefaultPadding / 2))),
      child: Row(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage('assets/images/avatar.jpg'),
          ),
          SizedBox(
            width: kDefaultPadding / 2,
          ),
          if(!Responsive.isMobile(context))
          Text(
            'Nguyễn Nhật Huy',
          ),
          Icon(
            Icons.keyboard_arrow_down,
          ),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        fillColor: secondaryColor,
        contentPadding: EdgeInsets.all(kDefaultPadding /2),
        filled: true,
        hintText: 'Tìm',

        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius:
          const BorderRadius.all(Radius.circular(kDefaultPadding / 2)),
        ),
        suffixIcon: Container(
          padding: EdgeInsets.symmetric(horizontal: 13,vertical: 12),
          margin: EdgeInsets.all(kDefaultPadding / 3),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius:
            const BorderRadius.all(Radius.circular(kDefaultPadding / 2)),
          ),
          child: SvgPicture.asset('assets/icons/Search.svg'),
        ),
      ),
    );
  }
}
