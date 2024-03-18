import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/generated/locales.g.dart';
import '../../core/components/my_form_page.dart';
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
      return MyFormPage(
        title: _buildTitle(context, controller.action),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: controller.valid ? () {
              Get.find<FlowFormController>().submit();
            } : null,
          )
        ],
        children: [
          const Book(),
        ],
      );
    });
  }

}