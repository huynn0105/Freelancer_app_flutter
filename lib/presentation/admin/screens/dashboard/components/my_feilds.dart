import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/MyFiles.dart';
import 'package:freelance_app/responsive.dart';

class MyFields extends StatelessWidget {
  const MyFields({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          style: !Responsive.isMobile(context) ?TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding*3/2,
                vertical: kDefaultPadding),
          ):null,
          icon: Icon(Icons.add),
          label: Text('Thêm mới'),
        ),
        SizedBox(
          height: kDefaultPadding,
        ),
        Responsive(
          mobile: InfoCardGridView(crossAxisCount: _size.width < 530 ? 2 : 4,
            childAspectRatio: _size.width < 530 ? 2 : 1.3,),
          desktop: InfoCardGridView(childAspectRatio: _size.width < 1200 ?1.5 : 1.8,),
          tablet: InfoCardGridView(childAspectRatio: _size.width < 980 ?1.3 : 1.7,),
        )
      ],
    );
  }
}

class InfoCardGridView extends StatelessWidget {
  const InfoCardGridView({
    Key key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1.8,
  }) : super(key: key);
  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: demoMyFiels.length,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: kDefaultPadding,
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: kDefaultPadding),
      itemBuilder: (context, index) => ItemInfoCard(
        info: demoMyFiels[index],
      ),
    );
  }
}

class ItemInfoCard extends StatelessWidget {
  const ItemInfoCard({
    Key key,
    @required this.info,
  }) : super(key: key);
  final CloudStorageInfo info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kDefaultPadding*2/3),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius:
            const BorderRadius.all(Radius.circular(kDefaultPadding / 2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(kDefaultPadding / 2),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: info.color.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.all(Radius.circular(kDefaultPadding / 2)),
                ),
                child: SvgPicture.asset(
                  info.svgSrc,
                  color: info.color,
                ),
              ),
              Icon(Icons.more_vert),
            ],
          ),

          Text(info.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
             ),
        ],
      ),
    );
  }
}
