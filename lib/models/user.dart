class User {
  late int _id;

  late String _username ;

  late String _password ;

  String _email = '';

  String _phone = '' ;

  int get id => _id;

  String get username => _username;

  String get password => _password;

  set id(int value) {
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

  User.fromUser(User user) {
    this._id = user._id == null ? 0 : user._id;
    this._username = user._username == null ? '' : user._username;
    ;
    this._password = user._password == null ? '' : user._password;
    ;
  }
}
