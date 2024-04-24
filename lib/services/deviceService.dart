import "package:s3m_mobile/services/commonService.dart";
import 'package:s3m_mobile/constants/device_api.dart';

class DeviceService {
  late CommonService _commonService;

   DeviceService() {
    _commonService = CommonService();
  }

  Future<dynamic> listDevice(int customerId,int deviceId,int optionTime) async {
    var url = "${DEVICE_API['LIST_DATA_INSTANCE']}$customerId/$deviceId/$optionTime";
    var type = "GET";
    return _commonService.sendRequest(type, url, {});
  }
}
