class User {
  late double _id;

  late String _username ;

  late String _password ;

  String _email = '';

  String _phone = '' ;

  double get id => _id;

  String get username => _username;

  String get password => _password;

  set id(double value) {
    _id = value;
  }

  set password(String value) {
    _password = value;
  }

  set username(String value) {
    _username = value;
  }

  String get phone => _phone;

  String get email => _email;

  set phone(String value) {
    _phone = value;
  }

  set email(String value) {
    _email = value;
  }

  User();

  User.create(this._username, this._password);

  User.createAll(this._id, this._username, this._password, this._email, this._phone);

  User.fromUser(User user) {
    _id = user._id;
    _username = user._username;
    _password = user._password;
    _email = user.email;
    _phone = user.phone;
  }

  factory User.fromJson(dynamic json) {
    return User.createAll(json['id'] as double, json['username'] as String, json['password'] as String, json['email'] as String, json['phone'] as String);
  }
}
