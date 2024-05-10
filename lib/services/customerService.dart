import "package:s3m_mobile/services/commonService.dart";
import 'package:s3m_mobile/constants/customer_api.dart';

class CustomerService {
    late CommonService _commonService;

   CustomerService() {
    _commonService = CommonService();
  }

   Future<dynamic> getListCustomer() async {
    var url = "${CUSTOMER_API['LIST_CUSTOMER']}";
    var type = "GET";
    return _commonService.sendRequest(type, url, {});
  }

  Future<dynamic> getListCustomerByUsername() async {
    var url = "${CUSTOMER_API['LIST_CUSTOMER']}";
    var type = "GET";
    return _commonService.sendRequest(type, url, {});
  }
}