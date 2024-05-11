class Customer {

  late int _customerId;

  late String _customerName;

  int get customerId => _customerId;

  set customerId(int value) {
    _customerId = value;
  }

  String get customerName => _customerName;

  set customerName(String value) {
    _customerName = value;
  }

  Customer();

  Customer.createAll(this._customerId, this._customerName);

  Customer.fromCustomer(Customer customer) {
      this._customerId = customer._customerId;
      this._customerName = customer._customerName;
    }

  factory Customer.fromJson(dynamic json) {
    return Customer.createAll(json['customerId'] as int, json['customerName'] as String);
  }
}
