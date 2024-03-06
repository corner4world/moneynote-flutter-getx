import 'package:get/get.dart';
import '/app/modules/login/controllers/auth_controller.dart';

class AuthBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
  }

}
