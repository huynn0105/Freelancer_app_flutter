import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/home/post_job/widgets/input_text.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';

class AddCredit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm thông tin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  InputText(
                    hint: 'NGUYEN VAN A',
                    label: 'Tên',
                  ),
                  SizedBox(height: kDefaultPadding),
                  InputText(
                    hint: 'Nhập số tài khoản ngân hàng của bạn',
                    label: 'Tài khoản ngân hàng/Số thẻ',
                  ),
                  SizedBox(height: kDefaultPadding),
                  InputText(
                    hint: 'Nhập tên ngân hàng của bạn',
                    label: 'Tên ngân hàng',
                  ),
                  SizedBox(height: kDefaultPadding),
                  InputText(
                    hint: 'Nhập thông tin chi nhánh ngân hàng',
                    label: 'Chi nhánh mở tài khoản(Không bắt buộc)',
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
