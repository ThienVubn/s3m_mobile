import "package:s3m_mobile/services/commonService.dart";
import 'package:s3m_mobile/constants/notification_api.dart';

class NotificationService {
    late CommonService _commonService;

   NotificationService() {
    _commonService = CommonService();
  }

  //example
  //  Future<dynamic> listNotification() async {
  //   var url = "${NOTIFICATION_API['LIST_NOTIFICATION']}";
  //   var type = "GET";
  //   return _commonService.sendRequest(type, url, {});
  // }
}