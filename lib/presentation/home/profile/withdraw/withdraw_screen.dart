import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/payment_method.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:freelance_app/presentation/home/post_job/widgets/input_text.dart';
import 'package:freelance_app/presentation/home/profile/withdraw/payment_method/add_credit.dart';
import 'package:freelance_app/presentation/home/profile/withdraw/payment_method/payment_method_screen.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'deposit/deposit_screen.dart';

class WithdrawScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    final formatter = new NumberFormat("#,###");
    return Scaffold(
      appBar: AppBar(
        title: Text('Tài sản cá nhân'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Số dư hiện có',style: TEXT_STYLE_PRIMARY),
              SizedBox(height: 5,),
              InkWell(
                onTap: (){
                   Get.to(()=>Deposit());
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: Row(
                    children: [
                      Obx(()=> Text('${formatter.format(controller.balance.value)}',style: TextStyle(fontSize: 18,color: Colors.blue),)),
                      Spacer(),
                      Text('VNĐ',style: TextStyle(fontSize: 18,color: Colors.blue),),
                      Icon(Icons.keyboard_arrow_right_outlined,color: Colors.blue),
                    ],
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding),
              Text('Phương thức rút tiền',style: TEXT_STYLE_PRIMARY,),
              SizedBox(height: kDefaultPadding/2),
              InkWell(
                onTap: ()=>Get.to(()=> PaymentMethodScreen()),
                child: Text('Thêm phương thức'),),
              SizedBox(height: kDefaultPadding),
              Text('Rút tiền',style: TEXT_STYLE_PRIMARY,),
              SizedBox(height: kDefaultPadding/2),
              InputText(label: 'Số lượng',suffixIcon: TextButton(child: Text('TỐI ĐA'),onPressed: (){},),inputFormatters: [ThousandsFormatter()],keyboardType: TextInputType.number,),
              SizedBox(height: kDefaultPadding),
              Container(
                padding: EdgeInsets.all(kDefaultPadding/2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.grey.shade200,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Phí giao dịch',style: TEXT_STYLE_ON_FOREGROUND),
                        Spacer(),
                        Text('10.000 VNĐ',style: TEXT_STYLE_ON_FOREGROUND),
                      ],
                    ),
                    SizedBox(height: kDefaultPadding/2,),
                    Row(
                      children: [
                        Text('Bạn sẽ nhận được',style: TEXT_STYLE_ON_FOREGROUND,),
                        Spacer(),
                        Text('100.000.000 VNĐ',style: TEXT_STYLE_ON_FOREGROUND),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: kDefaultPadding),
              RoundedButton(onTap: (){}, child: Text('Rút tiền',style: TEXT_STYLE_PRIMARY.copyWith(color: Colors.white),))
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({
    Key key,
    @required this.paymentMethod
  }) : super(key: key);
  final PaymentMethod paymentMethod;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kDefaultPadding/2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.grey.shade100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text('Chuyển khoảng ngân hàng',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
              Spacer(),
              InkWell(child: Icon(Icons.mode_edit), onTap: (){
                Get.to(()=> AddCredit(paymentMethod: paymentMethod,));
              },)
            ],
          ),
          SizedBox(height: 5),
          Text(paymentMethod.ownerName,style: TextStyle(fontWeight: FontWeight.w500),),
          SizedBox(height: 5),
          Text(paymentMethod.accountNumber,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          SizedBox(height: 5),
          Text(paymentMethod.bank.name),
          SizedBox(height: 5),
          Text(paymentMethod.branchName),
        ],
      ),
    );
  }
}



