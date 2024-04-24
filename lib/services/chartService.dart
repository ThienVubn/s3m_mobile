import "package:s3m_mobile/services/commonService.dart";
import 'package:s3m_mobile/constants/chart_api.dart';

class ChartService {
    late CommonService _commonService;

   ChartService() {
    _commonService = CommonService();
  }

  //example
  //  Future<dynamic> listEpByDay(int customerId, string date) async {
  //   var url = "${CHART_API['LIST_EP_BY_DAY']}$customerId/$date";
  //   var type = "GET";
  //   return _commonService.sendRequest(type, url, {});
  // }
}