import '/app/network/http_client.dart';

class Http {

  static Future<Map<String, dynamic>> get(String uri, {Map<String, dynamic>? params}) async {
    return (await HttpClient().get(uri, params: params));
  }

  static Future<Map<String, dynamic>> post(String uri, {data}) async {
    return (await HttpClient().post(uri, data: data));
  }

  static Future<Map<String, dynamic>> patch(String uri, {data}) async {
    return (await HttpClient().patch(uri, data: data));
  }

}