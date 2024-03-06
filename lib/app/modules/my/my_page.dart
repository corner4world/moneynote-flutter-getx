import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              const Divider(),
              const ListTile(
                  title: Text('当前版本号：'),
                  trailing: Text('1.0.27')
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