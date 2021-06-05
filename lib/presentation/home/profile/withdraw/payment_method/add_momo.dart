import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/home/post_job/widgets/input_text.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';

class AddMoMo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm MoMo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  InputText(
                    hint: 'Vui lòng điền họ và tên của bạn',
                    label: 'Họ và tên',
                  ),
                  SizedBox(height: kDefaultPadding),
                  InputText(
                    hint: 'Vui lòng điền số điện thoại của bạn',
                    label: 'Số điện thoại',
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: RoundedButton(
                  onTap: () {},
                  child: Text(
                    'Xác nhận',
                    style: TEXT_STYLE_PRIMARY.copyWith(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
