import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/service.dart';

class Services extends StatelessWidget {
  const Services({
    Key key,
    this.freelancerServices,
  }) : super(key: key);
  final List<Service> freelancerServices;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding,vertical: kDefaultPadding/2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Dịch vụ',
            style: TEXT_STYLE_PRIMARY,
          ),
          SizedBox(
            height: 5,
          ),
          freelancerServices.isNotEmpty ? ListView.builder(
            itemBuilder: (context, index) => ItemService(
              nameService: freelancerServices[index].name,
            ),
            itemCount: freelancerServices.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          ) : Text('Freelancer đang cập nhập dịch vụ'),

        ],
      ),
    );
  }
}

class ItemService extends StatelessWidget {
  const ItemService({
    Key key,
    this.nameService,
  }) : super(key: key);
  final String nameService;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            Icons.check,
            color: Color(0xFF0fe19b),
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: Text(
              '$nameService',
              style: TEXT_STYLE_ON_FOREGROUND.copyWith(color: Color(0xFF0fe19b)),
              overflow: TextOverflow.ellipsis,

            ),
          ),
        ],
      ),
    );
  }
}
