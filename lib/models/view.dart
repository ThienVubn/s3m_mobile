class ViewChart {
  ViewChart(this.epDay, this.epMonth, this.costMonth, this.numDeviceWarning,
      this.numDeviceOffline, this.coefficient, this.listEp);

  late double epDay;
  late double epMonth;
  late double costMonth;
  late int numDeviceWarning;
  late int numDeviceOffline;
  late double coefficient;
  late List<dynamic> listEp;

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
