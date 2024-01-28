import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Dashboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: 10,
                  title: 'Male',
                  color: Colors.blue,
                  radius: 70,
                  showTitle: true
                ),
                PieChartSectionData(
                    value: 15,
                    title: 'Female',
                    radius: 70,
                    color: Colors.pink,
                  showTitle: true
                )
              ]
            )
          ),
        )
    );
  }
}
