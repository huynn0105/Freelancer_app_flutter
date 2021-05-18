import 'package:flutter/material.dart';
import 'package:freelance_app/presentation/widgets/nav_item.dart';



class ItemCard extends StatelessWidget {
  const ItemCard({
    @required this.onTap,
    Key key,
  }) : super(key: key);
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cần tuyển lập trình viên mobile',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(3),
                      child: Text(
                        'Toàn thời gian',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Hồ Chí Minh')
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.grey[200],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Ngân sách dự kiến',
                            style:
                            TextStyle(color: Colors.black45, fontSize: 15),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('100.000'),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Hạn nhận hồ sơ',
                            style:
                            TextStyle(color: Colors.black45, fontSize: 15),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('3 ngày'),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  child: Wrap(
                    runSpacing: 5,
                    spacing: 5,
                    children: List.generate(
                        4,
                            (index) => NavItem(
                          title: 'Flutter',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}