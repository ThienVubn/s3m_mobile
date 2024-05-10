class Project {

  late double _projectId;

  late String _projectName;

  double get projectId => _projectId;

  set projectId(double value) {
    _projectId = value;
  }

  String get projectName => _projectName;

  set projectName(String value) {
    _projectName = value;
  }

  Project();

  Project.createAll(this._projectId, this._projectName);

  factory Project.fromJson(dynamic json) {
    return Project.createAll(json['projectId'] as double, json['projectName'] as String);
  }
}
