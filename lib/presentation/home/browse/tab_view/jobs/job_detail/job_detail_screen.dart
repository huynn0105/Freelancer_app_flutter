import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/browse/tab_view/jobs/job_detail/job_offers/job_offers_detail.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:freelance_app/presentation/home/my_job/tab_view/as_freelancer_screen.dart';
import 'package:freelance_app/presentation/home/profile/edit_profile.dart';
import 'package:freelance_app/presentation/widgets/nav_item.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../../../../../../responsive.dart';
import 'job_detail_controller.dart';
import 'job_offers/job_offers_screen.dart';

class JobDetailScreen extends StatelessWidget {
  final int jobId;

  JobDetailScreen({@required this.jobId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<JobDetailController>(
        JobDetailController(apiRepositoryInterface: Get.find(), jobId: jobId));

    final controllerHome = Get.find<HomeController>();

    final homeController = Get.find<HomeController>();
    final formatter = new NumberFormat("#,###");
    final df = new DateFormat('dd-MM-yyyy');
    return Container(
      color:  Colors.grey[100],
      padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? 0.0 : 250),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text(
                'Chi tiết công việc',
              ),
              centerTitle: true,
              elevation: 0,
            ),
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.only(
                  right: 15, left: 15, bottom: kDefaultPadding),
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
                                    Wrap(
                                      children: [
                                        Text(controller.job.value.name,
                                            textAlign: TextAlign.center,
                                            style: TEXT_STYLE_PRIMARY.copyWith(
                                                fontSize: 22)),
                                        if (controller.job.value.status ==
                                            'Waiting')
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Icon(
                                              CupertinoIcons.time,
                                              color: Colors.amber,
                                            ),
                                          ),
                                        if (controller.job.value.status ==
                                            'Finished')
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Icon(
                                              CupertinoIcons.check_mark_circled,
                                              color: Colors.green,
                                            ),
                                          ),
                                        if (controller.job.value.status ==
                                            'In progress')
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Icon(
                                              CupertinoIcons.slowmo,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        if (controller.job.value.status ==
                                            'Request rework')
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Icon(
                                              CupertinoIcons
                                                  .arrow_2_circlepath_circle,
                                              color: Colors.limeAccent,
                                            ),
                                          ),
                                        if (controller.job.value.status ==
                                            'Request cancellation')
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Icon(
                                              CupertinoIcons.xmark_circle,
                                              color: Colors.red,
                                            ),
                                          ),
                                        if (controller.job.value.status ==
                                            'Cancellation')
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Icon(
                                              CupertinoIcons.xmark_circle,
                                              color: Colors.red,
                                            ),
                                          ),
                                      ],
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    Text(
                                      controller.job.value.specialty.name,
                                      style: TEXT_STYLE_ON_FOREGROUND.copyWith(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: kDefaultPadding / 4),
                                    Divider(),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person_pin_circle_outlined,
                                      color: Colors.black87,
                                    ),
                                    SizedBox(width: kDefaultPadding / 2),
                                    Text('Chủ dự án', style: TEXT_STYLE_PRIMARY),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 4),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(controller.job.value.renter.name,
                                      style: TEXT_STYLE_FOREIGN.copyWith(
                                          color: Colors.blueAccent)),
                                ),
                                SizedBox(height: kDefaultPadding),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.home_work_outlined,
                                      color: Colors.black87,
                                    ),
                                    SizedBox(width: kDefaultPadding / 2),
                                    Text('Hình thức làm việc',
                                        style: TEXT_STYLE_PRIMARY),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 4),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                      controller.job.value.formOfWork.name,
                                      style: TEXT_STYLE_FOREIGN.copyWith(
                                          color: Colors.blueAccent)),
                                ),
                                SizedBox(height: kDefaultPadding),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.merge_type_outlined,
                                      color: Colors.black87,
                                    ),
                                    SizedBox(width: kDefaultPadding / 2),
                                    Text('Loại hình làm việc',
                                        style: TEXT_STYLE_PRIMARY),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 4),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                      controller.job.value.typeOfWork.name,
                                      style: TEXT_STYLE_FOREIGN.copyWith(
                                          color: Colors.blueAccent)),
                                ),
                                SizedBox(height: kDefaultPadding),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.miscellaneous_services_outlined,
                                      color: Colors.black87,
                                    ),
                                    SizedBox(width: kDefaultPadding / 2),
                                    Text('Dịch vụ càn thuê',
                                        style: TEXT_STYLE_PRIMARY),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 4),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(controller.job.value.service.name,
                                      style: TEXT_STYLE_FOREIGN.copyWith(
                                          color: Colors.blue)),
                                ),
                                SizedBox(height: kDefaultPadding),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.description_outlined,
                                      color: Colors.black87,
                                    ),
                                    SizedBox(width: kDefaultPadding / 2),
                                    Text('Mô tả chi tiết',
                                        style: TEXT_STYLE_PRIMARY),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 4),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    controller.job.value.details,
                                    style: TEXT_STYLE_ON_FOREGROUND,
                                  ),
                                ),
                                SizedBox(height: kDefaultPadding),
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.square_stack_3d_up,
                                      color: Colors.black87,
                                    ),
                                    SizedBox(width: kDefaultPadding / 2),
                                    Text('Trạng thái', style: TEXT_STYLE_PRIMARY),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 4),
                                if (controller.job.value.status == 'Finished')
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Đã hoàn thành',
                                      style: TEXT_STYLE_ON_FOREGROUND,
                                    ),
                                  ),
                                if (controller.job.value.status ==
                                    'Request rework')
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Yêu cầu làm lại',
                                      style: TEXT_STYLE_ON_FOREGROUND,
                                    ),
                                  ),
                                if (controller.job.value.status ==
                                    'Request cancellation')
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Yêu cầu huỷ dự án',
                                      style: TEXT_STYLE_ON_FOREGROUND,
                                    ),
                                  ),
                                if (controller.job.value.status == 'In progress')
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Đang làm',
                                      style: TEXT_STYLE_ON_FOREGROUND,
                                    ),
                                  ),
                                if (controller.job.value.status == 'Cancellation')
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Dự án đã đóng',
                                      style: TEXT_STYLE_ON_FOREGROUND,
                                    ),
                                  ),
                                if (controller.job.value.status == 'Waiting')
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Đang xử lý',
                                      style: TEXT_STYLE_ON_FOREGROUND,
                                    ),
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
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Wrap(
                                    children: List.generate(
                                      controller.job.value.skills.length,
                                      (index) => Padding(
                                        padding: const EdgeInsets.only(
                                            right: kDefaultPadding / 3,
                                            top: kDefaultPadding / 3),
                                        child: NavItem(
                                          title: controller
                                              .job.value.skills[index].name,
                                          textStyle: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
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
                                    Text('Hình thức trả lương',
                                        style: TEXT_STYLE_PRIMARY),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 4),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(controller.job.value.payform.name,
                                      style: TEXT_STYLE_FOREIGN),
                                ),
                                SizedBox(height: kDefaultPadding),
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.money_dollar_circle,
                                      color: Colors.black87,
                                    ),
                                    SizedBox(width: kDefaultPadding / 2),
                                    Text(
                                        controller.job.value.price == 0
                                            ? 'Ngân sách'
                                            : 'Số tiền',
                                        style: TEXT_STYLE_PRIMARY),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 4),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                      controller.job.value.price == 0
                                          ? '${formatter.format(controller.job.value.floorprice)} - ${formatter.format(controller.job.value.cellingprice)} VNĐ'
                                          : '${formatter.format(controller.job.value.price)} VNĐ',
                                      style: TEXT_STYLE_FOREIGN),
                                ),
                                SizedBox(height: kDefaultPadding),
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.timer,
                                      color: Colors.black87,
                                    ),
                                    SizedBox(width: kDefaultPadding / 2),
                                    Text('Hạn chót nhận hồ sơ',
                                        style: TEXT_STYLE_PRIMARY),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 4),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                      '${df.format(controller.job.value.deadline)}',
                                      style: TEXT_STYLE_FOREIGN),
                                ),
                                SizedBox(height: kDefaultPadding),
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.location,
                                      color: Colors.black87,
                                    ),
                                    SizedBox(width: kDefaultPadding / 2),
                                    Text('Địa điểm làm việc',
                                        style: TEXT_STYLE_PRIMARY),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding / 4),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                      controller.job.value.province != null
                                          ? controller.job.value.province.name
                                          : 'Toàn quốc',
                                      style: TEXT_STYLE_FOREIGN),
                                ),
                                SizedBox(height: kDefaultPadding),
                                if (controller.job.value.rating != null) ...[
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.star,
                                        color: Colors.black87,
                                      ),
                                      SizedBox(width: kDefaultPadding / 2),
                                      Text('Đánh giá', style: TEXT_STYLE_PRIMARY),
                                    ],
                                  ),
                                  SizedBox(height: kDefaultPadding / 4),
                                  SmoothStarRating(
                                    allowHalfRating: false,
                                    isReadOnly: true,
                                    starCount: 5,
                                    rating: controller.job.value.rating.star
                                        .toDouble(),
                                    size: 40,
                                    onRated: (value) {},
                                    color: Colors.yellow,
                                    borderColor: Colors.yellow,
                                  ),
                                  Text(controller.job.value.rating.comment)
                                ],
                                SizedBox(height: kDefaultPadding * 5)
                              ],
                            ),
                          ),
                          if (controller.job.value.renter.id == CURRENT_ID) ...[
                            if (controller.job.value.status == 'Closed')
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: RoundedButton(
                                  onTap: () {},
                                  backgroundColor: Colors.black87,
                                  child: Text(
                                    'Đã đóng',
                                    style: TEXT_STYLE_PRIMARY.copyWith(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            if (controller.job.value.status == 'Finished')
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: RoundedButton(
                                  onTap: () {},
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Dự án đã được hoàn thành bởi',
                                        style: TEXT_STYLE_PRIMARY.copyWith(
                                            color: Colors.white),
                                      ),
                                      Text(
                                          'Freelancer: ${controller.job.value.freelancer.name}',
                                          style: TEXT_STYLE_PRIMARY.copyWith(
                                              color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                            if (controller.job.value.status == 'Waiting')
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: RoundedButton(
                                  onTap: () {
                                    controller.loadOffer();
                                    Get.to(() => JobOffersDetail(isClose: true));
                                  },
                                  backgroundColor: Colors.amber,
                                  child: Text(
                                    '${controller.job.value.bidCount} chào giá',
                                    style: TEXT_STYLE_PRIMARY.copyWith(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            if (controller.job.value.status == 'In progress')
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: RoundedButton(
                                  onTap: () {},
                                  child: Text(
                                    'Đang làm\nFreelancer: ${controller.job.value.freelancer.name}',
                                    style: TEXT_STYLE_PRIMARY.copyWith(
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            if (controller.job.value.status == 'Cancellation')
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: RoundedButton(
                                  backgroundColor: Colors.grey,
                                  onTap: (){},
                                  child: Text(
                                    'Chưa hoàn tất/ Đã huỷ',
                                    style: TEXT_STYLE_PRIMARY.copyWith(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                          ] else if (controller.job.value.renter.id !=
                              CURRENT_ID) ...[
                            controller.job.value.deadline
                                        .difference(DateTime.now())
                                        .inDays <
                                    0
                                ? Align(
                                    alignment: Alignment.bottomCenter,
                                    child: RoundedButton(
                                        backgroundColor: Color(0xFF343333),
                                        onTap: () {},
                                        child: Text('Đã hết hạn nhận chào giá',
                                            style: TEXT_STYLE_PRIMARY)),
                                  )
                                : !controller.job.value.offered
                                    ? Align(
                                        alignment: Alignment.bottomCenter,
                                        child: RoundedButton(
                                          onTap: () {
                                            var current =
                                                homeController.account.value;
                                            if (current.phone == '' ||
                                                current.province == null ||
                                                current.specialty == null ||
                                                current.title == '' ||
                                                current.level == null ||
                                                current.freelancerSkills.length <
                                                    2 ||
                                                current
                                                    .freelancerServices.isEmpty ||
                                                current.description == '') {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) => AlertDialog(
                                                        insetPadding:
                                                            EdgeInsets.all(5),
                                                        title: Text(
                                                          'Bạn chưa có quyền gửi chào giá!',
                                                          style: TextStyle(
                                                              fontSize: 23),
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets.all(10),
                                                        content: Container(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize.min,
                                                            children: [
                                                              Text(
                                                                  'Để gửi chào giá, bạn phải hoàn thiện hồ sơ cá nhân. Hiện tại hồ sơ của bạn đang thiếu các thông tin sau:'),
                                                              Column(
                                                                children: [
                                                                  if (current
                                                                          .province ==
                                                                      null)
                                                                    ListTile(
                                                                        title:
                                                                            Text(
                                                                      'Thành phố',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .w500,
                                                                          color: Colors
                                                                              .red),
                                                                    )),
                                                                  if (current
                                                                          .specialty ==
                                                                      null)
                                                                    ListTile(
                                                                        title:
                                                                            Text(
                                                                      'Lĩnh vực chuyên môn',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .w500,
                                                                          color: Colors
                                                                              .red),
                                                                    )),
                                                                  if (current
                                                                      .description
                                                                      .isEmpty)
                                                                    ListTile(
                                                                        title:
                                                                            Text(
                                                                      'Giới thiệu bản thân',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .w500,
                                                                          color: Colors
                                                                              .red),
                                                                    )),
                                                                  if (current
                                                                      .phone
                                                                      .isEmpty)
                                                                    ListTile(
                                                                        title:
                                                                            Text(
                                                                      'Số điện thoại',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .w500,
                                                                          color: Colors
                                                                              .red),
                                                                    )),
                                                                  if (current
                                                                      .title
                                                                      .isEmpty)
                                                                    ListTile(
                                                                        title:
                                                                            Text(
                                                                      'Chức danh',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .w500,
                                                                          color: Colors
                                                                              .red),
                                                                    )),
                                                                  if (current
                                                                          .level ==
                                                                      null)
                                                                    ListTile(
                                                                        title:
                                                                            Text(
                                                                      'Trình độ',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .w500,
                                                                          color: Colors
                                                                              .red),
                                                                    )),
                                                                  if (current
                                                                          .freelancerSkills
                                                                          .length <
                                                                      2)
                                                                    ListTile(
                                                                        title:
                                                                            Text(
                                                                      'Tối thiếu 2 kỹ năng',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .w500,
                                                                          color: Colors
                                                                              .red),
                                                                    )),
                                                                  if (current
                                                                      .freelancerServices
                                                                      .isEmpty)
                                                                    ListTile(
                                                                        title:
                                                                            Text(
                                                                      'Hồ sơ dịch vụ',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .w500,
                                                                          color: Colors
                                                                              .red),
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
                                                                  child: Text(
                                                                      'Bổ sung ngay'))
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
                                        child: RoundedButton(
                                            backgroundColor: Colors.amber,
                                            onTap: () {
                                              controllerHome
                                                  .loadOfferHistories()
                                                  .then((value) => Get.to(() =>
                                                      MyOffer(
                                                          jobOffer: controllerHome
                                                              .offers
                                                              .firstWhere(
                                                                  (jobOffer) =>
                                                                      jobOffer
                                                                          .jobId ==
                                                                      jobId))));
                                            },
                                            child: Text('Đã gửi chào giá',
                                                style:
                                                    TEXT_STYLE_PRIMARY.copyWith(
                                                        color: Colors.white))),
                                      )
                          ],
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          ),
          Positioned.fill(
            child: Obx(() {
              if (controller.progressClose.value == sState.loading) {
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
}
