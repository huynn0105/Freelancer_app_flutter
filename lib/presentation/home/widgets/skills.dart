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
      padding: const EdgeInsets.only(bottom: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Skill',
            style: TEXT_STYLE_PRIMARY,
          ),
          SizedBox(
            height: 5,
          ),
          Wrap(
            runSpacing: 5,
            spacing: 5,
            children: List.generate(
              skillsList.length,
              (index) => NavItem(
                title: skillsList[index].name,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.65),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
