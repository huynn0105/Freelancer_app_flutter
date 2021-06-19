import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
class SetupPayment extends StatelessWidget {
  final int balance;
  SetupPayment({this.balance});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    var ctrlPrice = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text('Nạp tiền vào dự án'),),
      body: Padding(
        padding: EdgeInsets.only(bottom: kDefaultPadding,left: kDefaultPadding,right: kDefaultPadding),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Các khoản thanh toán quan trọng bảo vệ cả bạn và freelancer mà bạn làm việc cùng. Chúng tôi đảm bảo các khoản thanh toán của bạn và bạn chỉ phát hành chúng cho freelancer của mình khi bạn đã hài lòng 100% với công việc của họ',style: TextStyle(fontSize: 16),),
                  SizedBox(height: kDefaultPadding/2),
                  Text('Số dư hiện có',style: TEXT_STYLE_PRIMARY),
                  SizedBox(height: 5,),
                  InkWell(
                    onTap: (){},
                    child: Container(
                      padding: EdgeInsets.all(15),
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
                  ),
                  SizedBox(height: kDefaultPadding),
                  Text('Số tiền bạn phải trả cho dự án',style: TEXT_STYLE_PRIMARY,),
                  Form(
                    key: formKey,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: ctrlPrice,
                      validator: RangeValida(min: balance),
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
                  ),
                  SizedBox(height: kDefaultPadding),
                  Text('Tổng cộng: 350,500 VNĐ',style: TEXT_STYLE_PRIMARY.copyWith(fontSize: 22),),
                  SizedBox(height: kDefaultPadding/2),
                  Text('Nếu freelancer hoàn thành dự án của bạn, chúng tôi sẽ lấy 5% phí cho dự án',style: TextStyle(fontSize: 16)),


                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: RoundedButton(onTap: (){
                if(formKey.currentState.validate())
                showDialog(context: context, builder: (_){
                  return AlertDialog(
                    title: Text('Xác nhận số tiền',textAlign: TextAlign.center),
                    actionsPadding: EdgeInsets.all(0),
                    contentPadding: EdgeInsets.only(top: 10,right: 20,left: 20),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Bạn sẽ trả số tiền ${ctrlPrice.text} VNĐ cho dự án này'),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            ElevatedButton(
                                onPressed: () => Get.back(),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.grey, minimumSize: Size(120, 40)),
                                child: Text('Huỷ')),
                            SizedBox(width: 20),
                            ElevatedButton(
                                onPressed: () {
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue, minimumSize: Size(120, 40)),
                                child: Text('Xác nhận')),
                          ],
                        )
                      ],
                    ),
                    actions: [


                    ],
                  );
                });
              }, child: Text('Nạp tiền',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)),
            ),
          ],
        ),
      ),
    );
  }
}

class RangeValida extends RangeValidator {
  final num min;

  RangeValida({this.min});
  @override
  String get errorText => 'Số dư không đủ!';

  @override
  bool isValid(String value) {
    try {
      final numericValue = num.parse(value.replaceAll(',', ''));
      return (numericValue <= min);
    } catch (_) {
      return false;
    }
  }
}
