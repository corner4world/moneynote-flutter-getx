import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/core/components/pages/index.dart';
import '/app/modules/charts/charts_controller.dart';
import '/generated/locales.g.dart';
import '/app/core/base/enums.dart';

class ChartsPage extends StatefulWidget {

  const ChartsPage({super.key});

  @override
  State<ChartsPage> createState() => _ChartsPageState();

}

class _ChartsPageState extends State<ChartsPage> with TickerProviderStateMixin {

  int tabIndex = 0;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: tabIndex, length: 4, vsync: this);
    tabController.addListener(() {
      if(!tabController.indexIsChanging) {
        setState(() {
          tabIndex = tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {

          },
          icon: const Icon(Icons.refresh)
        ),
        title: TabBar(
          controller: tabController,
          labelPadding: const EdgeInsets.all(0),
          tabs: [
            Tab(child: Text(LocaleKeys.flow_type1.tr)),
            Tab(child: Text(LocaleKeys.flow_type2.tr)),
            Tab(child: Text(LocaleKeys.chart_asset.tr)),
            Tab(child: Text(LocaleKeys.chart_debt.tr)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: (tabIndex == 2 || tabIndex == 3) ? null : () {
              if (tabIndex == 0) {
                // fullDialog(context, const ChartExpenseFilterPage());
              } else if (tabIndex == 1) {
                // fullDialog(context, const ChartIncomeFilterPage());
              }
            },
            icon: const Icon(Icons.search)
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
            if (tabController.index < 3) {
              tabController.animateTo(tabController.index + 1);
            }
          }
        },
        child: GetBuilder<ChartsController>(builder: (controller) {
          LoadDataStatus status = controller.status;
          switch (status) {
            case LoadDataStatus.progress:
            case LoadDataStatus.initial:
              return const LoadingPage();
            case LoadDataStatus.success:
              return Container(
                color: Colors.red,
                width: double.infinity,
                height: double.infinity,
                child: Text(tabIndex.toString()),
              );
            case LoadDataStatus.empty:
              return const EmptyPage();
            case LoadDataStatus.failure:
              return const ErrorPage();
          }
        })
      ),
    );
  }

}