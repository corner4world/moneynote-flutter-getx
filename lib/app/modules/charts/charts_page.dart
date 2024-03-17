import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'widgets/circular_legend.dart';
import '/app/core/utils/widget_util.dart';
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
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    _buildChart(controller.data),
                    const SizedBox(height: 10),
                    CircularLegend(xys: controller.data)
                  ],
                ),
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

  Widget _buildChart(List<Map<String, dynamic>> data) {
    Map<String, double> dataMap = { };
    for (var e in data) {
      dataMap[e['x']] = e['y'];
    }
    return SfCircularChart(
      title: ChartTitle(text: LocaleKeys.chart_expenseCategory.tr),
      legend: Legend(isVisible: false),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: getDefaultDoughnutSeries(data),
      annotations: [
        CircularChartAnnotation(
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('总金额', style: TextStyle(color: Colors.grey, fontSize: 12)),
                Text(calChartTotal(data).toStringAsFixed(2), style: const TextStyle(color: Colors.black, fontSize: 18))
              ],
            )
        )
      ],
    );
  }

}