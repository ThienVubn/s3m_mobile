import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:s3m_mobile/models/user.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:s3m_mobile/models/chart.dart';
import 'package:s3m_mobile/models/view.dart';
import 'package:s3m_mobile/services/homeService.dart' as homeService;
import 'dart:convert';
import 'package:s3m_mobile/models/customer.dart';

class HomeScreen extends StatefulWidget {
  Customer? customer;
  HomeScreen({super.key, required this.customer});

  @override
  State<HomeScreen> createState() => _BdHomeScreenState();
}

class _BdHomeScreenState extends State<HomeScreen> {
  late User user;
  late List<ChartData> chart;
  late TooltipBehavior _tooltip;
  late ViewChart view = ViewChart(0, 0, 0, 0, 0, 0, []);

  @override
  void initState() {
    // TODO: implement initState
    displayUsername();
    getDataView();
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  void displayUsername() async {
    user = User.create('','');
    var res = await SharedPreferences.getInstance();
    if (res.getString('username') != null) {
      setState(() {
        user.username = res.getString('username')!.isNotEmpty
            ? res.getString('username').toString()
            : "";
      });
    }
  }

  Future getDataView() async {
    chart = [];
    var res = await homeService.HomeService().getView(1, 13, 1);
    var respone = res['data'];
    var data = respone;
    // view = ViewChart(0, 0, 0, 0, 0, 0, []);

    ViewChart viewChart = ViewChart.fromJson(data);
    setState(() {
      view.epDay = viewChart.epDay;
      view.epMonth = viewChart.epMonth;
      view.costMonth = viewChart.costMonth;
      view.numDeviceWarning = viewChart.numDeviceWarning;
      view.numDeviceOffline = viewChart.numDeviceOffline;
      view.coefficient = viewChart.coefficient;
    });
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
    return Center(
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Text('${widget.customer?.customerName}'),
                ElevatedButton(
                  onPressed: () async {},
                  child: const Text('Tải điện'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {},
                  child: const Text('Điện mặt trời'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {},
                  child: const Text('Lưới điện'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {},
                  child: const Text('Điện gió'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {},
                  child: const Text('Pin lưu trữ'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text("Điện năng hôm nay: " + view.epDay.toString() + " kWh"),
          Text("Điện năng tháng này: " + view.epMonth.toString() + " kWh"),
          Text("Tiền điện tháng này: " + view.costMonth.toString() + " VNĐ"),
          Text("Điểm đo cảnh báo: " + view.numDeviceWarning.toString()),
          Text("Điểm đo mất tín hiệu: " + view.numDeviceOffline.toString()),
          Text("Tổng phát thải CO₂ : " + view.coefficient.toString() + " Kg"),
          Container(
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
                  ]))
        ],
      ),
    );
  }
}
