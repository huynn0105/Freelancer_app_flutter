import 'dart:io';

import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/total_job_months.dart';
import 'package:freelance_app/domain/models/total_user_months.dart';
import 'package:freelance_app/presentation/admin/admin_controller.dart';
import 'package:freelance_app/presentation/admin/screens/main/components/my_feilds.dart';
import 'package:freelance_app/responsive.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends GetWidget<AdminController> {
  @override
  Widget build(BuildContext context) {

    final customTickFormatter = charts.BasicNumericTickFormatterSpec((num value) => 'Tháng $value');

    return SingleChildScrollView(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Obx(
        ()=> Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tổng số công việc',style: TEXT_STYLE_PRIMARY,),
                  SizedBox(height: 5,),
                  Responsive(mobile: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: ItemInfoCard(title: 'Tổng công việc',num: controller.dashboard.value.totalJob,color: Colors.blue,)),
                          SizedBox(width: kDefaultPadding),
                          Expanded(child: ItemInfoCard(title: 'Đang giao',num: controller.dashboard.value.totalAssigned,color: Colors.amber,))
                        ],
                      ),
                      SizedBox(height: kDefaultPadding),
                      Row(
                        children: [
                          Expanded(child: ItemInfoCard(title: 'Hoàn thành',num: controller.dashboard.value.totalDone,color: Colors.green,)),
                          SizedBox(width: kDefaultPadding),
                          Expanded(child: ItemInfoCard(title: 'Đã huỷ',num: controller.dashboard.value.totalCancelled,color: Colors.red,))
                        ],
                      )
                    ],
                  ),
                      desktop: Row(
                        children: [
                          Expanded(child: ItemInfoCard(title: 'Tổng công việc',num: controller.dashboard.value.totalJob,color: Colors.blue,)),
                          SizedBox(width: kDefaultPadding),
                          Expanded(child: ItemInfoCard(title: 'Hiện có',num: controller.dashboard.value.totalAssigned,color: Colors.amber,)),
                          SizedBox(width: kDefaultPadding),
                          Expanded(child: ItemInfoCard(title: 'Hoàn thành',num: controller.dashboard.value.totalDone,color: Colors.green,)),
                          SizedBox(width: kDefaultPadding),
                          Expanded(child: ItemInfoCard(title: 'Đã huỷ',num: controller.dashboard.value.totalCancelled,color: Colors.red,))
                        ],
                      ),
                  )

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Người dùng',style: TEXT_STYLE_PRIMARY,),
                  SizedBox(height: 5,),
                  Padding(
                    padding: Responsive.isDesktop(context) ? const EdgeInsets.only(right: 600) : EdgeInsets.all(0),
                    child: Row(
                      children: [
                        Expanded(child: ItemInfoCard(color: Colors.blue, title: 'Tổng người dùng', num: controller.dashboard.value.totalUser)),

                      ],
                    ),
                  )
                ],
              ),
            ),
            Text('Công việc theo tháng',style: TEXT_STYLE_PRIMARY,),
            controller.dashboard.value.totalJobMonths!=null?
            Container(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding*2),
              height: 300,
              child: charts.BarChart(
                _createBarSampleData(controller.dashboard.value.totalJobMonths),
                defaultRenderer: new charts.BarRendererConfig(
                    groupingType: charts.BarGroupingType.grouped, strokeWidthPx: 2.0),
                animate: false,
                // Sets up a currency formatter for the measure axis.

              ),
            ) : CircularProgressIndicator(),
            SizedBox(height: kDefaultPadding*4,),
            Text('Người dùng mới theo tháng',style: TEXT_STYLE_PRIMARY),
            controller.dashboard.value.totalUserMonths!=null ?
            Container(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding*2),
              height: 300,
              child: charts.LineChart(
                _createSampleData(controller.dashboard.value.totalUserMonths),
                defaultRenderer: new charts.LineRendererConfig(includePoints: true),
                animate: false,
                // Sets up a currency formatter for the measure axis.

              ),
            ): CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  /// Create series list with multiple series
}




_createSampleData(List<TotalUserMonths> totalUserMonths) {
  final userList = List.generate(totalUserMonths.length, (index) => LinearSales(DateFormat("yyyy-MM").parse(totalUserMonths[index].month), totalUserMonths[index].newUser));
  return [
    charts.Series<LinearSales, int>(
      id: 'User new',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (LinearSales sales, _) => sales.month.month,
      measureFn: (LinearSales sales, _) => sales.sales,
      data: userList,
      labelAccessorFn: (LinearSales sales, _) => 'Tháng ${sales.month.month}'
    )
  ];
}

class LinearSales {
  final DateTime month;
  final int sales;

  LinearSales(this.month, this.sales);
}


_createBarSampleData(List<TotalJobMonths> totalJobMonths) {



  final jobNew = List.generate(totalJobMonths.length, (index) => OrdinalSales(totalJobMonths[index].month, totalJobMonths[index].newJob));
  final jobDone = List.generate(totalJobMonths.length, (index) => OrdinalSales(totalJobMonths[index].month, totalJobMonths[index].done));
  final jonCancel = List.generate(totalJobMonths.length, (index) => OrdinalSales(totalJobMonths[index].month, totalJobMonths[index].cancelled));




  return [
    new charts.Series<OrdinalSales, String>(
      id: 'Job New',
      domainFn: (OrdinalSales sales, _) => sales.year,
      measureFn: (OrdinalSales sales, _) => sales.sales,
      data: jobNew,
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      fillColorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault.lighter,
    ),

    new charts.Series<OrdinalSales, String>(
      id: 'Job Done',
      measureFn: (OrdinalSales sales, _) => sales.sales,
      data: jobDone,
      colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      domainFn: (OrdinalSales sales, _) => sales.year,
    ),

    new charts.Series<OrdinalSales, String>(
      id: 'Job Cancel',
      domainFn: (OrdinalSales sales, _) => sales.year,
      measureFn: (OrdinalSales sales, _) => sales.sales,
      data: jonCancel,
      colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      fillColorFn: (_, __) => charts.MaterialPalette.transparent,
    ),
  ];
}


class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
