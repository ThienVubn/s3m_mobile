import "package:s3m_mobile/services/commonService.dart";
import 'package:s3m_mobile/constants/home_api.dart';

class HomeService {
    late CommonService _commonService;

   HomeService() {
    _commonService = CommonService();
  }

  //example
   Future<dynamic> getView(int customerId, int projectId, int typer) async {
    var url = "${HOME_API['OVERVIEW']}/$customerId/$projectId/$typer";
    var type = "GET";
    return _commonService.sendRequest(type, url, {});
  }
}