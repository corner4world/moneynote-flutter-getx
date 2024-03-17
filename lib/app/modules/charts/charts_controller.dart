import 'package:get/get.dart';
import '/app/core/base/enums.dart';
import '/app/core/base/base_controller.dart';
import '../login/controllers/auth_controller.dart';
import 'chart_repository.dart';

class ChartsController extends BaseController {

  LoadDataStatus status = LoadDataStatus.initial;
  List<Map<String, dynamic>> data = [];
  Map<String, dynamic> query = { };

  @override
  void onInit() {
    super.onInit();
    reset();
    reload();
  }

  void reset() {
    query = { };
    query['book'] = Get.find<AuthController>().initState['book'];
    update();
  }

  void reload() async {
    try {
      status = LoadDataStatus.progress;
      update();
      data = await ChartRepository.expenseCategory(buildQuery());
      status = LoadDataStatus.success;
      update();
    } catch (_) {
      status = LoadDataStatus.failure;
      update();
    }
  }

  void queryChanged(Map<String, dynamic> newQuery) {
    query = {
      ...query,
      ...newQuery
    };
    reload();
  }

  Map<String, dynamic> buildQuery() {
    Map<String, dynamic> newQuery = { ...query };
    if (query['book']?['value'] != null) {
      newQuery['bookId'] = query['book']?['value'];
      newQuery.remove('book');
    }
    if (query['account']?['value'] != null) {
      newQuery['account'] = query['account']?['value'];
    }
    if (query['payees']?['value'] != null) {
      newQuery['payees'] = [query['payees']?['value']];
    }
    if (!(query['categories']?.isEmpty ?? true)) {
      newQuery['categories'] = query['categories'].map((e) => e['value']).toList();
    }
    if (!(query['tags']?.isEmpty ?? true)) {
      newQuery['tags'] = query['tags'].map((e) => e['value']).toList();
    }
    return newQuery;
  }


}