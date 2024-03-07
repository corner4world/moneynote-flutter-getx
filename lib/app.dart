import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/bindings/initial_binding.dart';
import '/app/core/values/app_values.dart';
import '/app/routes/app_pages.dart';
import '/generated/locales.g.dart';
import 'theme.dart';

class App extends StatelessWidget {

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppValues.appName,
      translationsKeys: AppTranslation.translations,
      // locale: Get.deviceLocale,
      // locale: const Locale('zh', 'CN'),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: AppPages.INITIAL,
      initialBinding: InitialBinding(),
      getPages: AppPages.routes,
    );
  }

}