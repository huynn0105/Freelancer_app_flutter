import 'package:flutter/material.dart';
import 'package:freelance_app/presentation/home/browse/job_detail/job_offers/job_offers_screen.dart';
import 'package:freelance_app/presentation/widgets/nav_item.dart';
import 'package:get/get.dart';

class JobDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Job Detail',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.blue,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 20,left: 20,right: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cần tuyển lập trình viên mobile cho dự án freelancer',
                        style: TextStyle(
                            fontSize: 27, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                            text: "Dịch vụ cần thuê: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Thiết kế ứng dụng moble",
                                  style: TextStyle(
                                      color: Color(0xff3277D8), fontSize: 20))
                            ]),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Mô tả',
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w500),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Bên mình cần 1 bạn làm cứng về WebRTC, công việc nhanh gọn. Bên mình cần 1 bạn làm cứng về WebRTC, công việc nhanh gọn. Bên mình cần 1 bạn làm cứng về WebRTC, công việc nhanh gọn. Bên mình cần 1 bạn làm cứng về WebRTC, công việc nhanh gọn.',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Đính kèm',
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w500),
                      ),
                      TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.attachment_outlined),
                          hintText: 'JD'
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10,bottom: 10),
                              child: Text(
                                'Kỹ năng:',
                                style: TextStyle(
                                    fontSize: 19,
                                    color: Color(0xff3277D8),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),

                            Wrap(
                              runSpacing: 5,
                              spacing: 5,
                              children: List.generate(
                                4,
                                (index) => NavItem(
                                  title: 'Flutter',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(0.65),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Thông tin dự án',
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w500),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ID dự án',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'Ngày đăng',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'Chỉ còn',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'Địa điểm',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'Ngân sách',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'Hình thức làm việc',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'Loại hình công việc',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'Hình thức trả lương',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '123',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      '2020/3/21',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      '3',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'Hồ chí minh',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '10M - ',
                                          style: TextStyle(fontSize: 19),
                                        ),
                                        Text(
                                          '20M',
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'Làm Online',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      'Part time',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'Theo dự án',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Thông tin khách hàng',
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w500),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: AssetImage(
                                          'assets/images/avatar.jpg'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Nguyễn Nhật Huy',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Đến từ',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Đến từ',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Đã đăng',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'TP Hồ Chí Minh',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      '30/10/2020',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      '1 việc',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(JobOffersScreen());
                },
                style: ElevatedButton.styleFrom(

                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  'Ứng tuyển',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ));
  }
}
