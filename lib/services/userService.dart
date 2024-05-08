import "package:s3m_mobile/services/commonService.dart";
import 'package:s3m_mobile/constants/user_api.dart';

class UserService {
  late CommonService _commonService;

   UserService() {
    _commonService = CommonService();
  }

  Future<dynamic> getUserByUsername(String username) async {
    var url = "${USER_API['GET_USER_BY_USERNAME']}$username";
    var type = "GET";
    return _commonService.sendRequest(type, url, {});
  }
}
