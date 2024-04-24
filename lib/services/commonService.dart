import 'package:http/http.dart' as http;
import 'package:s3m_mobile/services/authService.dart' as auth_service;

class CommonService {
  Future<dynamic> sendRequest(String type, String url, dynamic data) async {
    var token = auth_service.AuthService().getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": token
    };

    switch (type) {
      case 'GET':
        return _getRequest(url, headers);
      case 'POST':
        return _postRequest(url, headers, data);
      default:
        throw Exception('Unsupported request type');
    }
  }

  Future<dynamic> _getRequest(String url, Map<String, String> headers) async {
    final response =
        await http.get(Uri.parse(url.toString()), headers: headers);

    if (response.statusCode == 200) {
      return {'data': response.body, 'status': response.statusCode};
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> _postRequest(
      String url, Map<String, String> headers, dynamic data) async {
    final response =
        await http.post(Uri.parse(url), headers: headers, body: data);

    if (response.statusCode == 200) {
      return {'data': response.body, 'status': response.statusCode};
    } else {
      throw Exception('Failed to load data');
    }
  }
}
