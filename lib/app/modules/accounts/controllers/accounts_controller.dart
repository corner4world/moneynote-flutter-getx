import 'package:moneynote/app/core/base/base_repository.dart';
import 'package:moneynote/app/core/values/app_const.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '/app/core/base/enums.dart';
import '/app/core/base/base_controller.dart';

class AccountsController extends BaseController {

  LoadDataStatus status = LoadDataStatus.initial;
  List<Map<String, dynamic>> items = [];
  Map<String, dynamic> query = {
    AppConst.pageSizeParameter: AppConst.defaultPageSize
  };

  late RefreshController refreshController;

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController(initialRefresh: false);
    reload();
  }

  void reload() async {
    try {
      status = LoadDataStatus.progress;
      update();
      query[AppConst.pageParameter] = AppConst.pageStart;
      items = await BaseRepository.query1('accounts', query);
      if (items.length < AppConst.defaultPageSize) {
        refreshController.loadNoData();
      }
      if (items.isNotEmpty) {
        status = LoadDataStatus.success;
      } else {
        status = LoadDataStatus.empty;
      }
      update();
    } catch (_) {
      status = LoadDataStatus.failure;
      update();
    }
  }

  void loadMore() async {
    try {
      query[AppConst.pageParameter] = query[AppConst.pageParameter] + 1;
      final newItems = await BaseRepository.query1('accounts', query);
      if (newItems.isNotEmpty) {
        items = List.of(items)..addAll(newItems);
        refreshController.loadComplete();
      } else {
        refreshController.loadNoData();
      }
      update();
    } catch (_) {
      refreshController.loadFailed();
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

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
  }

}