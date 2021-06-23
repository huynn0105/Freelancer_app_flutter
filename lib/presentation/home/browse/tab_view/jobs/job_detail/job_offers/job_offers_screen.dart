import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/home/browse/tab_view/jobs/job_detail/job_detail_controller.dart';
import 'package:freelance_app/presentation/home/post_job/widgets/input_text.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:get/get.dart';

import '../../../../../../../responsive.dart';

class JobOffersScreen extends StatelessWidget {
  final controller = Get.find<JobDetailController>();
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
    void sendOffer() async {
      if (_keyForm.currentState.validate()) {
        controller.sendOffer();
      } else {
        Get.snackbar('Lỗi', 'Kiểm tra lại thông tin',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            maxWidth: 600,
            snackPosition: SnackPosition.TOP);
      }
    }
    return Container(
      color:  Colors.grey[100],
      padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? 0.0 : 250),
      child: Scaffold(
        appBar: AppBar(
          title: Text('THÔNG TIN CHÀO GIÁ'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _keyForm,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Column(
                    children: [
                      EditBox(
                        title: 'Chi phí đề xuất*',
                        hint: '5,000,000',
                        controller: controller.offerPriceController,
                        validator:
                            MinLengthValidator(1, errorText: "Không được bỏ trống"),
                        keyboardType: TextInputType.number,
                        inputFormatters: [ThousandsFormatter()],
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            'VNĐ',
                          ),
                        ),
                      ),
                      SizedBox(height: kDefaultPadding),
                      EditBox(
                        title: 'Dự kiến hoàn thành trong*',
                        controller: controller.expectedDayController,
                        hint: '3',
                        validator:
                            MinLengthValidator(1, errorText: "Không được bỏ trống"),
                        keyboardType: TextInputType.number,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text('Ngày',style: TextStyle(fontSize: 16),),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: kDefaultPadding),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Đề xuất thuyết phục khách hàng*',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: kDefaultPadding/2
                      ),
                      Text(
                        '1.Bạn có những kinh nghiệm và kỹ năng nào phù hợp với dự án này?',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 4),
                      InputText(
                        hint:
                            '''- Tôi đã có xx năm kinh nghiệm trong linh vực..\n- Tôi sử dụng thành thạo các công cụ như...\n- Tôi đã từng thực hiện những dự án tương tự...''',
                        maxLines: 5,
                        controller: controller.descriptionController,
                        validator:
                            MinLengthValidator(1, errorText: "Không được bỏ trống"),
                      ),
                      SizedBox(
                        height: kDefaultPadding
                      ),
                      Text(
                        '2.Bạn dự định thực hiện dự án này như thế nào?*',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 4),
                      InputText(
                        hint:
                            '''- Đầu tiên tôi sẽ...\n- Sau đó tôi sẽ...\n- Tôi tin sẽ hoàn thành công việc theo kế hoạch''',
                        maxLines: 5,
                        controller: controller.todoListController,
                        validator:
                            MinLengthValidator(1, errorText: "Không được bỏ trống"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: kDefaultPadding
                  ),

                  RoundedButton(
                      onTap: () {
                        sendOffer();
                      },
                      child: Text(
                        'Gửi chào giá',
                        style: TEXT_STYLE_PRIMARY.copyWith(color: Colors.white),
                      )),
                  SizedBox(
                    height: kDefaultPadding*2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EditBox extends StatelessWidget {
  const EditBox({
    this.controller,
    this.title,
    this.hint,
    this.suffixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    Key key,
  }) : super(key: key);
  final String title;
  final String hint;
  final TextEditingController controller;
  final Widget suffixIcon;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: kDefaultPadding/4,
        ),
        InputText(
          hint: hint,
          controller: controller,
          suffixIcon: suffixIcon,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
        ),
      ],
    );
  }
}
