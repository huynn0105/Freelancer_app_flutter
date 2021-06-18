import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
class SetupPayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.only(bottom: kDefaultPadding,left: kDefaultPadding,right: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Text('Nạp tiền vào dự án',style: TEXT_STYLE_PRIMARY,),
            SizedBox(height: 10),
            Text('Các khoản thanh toán quan trọng bảo vệ cả bạn và freelancer mà bạn làm việc cùng. Chúng tôi đảm bảo các khoản thanh toán của bạn và bạn chỉ phát hành chúng cho freelancer của mình khi bạn đã hài lòng 100% với công việc của họ',style: TextStyle(fontSize: 16),),
            SizedBox(height: kDefaultPadding),

            Text('Số dư hiện có',style: TEXT_STYLE_PRIMARY),
            SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Row(
                children: [
                  Text('0.0',style: TextStyle(fontSize: 18,color: Colors.blue),),
                  Spacer(),
                  Text('VNĐ',style: TextStyle(fontSize: 18,color: Colors.blue),),
                  Icon(Icons.keyboard_arrow_right_outlined,color: Colors.blue),
                ],
              ),
            ),
            SizedBox(height: kDefaultPadding),
            Text('Số tiền bạn phải trả cho dự án',style: TEXT_STYLE_PRIMARY,),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [ThousandsFormatter()],
              decoration: InputDecoration(
                suffixIcon: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'VNĐ',
                      style: TextStyle(color: Colors.black54),
                    )),
              ),
            ),
            SizedBox(height: kDefaultPadding),
            Text('Tổng cộng: 350,500 VNĐ',style: TEXT_STYLE_PRIMARY.copyWith(fontSize: 22),),
            SizedBox(height: kDefaultPadding/2),
            Text('Nếu freelancer hoàn thành dự án của bạn, chúng tôi sẽ lấy 5% phí cho dự án',style: TextStyle(fontSize: 16)),
            Spacer(),
            RoundedButton(onTap: (){}, child: Text('Nạp tiền',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)),
          ],
        ),
      ),
    );
  }
}
