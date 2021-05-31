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
      ],
    );
  }
}

class InfoCardGridView extends StatelessWidget {
  const InfoCardGridView({
    Key key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 3,
    this.list,
  }) : super(key: key);
  final int crossAxisCount;
  final double childAspectRatio;
  final List<JobM> list;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: list.length,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: kDefaultPadding,
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: kDefaultPadding),
      itemBuilder: (context, index) => ItemInfoCard(
        info: list[index],
      ),
    );
  }
}

class ItemInfoCard extends StatelessWidget {
  const ItemInfoCard({
    Key key,
    @required this.info,
  }) : super(key: key);
  final JobM info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kDefaultPadding*2/3),
      decoration: BoxDecoration(
        color: info.color,
        borderRadius:
            const BorderRadius.all(Radius.circular(kDefaultPadding / 2)),
      ),
      child: Center(
        child: Text('${info.title}: ${info.num}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white,fontSize: 16),
           ),
      ),
    );
  }
}
