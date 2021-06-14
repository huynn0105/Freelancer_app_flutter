import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/browse/tab_view/jobs/job_detail/job_offers/job_offers_detail.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:freelance_app/presentation/home/profile/edit_profile.dart';
import 'package:freelance_app/presentation/widgets/nav_item.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'job_detail_controller.dart';
import 'job_offers/job_offers_screen.dart';

class JobDetailScreen extends StatelessWidget {
  final int jobId;

  JobDetailScreen({@required this.jobId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<JobDetailController>(
        JobDetailController(apiRepositoryInterface: Get.find(), jobId: jobId));
    final homeController = Get.find<HomeController>();
    final formatter = new NumberFormat("#,###");
    final df = new DateFormat('dd-MM-yyyy');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chi tiết công việc',
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding:
            const EdgeInsets.only(right: 15, left: 15, bottom: kDefaultPadding),
        child: Obx(
          () => controller.progressState.value == sState.initial
              ? Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: kDefaultPadding,
                              ),
                              CircleAvatar(
                                radius: 55,
                                foregroundColor: Colors.transparent,
                                backgroundColor: Colors.grey.shade300,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'http://${controller.job.value.avatarUrl}',
                                  httpHeaders: {
                                    HttpHeaders.authorizationHeader:
                                        'Bearer $TOKEN'
                                  },
                                  placeholder: (context, url) =>
                                      CupertinoActivityIndicator(),
                                  imageBuilder: (context, image) =>
                                      CircleAvatar(
                                    backgroundImage: image,
                                    radius: 50,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    backgroundImage: AssetImage(
                                        'assets/images/avatarnull.png'),
                                    radius: 50,
                                  ),
                                ),
                              ),
                              SizedBox(height: kDefaultPadding / 2),
                              Text(controller.job.value.name,
                                  textAlign: TextAlign.center,
                                  style: TEXT_STYLE_PRIMARY.copyWith(
                                      fontSize: 22)),
                              SizedBox(height: kDefaultPadding / 2),
                              Text(
                                controller.job.value.specialty.name,
                                style: TEXT_STYLE_ON_FOREGROUND.copyWith(
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: kDefaultPadding / 4),
                              Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 10,
                                runSpacing: 5,
                                children: [
                                  NavItem(
                                      title:
                                          controller.job.value.formOfWork.name,
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                      backgroundColor: Colors.green.shade400),
                                  NavItem(
                                    title: controller.job.value.typeOfWork.name,
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                    backgroundColor: Colors.pinkAccent.shade200,
                                  ),
                                  NavItem(
                                      title: controller.job.value.payform.name,
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                      backgroundColor:
                                          Colors.blueAccent.shade400),
                                ],
                              ),
                              Divider(),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.home_repair_service_outlined,
                                color: Colors.black87,
                              ),
                              SizedBox(width: kDefaultPadding / 2),
                              Text('Dịch vụ càn thuê',
                                  style: TEXT_STYLE_PRIMARY),
                            ],
                          ),
                          SizedBox(height: kDefaultPadding / 4),
                          Text(controller.job.value.service.name,
                              style: TEXT_STYLE_FOREIGN.copyWith(
                                  color: Colors.blue)),
                          SizedBox(height: kDefaultPadding),
                          Row(
                            children: [
                              Icon(
                                Icons.description_outlined,
                                color: Colors.black87,
                              ),
                              SizedBox(width: kDefaultPadding / 2),
                              Text('Mô tả chi tiết', style: TEXT_STYLE_PRIMARY),
                            ],
                          ),
                          SizedBox(height: kDefaultPadding / 4),
                          Text(
                            controller.job.value.details,
                            style: TEXT_STYLE_ON_FOREGROUND,
                          ),
                          SizedBox(height: kDefaultPadding),
                          Row(
                            children: [
                              Icon(
                                Icons.psychology_outlined,
                                color: Colors.black87,
                              ),
                              SizedBox(width: kDefaultPadding / 2),
                              Text('Kỹ năng yêu cầu',
                                  style: TEXT_STYLE_PRIMARY),
                            ],
                          ),
                          Wrap(
                            children: List.generate(
                              controller.job.value.skills.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(
                                    right: kDefaultPadding / 3,
                                    top: kDefaultPadding / 3),
                                child: NavItem(
                                  title:
                                      controller.job.value.skills[index].name,
                                  textStyle: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: kDefaultPadding),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.money_dollar_circle,
                                color: Colors.black87,
                              ),
                              SizedBox(width: kDefaultPadding / 2),
                              Text('Ngân sách', style: TEXT_STYLE_PRIMARY),
                            ],
                          ),
                          SizedBox(height: kDefaultPadding / 4),
                          Text(
                              '${formatter.format(controller.job.value.floorprice)} - ${formatter.format(controller.job.value.cellingprice)} VNĐ',
                              style: TEXT_STYLE_FOREIGN),
                          SizedBox(height: kDefaultPadding),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_outlined,
                                color: Colors.black87,
                              ),
                              SizedBox(width: kDefaultPadding / 2),
                              Text('Hạn chót nhận hồ sơ',
                                  style: TEXT_STYLE_PRIMARY),
                            ],
                          ),
                          SizedBox(height: kDefaultPadding / 4),
                          Text('${df.format(controller.job.value.deadline)}',
                              style: TEXT_STYLE_FOREIGN),
                          SizedBox(height: kDefaultPadding),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.black87,
                              ),
                              SizedBox(width: kDefaultPadding / 2),
                              Text('Địa điểm làm việc',
                                  style: TEXT_STYLE_PRIMARY),
                            ],
                          ),
                          SizedBox(height: kDefaultPadding / 4),
                          Text(
                              controller.job.value.province != null
                                  ? controller.job.value.province.name
                                  : 'Toàn quốc',
                              style: TEXT_STYLE_FOREIGN),
                          SizedBox(height: kDefaultPadding * 5)
                        ],
                      ),
                    ),
                    controller.job.value.renter.id != CURRENT_ID
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: RoundedButton(
                              onTap: () {
                                var current = homeController.account.value;
                                if (current.phone == '' ||
                                    current.province == null ||
                                    current.specialty == null ||
                                    current.title == '' ||
                                    current.level == null ||
                                    current.freelancerSkills.length < 2 ||
                                    current.freelancerServices.isEmpty ||
                                    current.description == '') {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            insetPadding: EdgeInsets.all(5),
                                            title: Text(
                                              'Bạn chưa có quyền gửi chào giá!',
                                              style: TextStyle(fontSize: 23),
                                            ),
                                            contentPadding: EdgeInsets.all(10),
                                            content: Container(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                      'Để gửi chào giá, bạn phải hoàn thiện hồ sơ cá nhân. Hiện tại hồ sơ của bạn đang thiếu các thông tin sau:'),
                                                  Column(
                                                    children: [
                                                      if (current.province == null)
                                                        ListTile(
                                                            title: Text(
                                                          'Thành phố',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.red),
                                                        )),
                                                      if (current.specialty == null)
                                                        ListTile(title: Text(
                                                          'Lĩnh vực chuyên môn',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.red),
                                                        )),
                                                      if (current
                                                          .description.isEmpty)
                                                        ListTile(
                                                            title: Text(
                                                          'Giới thiệu bản thân',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.red),
                                                        )),
                                                      if (current.phone.isEmpty)
                                                        ListTile(
                                                            title: Text(
                                                          'Số điện thoại',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.red),
                                                        )),
                                                      if (current.title.isEmpty)
                                                        ListTile(
                                                            title: Text(
                                                          'Chức danh',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.red),
                                                        )),
                                                      if (current.level == null)
                                                        ListTile(
                                                            title: Text(
                                                          'Trình độ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.red),
                                                        )),
                                                      if (current
                                                              .freelancerSkills
                                                              .length <
                                                          2)
                                                        ListTile(
                                                            title: Text(
                                                          'Tối thiếu 2 kỹ năng',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.red),
                                                        )),
                                                      if (current
                                                          .freelancerServices
                                                          .isEmpty)
                                                        ListTile(
                                                            title: Text(
                                                          'Hồ sơ dịch vụ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.red),
                                                        )),
                                                    ],
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Get.to(() =>
                                                            EditProfileScreen(
                                                                account:
                                                                    current));
                                                      },
                                                      child:
                                                          Text('Bổ sung ngay'))
                                                ],
                                              ),
                                            ),
                                          ));
                                } else
                                  Get.to(() => JobOffersScreen());
                              },
                              child: Text(
                                'Gửi chào giá',
                                style: TEXT_STYLE_PRIMARY.copyWith(
                                    color: Colors.white),
                              ),
                            ),
                          )
                        : Align(
                      alignment: Alignment.bottomCenter,
                          child: Row(
                      children: [
                          Expanded(
                            flex: 1,
                              child: RoundedButton(
                                backgroundColor: Color(0xFF1EC725),
                              onTap: () {
                                Get.to(() => JobOffersDetail());
                              },
                              child:
                              Text('Có 15 chào giá',style: TEXT_STYLE_PRIMARY.copyWith(
                              color: Colors.white)))),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                              child: RoundedButton(
                                backgroundColor: Colors.red,
                            onTap: () {

                              },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Đóng',style: TEXT_STYLE_PRIMARY.copyWith(
                                    color: Colors.white)),
                                SizedBox(width: 5),
                                Icon(Icons.close),
                              ],
                            ),
                              )),
                      ],
                    ),
                        )
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
