import '../../network/http.dart';

class BaseRepository {

  static Future<List<Map<String, dynamic>>> query1(String prefix, Map<String, dynamic> form) async {
    List<dynamic> data = (await Http.get(prefix, params: {
      ...form,
      ...{
        'enable': true,
      }
    }))['data'];
    return List<Map<String, dynamic>>.from(data);
  }

  static Future<bool> toggle(String prefix, int id) async {
    return (await Http.patch('$prefix/$id/toggle'))['success'];
  }

}