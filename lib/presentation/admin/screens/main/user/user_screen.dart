import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/MyFiles.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/presentation/admin/admin_controller.dart';
import 'package:freelance_app/presentation/admin/screens/main/components/my_feilds.dart';
import 'package:freelance_app/presentation/admin/screens/main/manage_job/manage_job_screen.dart';
import 'package:freelance_app/responsive.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
                rows: List.generate(controller.freelancers.length, (index) => recentDataRow(controller.freelancers[index],context)),
              ),
            ),
          ],
        ) : Center(child: CircularProgressIndicator()),
      ),
    );
  }
  DataRow recentDataRow(Account account,context) {
    var size = MediaQuery.of(context).size;
    return DataRow(
      cells: [
        DataCell(Text('${account.id}')),
        DataCell(Text(account.name)),
        DataCell(ElevatedButton(onPressed: () async{
          var result = await controller.loadFreelancerFromId(account.id);
          showDialog(context: context, builder: (_)=>AlertDialog(
            contentPadding: EdgeInsets.all(10),
            content: SizedBox(width: Responsive.isDesktop(context) ? size.width*0.4 : double.maxFinite, child: FreelancerDetail(freelancer: result)),
          ));
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
    final df = new DateFormat('dd-MM-yyyy');
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin người dùng'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(icon: Icon(Icons.clear), onPressed: ()=>Get.back())
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(kDefaultPadding/2),
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
              ItemRow(title: 'Ngày tạo',content: '${df.format(freelancer.createdAtDate)}'),
              Divider(),
              ItemRow(title: 'Kinh nghiệm',content: freelancer.level !=null ? freelancer.level.name : ''),
              Divider(),
              ItemRow(title: 'Linh vực',content: freelancer.specialty !=null ? freelancer.specialty.name : ''),
              Divider(),
              ItemRow(title: 'Thành phố',content: freelancer.province !=null ? freelancer.province.name : ''),
              Divider(),
              Padding(padding: EdgeInsets.symmetric(vertical: 7),child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      'Dịch vụ cung cấp',
                      style: TextStyle(color: Colors.black54),
                    ),
                    width: 200,
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding/2),
                  ),
                  Expanded(child: freelancer.freelancerServices.isNotEmpty ? Wrap(
                    children: List.generate(freelancer.freelancerServices.length, (index){
                      if(index<freelancer.freelancerServices.length-1)
                        return Text('${freelancer.freelancerServices[index].name}, ');
                      return Text(freelancer.freelancerServices[index].name);
                    }),
                  ):Text('Chưa cập nhập'),)
                ],
              ),),
              Divider(),
              Padding(padding: EdgeInsets.symmetric(vertical: 7),child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      'Dịch vụ cung cấp',
                      style: TextStyle(color: Colors.black54),
                    ),
                    width: 200,
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding/2),
                  ),
                  Expanded(child: freelancer.freelancerSkills.isNotEmpty ? Wrap(
                    children: List.generate(freelancer.freelancerSkills.length, (index){
                      if(index<freelancer.freelancerSkills.length-1)
                        return Text('${freelancer.freelancerSkills[index].name}, ');
                      return Text(freelancer.freelancerSkills[index].name);
                    }),
                  ):Text('Chưa cập nhập'),)
                ],
              ),),
            ],
          ),
        ),
      ),
    );
  }
}


