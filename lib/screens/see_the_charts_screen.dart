import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SeeTheChartsScreen extends StatelessWidget {
  const SeeTheChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulated data (replace with your actual data logic)
    final List<double> pHData = [7.0, 7.2, 7.1, 6.9, 7.3];
    final List<double> turbidityData = [10.0, 12.0, 9.0, 11.0, 8.0];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text('Water Quality Trends', style: TextStyle(fontSize: 20)),
          Expanded(
            child: SfCartesianChart(
              primaryXAxis: NumericAxis(),
              series: [
                LineSeries<double, int>(
                  dataSource: pHData,
                  xValueMapper: (_, index) => index,
                  yValueMapper: (value, _) => value,
                  name: 'pH',
                ),
                LineSeries<double, int>(
                  dataSource: turbidityData,
                  xValueMapper: (_, index) => index,
                  yValueMapper: (value, _) => value,
                  name: 'Turbidity (NTU)',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Latest Readings:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text('pH: ${pHData.last}'),
          Text('Turbidity: ${turbidityData.last} NTU'),
        ],
      ),
    );
  }
}
