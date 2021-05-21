import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/home/post_job/widgets/input_text.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';

class JobOffersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('THÔNG TIN CHÀO GIÁ'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Cost(),

            SizedBox(height: 18,),

            Convince(),

            SizedBox(height: 18,),

            Contact(),

            SizedBox(height: 15,),

            RoundedButton(onTap: (){}, child: Text('Send offer',style: TEXT_STYLE_PRIMARY.copyWith(color: Colors.white),)),

            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}

class Cost extends StatelessWidget {
  const Cost({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EditBox(
          title: 'ĐỀ XUẤT CHI PHÍ',
          hint: '1.000.000',
        ),
        EditBox(
          title: 'DỰ KIẾN HOÀN THÀNH TRONG',
          hint: '6 tuần',
        ),
        EditBox(
          title: 'ĐỀ XUẤT CHI PHÍ',
          hint: '1.000.000',
        ),
      ],
    );
  }
}

class Convince extends StatelessWidget {
  const Convince({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'ĐỀ XUẤT THUYẾT PHỤC KHÁCH HÀNG',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10,),
          Text(
            '1.Bạn có những kinh nghiệm và kỹ năng nào phù hợp với dự án này?',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 5,),
          InputText(
            hint: '''- Tôi đã có x năm kinh nghiệm trong lĩnh vực..\n- Tôi sử dụng thành thạo các công cụ như...\n- Tôi đã từng thực hiện các dự án tương tự...''',
            maxLines: 5,
          ),
          SizedBox(height: 8,),
          Text(
            '2.Bạn dự định thực hiện dự án này như thế nào?',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500
            ),
          ),
          InputText(
            hint: '''- Đầu tiên tôi sẽ...\n- Sau đó tôi sẽ...\n- Tin tưởng sẽ hoàn thành đúng theo kế hoạch''',
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}

class Contact extends StatelessWidget {
  const Contact({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'THÔNG TIN LIÊN HỆ CỦA BẠN',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8,),
        InputText(
          hint: 'Phone',
          icon: Icon(Icons.phone),
        ),
        SizedBox(height: 8,),
        InputText(
          hint: 'Skype',
          icon: Icon(FontAwesomeIcons.skype),
        ),
      ],
    );
  }
}

class EditBox extends StatelessWidget {
  const EditBox({
    this.controller,
    this.title,
    this.hint,
    Key key,
  }) : super(key: key);
  final String title;
  final String hint;
  final TextEditingController controller;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8,),
          InputText(
            hint: hint,
            controller: controller,
          ),
        ],
      ),
    );
  }
}
