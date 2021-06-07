import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/home/profile/withdraw/payment_method/payment_method_controller.dart';
import 'package:freelance_app/presentation/home/profile/withdraw/withdraw_screen.dart';
import 'package:get/get.dart';

class PaymentMethodScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<PaymentMethodController>(PaymentMethodController(
      apiRepositoryInterface: Get.find(),
    ));


    return Scaffold(
      appBar: AppBar(
        title: Text('Phương thức thanh toán'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.add),
            itemBuilder: (BuildContext bc) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.credit_card,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Chuyển khoản ngân hàng',
                    )
                  ],
                ),
                value: "/add_credit",
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.payment,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'MoMo',
                    )
                  ],
                ),
                value: "/add_momo",
              ),
            ],
            onSelected: (value){
              Get.toNamed(value);
            },
          ),
        ],
      ),
      body: Obx(
        ()=> controller.progress.value == sState.initial
                ? controller.paymentMethods.isNotEmpty ?  ListView.builder(
              itemCount: controller.paymentMethods.length,
                itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding,vertical: kDefaultPadding/2),
                child: PaymentMethodCard(paymentMethod: controller.paymentMethods[index],),
              );
            }): Text('Trống') : Center(child: CircularProgressIndicator(),),
      ),
        );
  }
}


