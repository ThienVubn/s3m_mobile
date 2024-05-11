import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:s3m_mobile/models/chart.dart';
import 'package:s3m_mobile/models/view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:s3m_mobile/services/homeService.dart' as homeService;
import 'dart:convert';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  late List<ChartData> chart = [];
  late TooltipBehavior _tooltip;
  late List<ViewChart> view = [];

  @override
  void initState() {
    getDataView();
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
      print(chart.length);
  }

  Future getDataView() async {
    var res = await homeService.HomeService().getView(1, 13, 1);
    var respone = res['data'];
    var data = (respone);

      ViewChart viewChart = ViewChart.fromJson(data);

    // var resss = respone['listDataPower'];

    // var vieww = jsonDecode(view.toString());

    for (var i in viewChart.listEp) {
       setState(() {
        ChartData chartt = ChartData.fromJson(i);
        chart.add(chartt);
      });
      // }
  }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(minimum: 0, interval: 10),
            tooltipBehavior: _tooltip,
            series: <CartesianSeries<ChartData, String>>[
              ColumnSeries<ChartData, String>(
                  dataSource: chart,
                  xValueMapper: (ChartData data, _) => data.viewTime,
                  yValueMapper: (ChartData data, _) => data.power,
                  name: 'Điện năng',
                  color: Color.fromRGBO(8, 142, 255, 1))
            ]));
  }
}
