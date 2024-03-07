import 'package:get/get.dart';
import '/app/modules/login/controllers/auth_controller.dart';

class InitialBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
  }

}