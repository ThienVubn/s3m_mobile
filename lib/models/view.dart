import 'package:s3m_mobile/models/chart.dart';

class ViewChart {
  ViewChart(this.epDay, this.epMonth, this.costMonth, this.numDeviceWarning,
      this.numDeviceOffline, this.coefficient, this.listEp);

  final double epDay;
  final double epMonth;
  final double costMonth;
  final int numDeviceWarning;
  final int numDeviceOffline;
  final double coefficient;
  final List<dynamic> listEp;

  ViewChart.createAll(
      this.epDay,
      this.epMonth,
      this.costMonth,
      this.numDeviceWarning,
      this.numDeviceOffline,
      this.coefficient,
      this.listEp);

  factory ViewChart.fromJson(dynamic json) {
    return ViewChart.createAll(
        json['epDay'] as double,
        json['epMonth'] as double,
        json['costMonth'] as double,
        json['numDeviceWarning'] as int,
        json['numDeviceOffline'] as int,
        json['coefficient'] as double,
        json['listEp'] as List<dynamic>);
  }
}
