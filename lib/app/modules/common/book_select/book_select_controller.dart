import 'package:get/get.dart';
import 'package:moneynote/app/core/base/base_controller.dart';
import 'package:moneynote/app/modules/login/controllers/auth_controller.dart';
import '/app/core/base/base_repository.dart';
import '/app/core/base/enums.dart';

class BookSelectController extends BaseController {

  LoadDataStatus status = LoadDataStatus.initial;
  List<dynamic> options = [];

  @override
  void onInit() {
    super.onInit();
  }

  void load() async {
    try {
      status = LoadDataStatus.progress;
      options = [];
      update();
      options = await BaseRepository.queryAll('books');
      status = LoadDataStatus.success;
      update();
    } catch (_) {
      status = LoadDataStatus.failure;
      update();
    }
  }

}