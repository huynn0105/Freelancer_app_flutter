import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/skill.dart';
import 'package:freelance_app/presentation/widgets/nav_item.dart';

class Skills extends StatelessWidget {
  const Skills({
    Key key,
    this.skillsList,
  }) : super(key: key);
  final List<Skill> skillsList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding,vertical: kDefaultPadding/2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Kỹ năng',
            style: TEXT_STYLE_PRIMARY,
          ),
          SizedBox(
            height: 5,
          ),
          skillsList.isNotEmpty ? Wrap(
            runSpacing: 5,
            spacing: 5,
            children: List.generate(
              skillsList.length,
              (index) => NavItem(
                title: skillsList[index].name,
                textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black54,
                ))
            ),
          ) : Text('Freelancer đang cập nhật kỹ năng'),
        ],
      ),
    );
  }
}
