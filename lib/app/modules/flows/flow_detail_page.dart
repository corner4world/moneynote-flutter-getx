import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/core/components/dialog_confirm.dart';
import '/app/modules/accounts/controllers/account_detail_controller.dart';
import '/app/modules/login/controllers/auth_controller.dart';
import '/generated/locales.g.dart';
import '/app/core/base/enums.dart';
import '/app/core/components/pages/index.dart';
import 'controllers/flow_detail_controller.dart';

class FlowDetailPage extends StatelessWidget {

  const FlowDetailPage({super.key});

  @override
  Widget build(BuildContext context) {

    AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.account_detailTitle.tr),
      ),
      body: GetBuilder<FlowDetailController>(builder: (controller) {
        LoadDataStatus status = controller.status;
        switch (status) {
          case LoadDataStatus.progress:
          case LoadDataStatus.initial:
            return const LoadingPage();
          case LoadDataStatus.success:
            return ContentPage(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.edit, size: 15),
                      onPressed: () {
                        // Get.put(AccountFormController(controller.item['type'], 2, controller.item));
                        // Get.to(() => const AccountFormPage(), fullscreenDialog: true)?.then(
                        //   (value) => Get.delete<AccountFormController>()
                        // );
                      },
                      label: Text(LocaleKeys.common_edit.tr),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: DialogConfirm(
                        child: AbsorbPointer(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.delete, size: 15),
                            onPressed: controller.deleteStatus == LoadDataStatus.progress ? null : () { },
                            label: Text(LocaleKeys.common_delete.tr),
                          ),
                        ),
                        onConfirm: () {
                          Get.find<AccountDetailController>().delete();
                        }
                    ),
                  )
                ],
              )
            );
          default:
            return const ErrorPage();
        }
      }),
    );
  }

}