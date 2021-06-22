import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/admin/admin_controller.dart';
import 'package:freelance_app/presentation/admin/screens/main/components/my_feilds.dart';
import 'package:freelance_app/responsive.dart';
import 'package:get/get.dart';

class DashboardScreen extends GetWidget<AdminController> {
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Column(
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
                        Expanded(child: ItemInfoCard(title: 'Tổng công việc',num: controller.jobs.length,color: Colors.blue,)),
                        SizedBox(width: kDefaultPadding),
                        Expanded(child: ItemInfoCard(title: 'Hiện có',num: controller.jobs.length,color: Colors.amber,))
                      ],
                    ),
                    SizedBox(height: kDefaultPadding),
                    Row(
                      children: [
                        Expanded(child: ItemInfoCard(title: 'Hoàn thành',num: controller.jobs.length,color: Colors.green,)),
                        SizedBox(width: kDefaultPadding),
                        Expanded(child: ItemInfoCard(title: 'Đã huỷ',num: controller.jobs.length,color: Colors.red,))
                      ],
                    )
                  ],
                ),
                    desktop: Row(
                      children: [
                        Expanded(child: ItemInfoCard(title: 'Tổng công việc',num: controller.jobs.length,color: Colors.blue,)),
                        SizedBox(width: kDefaultPadding),
                        Expanded(child: ItemInfoCard(title: 'Hiện có',num: controller.jobs.length,color: Colors.amber,)),
                        SizedBox(width: kDefaultPadding),
                        Expanded(child: ItemInfoCard(title: 'Hoàn thành',num: controller.jobs.length,color: Colors.green,)),
                        SizedBox(width: kDefaultPadding),
                        Expanded(child: ItemInfoCard(title: 'Đã huỷ',num: controller.jobs.length,color: Colors.red,))
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
                  padding: Responsive.isDesktop(context) ? const EdgeInsets.only(right: 300) : EdgeInsets.all(0),
                  child: Row(
                    children: [
                      Expanded(child: ItemInfoCard(color: Colors.blue, title: 'Tổng người dùng', num: controller.freelancers.length)),
                      SizedBox(width: kDefaultPadding),
                      Expanded(child: ItemInfoCard(color: Colors.green, title: 'Đã xác thức', num: controller.freelancers.length)),
                    ],
                  ),
                )
              ],
            ),
          ),
          Text('Công việc theo tháng',style: TEXT_STYLE_PRIMARY,),
          _graphBarSection(),
          SizedBox(height: kDefaultPadding*4,),
          Text('Người dùng mới theo tháng',style: TEXT_STYLE_PRIMARY),
          _graphSection()
        ],
      ),
    );
  }

  /// Create series list with multiple series
}


_graphSection() {
  final customTickFormatter =
      // ignore: missing_return
      charts.BasicNumericTickFormatterSpec((num value) => 'Tháng ${value + 1}');

  return Container(
    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding*2),
    height: 300,
    child: charts.LineChart(
      _createSampleData(),
      defaultRenderer: new charts.LineRendererConfig(includePoints: true),
      animate: false,
      // Sets up a currency formatter for the measure axis.

      domainAxis: charts.NumericAxisSpec(
        tickProviderSpec:
            charts.BasicNumericTickProviderSpec(desiredTickCount: 6),
        tickFormatterSpec: customTickFormatter,
      ),
    ),
  );
}

_createSampleData() {
  final myFakeDesktopData = [
    new LinearSales(0, 140),
    new LinearSales(1, 200),
    new LinearSales(2, 300),
    new LinearSales(3, 250),
    new LinearSales(4, 222),
    new LinearSales(5, 240),
  ];

  return [
    charts.Series<LinearSales, int>(
      id: 'Sales',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (LinearSales sales, _) => sales.month,
      measureFn: (LinearSales sales, _) => sales.sales,
      data: myFakeDesktopData,
    )
  ];
}

_graphBarSection() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding*2),
    height: 300,
    child: charts.BarChart(
      _createBarSampleData(),
      defaultRenderer: new charts.BarRendererConfig(
          groupingType: charts.BarGroupingType.grouped, strokeWidthPx: 2.0),
      animate: false,
      // Sets up a currency formatter for the measure axis.

    ),
  );
}

_createBarSampleData() {
  final desktopSalesData = [
    new OrdinalSales('Tháng 1', 15),
    new OrdinalSales('Tháng 2', 25),
    new OrdinalSales('Tháng 3', 100),
    new OrdinalSales('Tháng 4', 75),
    new OrdinalSales('Tháng 5', 50),
    new OrdinalSales('Tháng 6', 65),
  ];

  final tableSalesData = [
    new OrdinalSales('Tháng 1', 25),
    new OrdinalSales('Tháng 2', 50),
    new OrdinalSales('Tháng 3', 10),
    new OrdinalSales('Tháng 4', 20),
    new OrdinalSales('Tháng 5', 50),
    new OrdinalSales('Tháng 6', 20),
  ];

  final mobileSalesData = [
    new OrdinalSales('Tháng 1', 10),
    new OrdinalSales('Tháng 2', 50),
    new OrdinalSales('Tháng 3', 50),
    new OrdinalSales('Tháng 4', 45),
    new OrdinalSales('Tháng 5', 25),
    new OrdinalSales('Tháng 6', 65),
  ];

  return [
    new charts.Series<OrdinalSales, String>(
      id: 'Desktop',
      domainFn: (OrdinalSales sales, _) => sales.year,
      measureFn: (OrdinalSales sales, _) => sales.sales,
      data: desktopSalesData,
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      fillColorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault.lighter,
    ),

    new charts.Series<OrdinalSales, String>(
      id: 'Tablet',
      measureFn: (OrdinalSales sales, _) => sales.sales,
      data: tableSalesData,
      colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      domainFn: (OrdinalSales sales, _) => sales.year,
    ),

    new charts.Series<OrdinalSales, String>(
      id: 'Mobile',
      domainFn: (OrdinalSales sales, _) => sales.year,
      measureFn: (OrdinalSales sales, _) => sales.sales,
      data: mobileSalesData,
      colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      fillColorFn: (_, __) => charts.MaterialPalette.transparent,
    ),
  ];
}

class LinearSales {
  final int month;
  final int sales;

  LinearSales(this.month, this.sales);
}


class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
