import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/admin/admin_controller.dart';
import 'package:freelance_app/presentation/routes/navigation.dart';
import 'package:freelance_app/responsive.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {


    return Row(
      children: [

          Spacer(
            flex: Responsive.isDesktop(context) ? 2 : 1,
          ),
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
    var controller = Get.find<AdminController>();
    return Obx(
      ()=> Container(
          margin: EdgeInsets.only(left: kDefaultPadding),
          padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 3),
          decoration: BoxDecoration(
              color: secondaryColor,
              border: Border.all(color: Colors.white10),
              borderRadius:
                  BorderRadius.all(Radius.circular(kDefaultPadding / 2))),
          child: PopupMenuButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:kDefaultPadding/2 ),
              child: Row(
                children: [
                  SizedBox(
                    width: kDefaultPadding / 2,
                  ),
                    Text(
                        '${controller.admin.value.name}',
                        style: TextStyle(fontSize: 13),
                      ),
                  Icon(
                    Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),
            onSelected: (value) {
              controller.logOut();
              Get.offAndToNamed(value);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Đăng xuất'),
                value: Routes.login,
              ),

            ],
          )),
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
        contentPadding: EdgeInsets.all(kDefaultPadding / 2),
        filled: true,
        hintText: 'Tìm',
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius:
              const BorderRadius.all(Radius.circular(kDefaultPadding / 2)),
        ),
        suffixIcon: Container(
          padding: EdgeInsets.symmetric(horizontal: 13, vertical: 12),
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
