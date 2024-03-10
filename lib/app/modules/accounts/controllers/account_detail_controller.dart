import '../../../core/base/base_repository.dart';
import '../../../core/base/enums.dart';
import '/app/core/base/base_controller.dart';

class AccountDetailController extends BaseController {

  int id;
  LoadDataStatus status = LoadDataStatus.initial;
  Map<String, dynamic> item = {};

  AccountDetailController(this.id);

  @override
  void onInit() {
    super.onInit();
    load();
  }

  void load() async {
    try {
      status = LoadDataStatus.progress;
      update();
      item = await BaseRepository.get('accounts', id);
      status = LoadDataStatus.success;
      update();
    } catch (_) {
      status = LoadDataStatus.failure;
      update();
    }
  }

}