import "package:s3m_mobile/services/commonService.dart";
import 'package:s3m_mobile/constants/home_api.dart';

class HomeService {
    late CommonService _commonService;

   HomeService() {
    _commonService = CommonService();
  }

  //example
  //  Future<dynamic> listEp(int customerId) async {
  //   var url = "${HOME_API['LIST_EP']}$customerId/";
  //   var type = "GET";
  //   return _commonService.sendRequest(type, url, {});
  // }
}