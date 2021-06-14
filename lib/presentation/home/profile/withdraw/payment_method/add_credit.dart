import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/bank.dart';
import 'package:freelance_app/domain/models/payment_method.dart';
import 'package:freelance_app/presentation/home/post_job/widgets/input_text.dart';
import 'package:freelance_app/presentation/home/profile/withdraw/payment_method/payment_method_controller.dart';
import 'package:freelance_app/presentation/home/profile/withdraw/payment_method/payment_method_screen.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:get/get.dart';

class AddCredit extends StatelessWidget {
  final controller = Get.find<PaymentMethodController>();
  final  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final PaymentMethod paymentMethod;
  AddCredit({this.paymentMethod});

  @override
  Widget build(BuildContext context) {
    if(paymentMethod!=null){
      controller.ctrlBranchName.text = paymentMethod.branchName;
      controller.ctrlAccountNumber.text = paymentMethod.accountNumber;
      controller.ctrlOwnerName.text = paymentMethod.ownerName;
      controller.ctrlBank.text = paymentMethod.bank.name;
      controller.bankId.value = paymentMethod.bankId;
    }else{
      controller.ctrlBranchName.text = '';
      controller.ctrlAccountNumber.text = '';
      controller.ctrlOwnerName.text = '';
      controller.ctrlBank.text = '';
      controller.bankId.value = 0;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('${paymentMethod != null ? 'Chỉnh sửa' : 'Thêm'} Chuyển khoản ngân hàng'),
        actions: [
          if(paymentMethod!=null)
            IconButton(icon: Icon(Icons.delete_outline_outlined), onPressed: (){
              Get.defaultDialog(
                  radius: 10,
                  actions: [
                    ElevatedButton(onPressed: ()=>Get.back(),style: ElevatedButton.styleFrom(primary: Colors.grey,minimumSize: Size(120, 40)), child: Text('Huỷ')),
                    SizedBox(width: kDefaultPadding/2,),
                    ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(primary: Colors.blue,minimumSize: Size(120, 40 )), child: Text('Xoá')),
                  ],
                  title: 'Xác nhận xoá?',
                  middleText: 'Bạn có chắc là muốn xoá phương thức thanh toán này?'

              );
            })
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        InputText(
                          hint: 'NGUYEN VAN A',
                          label: 'Tên',
                          controller: controller.ctrlOwnerName,
                        ),
                        SizedBox(height: kDefaultPadding),
                        InputText(
                          hint: 'Nhập số tài khoản ngân hàng của bạn',
                          label: 'Tài khoản ngân hàng/Số thẻ',
                          controller: controller.ctrlAccountNumber,
                        ),
                        SizedBox(height: kDefaultPadding),
                        InputText(
                          hint: 'Nhập tên ngân hàng của bạn',
                          label: 'Tên ngân hàng',
                          controller: controller.ctrlBank,
                          readOnly: true,
                          onTap: (){
                            controller.loadBanks();
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Danh sách ngân hàng cung cấp'),
                                    content: setupBanks(),
                                  );
                                });
                          },

                        ),
                        SizedBox(height: kDefaultPadding),
                        InputText(
                          hint: 'Nhập thông tin chi nhánh ngân hàng',
                          label: 'Chi nhánh mở tài khoản(Không bắt buộc)',
                          controller: controller.ctrlBranchName,
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RoundedButton(
                      onTap: () {
                        sendBankAccount();
                      },
                      child: Text(
                        'Xác nhận',
                        style: TEXT_STYLE_PRIMARY.copyWith(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
          Positioned.fill(
            child: Obx(() {
              if (controller.progress.value == sState.loading) {
                return Container(
                  color: Colors.black26,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          )
        ],
      ),
    );
  }
  void sendBankAccount() async {
    if (formKey.currentState.validate()) {
      bool result;
      if(paymentMethod==null)
        result = await controller.sendBankAccount();
      else{
        result = await controller.sendBankAccount();
      }
      if (result) {
        Get.to(()=>PaymentMethodScreen());
        Get.snackbar('Thành công', '${paymentMethod != null ? 'Cập nhập' : 'Thêm'} phương thức thanh toán thành công',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            maxWidth: 600,
            snackPosition: SnackPosition.TOP);

      } else {
        Get.snackbar('Lỗi', 'Kiểm tra lại thông tin',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            maxWidth: 600,
            snackPosition: SnackPosition.TOP);
      }
    }else {
      Get.snackbar('Lỗi', 'Kiểm tra lại thông tin',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          maxWidth: 600,
          snackPosition: SnackPosition.TOP);
    }
  }

  Widget setupBanks() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: Obx(
            () => controller.banks.isNotEmpty
            ? ListView.builder(
          shrinkWrap: true,
          itemCount: controller.banks.length,
          itemBuilder: (BuildContext context, int index) {
            Bank bank = controller.banks[index];
            return InkWell(
              child: ListTile(
                title: Text(bank.name),
              ),
              onTap: () {
                controller.ctrlBank.text = bank.name;
                controller.bankId(bank.id);
                Get.back();
              },
            );
          },
        )
            : const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

