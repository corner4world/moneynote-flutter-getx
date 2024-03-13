import '../../../network/http.dart';

class AccountRepository {

  static Future<bool> createAdjust(int id, Map<String, dynamic> form) async {
    return (await Http.post('accounts/$id/adjust', data: form))['success'];
  }

  static Future<bool> updateAdjust(int id, Map<String, dynamic> form) async {
    return (await Http.put('accounts/$id/adjust', data: form))['success'];
  }

}