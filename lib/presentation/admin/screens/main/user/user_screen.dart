import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/MyFiles.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/presentation/admin/admin_controller.dart';
import 'package:freelance_app/presentation/admin/screens/main/components/my_feilds.dart';
import 'package:freelance_app/presentation/admin/screens/main/manage_job/manage_job_screen.dart';
import 'package:freelance_app/responsive.dart';
import 'package:get/get.dart';
class UserScreen extends GetWidget<AdminController> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Responsive.isDesktop(context) ? EdgeInsets.symmetric(vertical: kDefaultPadding,horizontal: kDefaultPadding*3) : EdgeInsets.all(kDefaultPadding/2),
      child: Obx(
        ()=> controller.progressState.value == sState.initial ? Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Người dùng',style: TEXT_STYLE_PRIMARY,),
                  SizedBox(height: 5,),
                  InfoCardGridView(list:demoUserM,crossAxisCount: Responsive.isMobile(context) ? 2 : 4,),
                ],
              ),
            ),
            SizedBox(height: kDefaultPadding),
            Container(
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.all(
                    Radius.circular(kDefaultPadding / 2)),
              ),
              width: double.infinity,
              child: DataTable(
                columnSpacing: kDefaultPadding,
                horizontalMargin: kDefaultPadding,
                columns: [
                  DataColumn(label: Text('ID Người dùng',overflow: TextOverflow.ellipsis)),
                  DataColumn(label: Text('Tên Người Dùng',overflow: TextOverflow.ellipsis,)),
                  DataColumn(label: Text('Tuỳ chọn',overflow: TextOverflow.ellipsis)),
                ],
                rows: List.generate(controller.freelancers.length, (index) => recentDataRow(controller.freelancers[index])),
              ),
            ),
          ],
        ) : Center(child: CircularProgressIndicator()),
      ),
    );
  }
  DataRow recentDataRow(Account account) {
    return DataRow(
      cells: [
        DataCell(Text('${account.id}')),
        DataCell(Text(account.name)),
        DataCell(ElevatedButton(onPressed: () async{
          var result = await controller.loadFreelancerFromId(account.id);
          Get.defaultDialog(
              title: '${account.name}',
              titleStyle: TEXT_STYLE_PRIMARY,
              radius: 10,
              content: FreelancerDetail(freelancer: result),
          );
        }, child: Text('Xem'),style: ElevatedButton.styleFrom(primary: Colors.green),)),
      ],
    );
  }
}

class FreelancerDetail extends StatelessWidget {

  const FreelancerDetail({
    Key key,
    @required this.freelancer,
  }) : super(key: key);

  final Account freelancer;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(kDefaultPadding),
        width: Responsive.isDesktop(context) ? size.width*0.4 : size.width*0.75,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(),
              ItemRow(title: 'Tên freelancer',content: freelancer.name),
              Divider(),
              ItemRow(title: 'Số điện thoại',content: freelancer.phone,),
              Divider(),
              ItemRow(title: 'Email',content: freelancer.email),
              Divider(),
              ItemRow(title: 'Chức vụ',content: freelancer.title !=null ? freelancer.title : ''),
              Divider(),
              ItemRow(title: 'Giới thiệu',content: freelancer.description !=null ? freelancer.description : ''),
              Divider(),
              ItemRow(title: 'Website',content: freelancer.website !=null ? freelancer.website : ''),
              Divider(),
              ItemRow(title: 'Kiếm được',content: '${freelancer.earning} VNĐ' ),
              Divider(),
              ItemRow(title: 'Trạng thái',content: freelancer.onReady ? 'Sẵn sàng' : 'Bận'),
              Divider(),
              ItemRow(title: 'Ngày tạo',content: freelancer.createdAtDate),
              Divider(),
              ItemRow(title: 'Kinh nghiệm',content: freelancer.level !=null ? freelancer.level.name : ''),
              Divider(),
              ItemRow(title: 'Linh vực',content: freelancer.specialty !=null ? freelancer.specialty.name : ''),
              Divider(),
              ItemRow(title: 'Thành phố',content: freelancer.province !=null ? freelancer.province.name : ''),
              Divider(),
              ItemRow(title: 'Dịch vụ cung cấp',content: freelancer.freelancerServices.isNotEmpty? 'Kỹ năng nhiều' : ''),
            ],
          ),
        ),
      ),
    );
  }
}


