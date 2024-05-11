// ignore: unused_element
class ChartData {
  ChartData(this.power, this.viewTime);

  final double power;
  final String viewTime;

  ChartData.createAll(this.power, this.viewTime);

  factory ChartData.fromJson(dynamic json) {
    return ChartData.createAll(json['power'] as double, json['viewTime'] as String);
  }
}
