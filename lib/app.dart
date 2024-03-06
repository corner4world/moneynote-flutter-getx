import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneynote/generated/locales.g.dart';
import '/app/core/values/app_values.dart';
import '/app/routes/app_pages.dart';

class App extends StatelessWidget {

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppValues.appName,
      translationsKeys: AppTranslation.translations,
      // locale: Get.deviceLocale,
      locale: const Locale('zh', 'CN'),
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }

}