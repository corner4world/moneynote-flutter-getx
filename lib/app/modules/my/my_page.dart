import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneynote/app/core/components/bottomsheet_container.dart';
import 'package:moneynote/app/core/utils/language.dart';
import 'package:moneynote/app/core/values/app_values.dart';
import 'package:moneynote/app/modules/my/controllers/language_controller.dart';
import 'package:moneynote/app/modules/my/controllers/theme_controller.dart';
import 'package:moneynote/generated/locales.g.dart';

import '../../core/components/dialog_confirm.dart';
import '../login/controllers/auth_controller.dart';

class MyPage extends StatelessWidget {

  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.menu_my.tr),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ListTile(
              //     title: const Text('登录用户名：'),
              //     trailing: Text(initState['user']['username'])
              // ),
              // ListTile(
              //     title: const Text('当前默认账本：'),
              //     trailing: Text(initState['book']['name'])
              // ),
              ListTile(
                title: Text(LocaleKeys.my_currentTheme.tr),
                trailing: GetBuilder<ThemeController>(builder: (controller) {
                  return Text(controller.currentLabel());
                }),
                onTap: () {
                  Get.bottomSheet(
                    BottomSheetContainer(child: GetBuilder<ThemeController>(builder: (controller) {
                      return Wrap(
                        children: controller.themes.map((e) =>
                            ListTile(
                              title: Text(e['label']),
                              onTap: () {
                                Get.find<ThemeController>().changeTheme(e['name'], e['theme']);
                              },
                              selected: e['selected'],
                            )
                        ).toList(),
                      );
                    }))
                  );
                },
              ),
              const Divider(),
              ListTile(
                title: Text(LocaleKeys.my_currentLang.tr),
                trailing: Builder(builder: (BuildContext context) {
                  String locale = Get.locale?.toString() ?? '';
                  if (locale == 'en_US') {
                    return const Text("🇺🇸 English");
                  } else if (locale == 'zh_CN') {
                    return const Text("🇨🇳 简体中文");
                  }
                  return const Text("Not Found");
                }),
                onTap: () {
                  Get.bottomSheet(
                    BottomSheetContainer(child: GetBuilder<LanguageController>(builder: (controller) {
                      return Wrap(
                        children: controller.languages.map((e) =>
                          ListTile(
                            title: Text(e['label']),
                            onTap: () {
                              Get.find<LanguageController>().changeLang(e['name'], e['locale']);
                            },
                            selected: e['selected'],
                          )
                        ).toList(),
                      );
                    }))
                  );
                },
              ),
              const Divider(),
              ListTile(
                title: Text(LocaleKeys.my_currentVersion.tr),
                trailing: const Text(AppValues.version)
              ),
              const Divider(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: DialogConfirm(
                  child: AbsorbPointer(
                    child: ElevatedButton(
                      onPressed: () { },
                      child: Text(LocaleKeys.my_logout.tr),
                    ),
                  ),
                  onConfirm: () {
                    // BlocProvider.of<AuthBloc>(context).add(LoggedOut());
                    Get.find<AuthController>().onLoggedOut();
                  }
                )
              ),
              const SizedBox(height: 30),
            ],
          ),
        )
    );
  }
}