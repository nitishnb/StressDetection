import 'package:flutter/material.dart';
import 'package:stress_detection/charts/chart.dart';
import 'package:stress_detection/models/linerseries.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// ignore: must_be_immutable
class LineChart extends StatelessWidget {
  TooltipBehavior? _tooltipBehavior;

  @override
  Widget build(BuildContext context) {

    final List<DeveloperSeries> data = [

      DeveloperSeries(
        year: new DateTime(2021, 5, 10),
        level: 9,
        barColor: charts.ColorUtil.fromDartColor(Colors.green),
      ),
      DeveloperSeries(
        year: new DateTime(2021, 5, 11),
        level: 8,
        barColor: charts.ColorUtil.fromDartColor(Colors.green),
      ),
      DeveloperSeries(
        year: new DateTime(2021, 5, 12),
        level: 6,
        barColor: charts.ColorUtil.fromDartColor(Colors.green),
      ),
      DeveloperSeries(
        year: new DateTime(2021, 5, 13),
        level: 7,
        barColor: charts.ColorUtil.fromDartColor(Colors.green),
      ),
      DeveloperSeries(
        year: new DateTime(2021, 5, 14),
        level: 5,
        barColor: charts.ColorUtil.fromDartColor(Colors.green),
      ),
    ];
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SafeArea(
      child: Center(
          child: DeveloperChart(
            data: data,
          ),
        // child: Container(
        //   // Center is a layout widget. It takes a single child and positions it
        //   // in the middle of the parent.
        //   // height of the Container widget
        //   height: 450,
        //   // width of the Container widget
        //   child: SfCartesianChart(
        //     primaryXAxis: DateTimeAxis(),
        //
        //     // Enable legend
        //     legend:
        //     Legend(isVisible: true,  position: LegendPosition.bottom),
        //     // Chart title
        //     title: ChartTitle(text: 'Stress Level over Past Week'),
        //
        //     // Enable tooltip
        //     tooltipBehavior: _tooltipBehavior,
        //
        //     series: <LineSeries<ChartData, DateTime>>[
        //       LineSeries<ChartData, DateTime>(
        //         // Bind data source
        //           dataSource: <ChartData>[
        //             ChartData(DateTime(2022, 5, 7), 9),
        //             ChartData(DateTime(2022, 5, 8), 8),
        //             ChartData(DateTime(2022, 5, 9), 9),
        //             ChartData(DateTime(2022, 5, 10), 6),
        //             ChartData(DateTime(2022, 5, 11), 5),
        //             ChartData(DateTime(2022, 5, 12), 7),
        //             ChartData(DateTime(2022, 5, 13), 6),
        //           ],
        //           xValueMapper: (ChartData data, _) => data.year,
        //           yValueMapper: (ChartData data, _) => data.sales,
        //           dataLabelSettings: DataLabelSettings(isVisible: true))
        //     ],
        //   ),
        // ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.year, this.sales);

  final DateTime year;
  final double sales;
}
