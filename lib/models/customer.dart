class Customer {

  late double _customerId;

  late String _customerName;

  double get customerId => _customerId;

  set customerId(double value) {
    _customerId = value;
  }

  String get customerName => _customerName;

  set customerName(String value) {
    _customerName = value;
  }

  Customer();

  Customer.createAll(this._customerId, this._customerName);

  factory Customer.fromJson(dynamic json) {
    return Customer.createAll(json['customerId'] as double, json['customerName'] as String);
  }
}
