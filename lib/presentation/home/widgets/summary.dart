import 'package:flutter/material.dart';
import 'package:freelance_app/presentation/widgets/rate.dart';

class Summary extends StatelessWidget {
  const Summary({
    Key key,
    this.totalMoney,
    this.totalVote,
    this.workValue,
    this.rate,
  }) : super(key: key);
  final int totalVote;
  final double totalMoney;
  final double workValue;
  final int rate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Summary',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 7,),
        Row(
          children: [
            Rate(rate: rate),
            Spacer(),
            Text('$totalVote Rating',style: TextStyle(fontSize: 16),)
          ],
        ),
        SizedBox(height: 5,),
        Row(
          children: [
            Text('Balance',style: TextStyle(fontSize: 16),),
            Spacer(),
            Text('$totalMoney VNĐ',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
          ],
        ),
        // SizedBox(height: 5,),
        // Row(
        //   children: [
        //     Text('Hoàn thành công việc',style: TextStyle(fontSize: 16),),
        //     Spacer(),
        //     Text('$workValue%',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
        //   ],
        // ),

      ],
    );
  }
}