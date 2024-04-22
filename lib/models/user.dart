
class User {
  late int _id;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  late String _username;

  User(this._username, this._password);

  late String _password;

  String get username => _username;

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  set username(String value) {
    _username = value;
  }
}
