import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneynote/app/modules/flows/widgets/form/transfer_amount.dart';
import '/generated/locales.g.dart';
import 'widgets/form/index.dart';
import 'controllers/flow_form_controller.dart';


class FlowFormPage extends StatefulWidget {

  const FlowFormPage({super.key});

  @override
  State<FlowFormPage> createState() => _FlowFormPageState();

}


class _FlowFormPageState extends State<FlowFormPage> with TickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    tabController.addListener(() {
      if(!tabController.indexIsChanging) {
        Get.find<FlowFormController>().tabClick(tabController.index);
      }
    });
  }

  Widget _buildTitle(BuildContext context, int action) {
    if (action == 1) {
      return TabBar(
        controller: tabController,
        tabs: [
          Tab(text: LocaleKeys.flow_type1.tr),
          Tab(text: LocaleKeys.flow_type2.tr),
          Tab(text: LocaleKeys.flow_type3.tr),
        ],
      );
    } else {
      //return Text(translateAction(widget.action) + translateFlowType(widget.currentRow['type']));
      return Text('123');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlowFormController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: _buildTitle(context, controller.action),
          actions: [
            IconButton(
              icon: const Icon(Icons.done),
              onPressed: controller.valid ? () {
                Get.find<FlowFormController>().submit();
              } : null,
            )
          ],
        ),
        body: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.velocity.pixelsPerSecond.dx > 0) {
              if (tabController.index > 0) {
                tabController.animateTo(tabController.index - 1);
              }
            } else if (details.velocity.pixelsPerSecond.dx < 0) {
              if (tabController.index < 2) {
                tabController.animateTo(tabController.index + 1);
              }
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
              child: Wrap(
                runSpacing: 5,
                children: [
                  Book(controller: controller),
                  FormTitle(controller: controller),
                  CreateTime(controller: controller),
                  Account(controller: controller),
                  if (controller.type == 'EXPENSE' || controller.type  == 'INCOME') ...[
                    Category(controller: controller),
                    Amount(controller: controller),
                    Payee(controller: controller)
                  ],
                  if (controller.type == 'TRANSFER') ...[
                    ToAccount(controller: controller),
                    TransferAmount(controller: controller)
                  ],
                  FormTag(controller: controller),
                  Confirm(controller: controller),
                  Include(controller: controller),
                  Notes(controller: controller),
                  const SizedBox(height: 70),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.send),
                      onPressed: controller.valid ? () {
                        Get.find<FlowFormController>().submit();
                      } : null,
                      label: Text(LocaleKeys.common_submit.tr)
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

}