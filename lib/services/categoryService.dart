import "package:s3m_mobile/services/commonService.dart";
import 'package:s3m_mobile/constants/category_api.dart';

class CategoryService {
    late CommonService _commonService;

   CategoryService() {
    _commonService = CommonService();
  }

  //example
  //  Future<dynamic> listCustomer() async {
  //   var url = "${CATEGORY_API['LIST_CUSTOMER']}";
  //   var type = "GET";
  //   return _commonService.sendRequest(type, url, {});
  // }
}