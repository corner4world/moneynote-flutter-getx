import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import '/app/core/utils/api_url.dart';
import '/app/modules/login/controllers/auth_controller.dart';
import '../data/login_repository.dart';
import '/app/core/commons/form/not_empty_formz.dart';
import '/app/core/base/base_controller.dart';
import '/app/core/values/app_values.dart';

class LoginController extends BaseController {

  bool valid = false;
  FormzSubmissionStatus submissionStatus = FormzSubmissionStatus.initial;
  NotEmptyFormz usernameFormz = const NotEmptyFormz.pure();
  NotEmptyFormz passwordFormz = const NotEmptyFormz.pure();
  NotEmptyFormz apiFormz = NotEmptyFormz.dirty(value: AppValues.apiUrl);
  TextEditingController apiController = TextEditingController();

  AuthController authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    apiController.value = apiController.value.copyWith(text: AppValues.apiUrl);
  }

  void usernameChanged(String username) {
    usernameFormz = NotEmptyFormz.dirty(value: username);
    valid = Formz.validate([usernameFormz, passwordFormz, apiFormz]);
    update();
  }

  void passwordChanged(String password) {
    passwordFormz = NotEmptyFormz.dirty(value: password);
    valid = Formz.validate([usernameFormz, passwordFormz, apiFormz]);
    update();
  }

  void apiChanged(String api) {
    apiFormz = NotEmptyFormz.dirty(value: api);
    valid = Formz.validate([usernameFormz, passwordFormz, apiFormz]);
    update();
  }

  void login() async {
    if (valid) {
      try {
        submissionStatus = FormzSubmissionStatus.inProgress;
        update();
        String token = await LoginRepository.logIn(username: usernameFormz.value, password: passwordFormz.value);
        authController.onLoggedIn(token);
        submissionStatus = FormzSubmissionStatus.success;
        update();
        await ApiUrl.save(apiFormz.value);
      } catch (_) {
        submissionStatus = FormzSubmissionStatus.failure;
        update();
      }
    }
  }

}