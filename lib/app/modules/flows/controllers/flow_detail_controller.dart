import 'package:get/get.dart';
import '/app/core/utils/message.dart';
import '/app/core/base/base_repository.dart';
import '/app/core/base/enums.dart';
import '/app/core/base/base_controller.dart';
import 'flows_controller.dart';

class FlowDetailController extends BaseController {

  int id;
  LoadDataStatus status = LoadDataStatus.initial;
  Map<String, dynamic> item = {};
  LoadDataStatus deleteStatus = LoadDataStatus.initial;

  FlowDetailController(this.id);

  @override
  void onInit() {
    super.onInit();
    load();
  }

  void load() async {
    try {
      status = LoadDataStatus.progress;
      update();
      item = await BaseRepository.get('balance-flows', id);
      status = LoadDataStatus.success;
      update();
    } catch (_) {
      status = LoadDataStatus.failure;
      update();
    }
  }

  void delete() async {
    try {
      Message.showLoading();
      final result = await BaseRepository.delete('balance-flows', id);
      if (result) {
        Get.back();
        Get.find<FlowsController>().reload();
      }
    } catch (_) {
      _.printError();
    }
  }

  void confirm() async {
    try {
      Message.showLoading();
      final result = await BaseRepository.action('balance-flows/${item['id']}/confirm');
      if (result) {
        Get.find<FlowDetailController>().load();
      }
    } catch (_) {
      _.printError();
    }
  }

}