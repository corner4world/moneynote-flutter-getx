import '/app/core/base/base_controller.dart';
import '/app/core/base/base_repository.dart';
import '/app/core/base/enums.dart';

class CurrencySelectController extends BaseController {

  LoadDataStatus status = LoadDataStatus.initial;
  List<dynamic> options = [];

  void load() async {
    try {
      status = LoadDataStatus.progress;
      options = [];
      update();
      options = await BaseRepository.queryAll('currencies');
      status = LoadDataStatus.success;
      update();
    } catch (_) {
      status = LoadDataStatus.failure;
      update();
    }
  }

}