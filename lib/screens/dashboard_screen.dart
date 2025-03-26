import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../services/water_quality_service.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  WaterQuality? _currentReading;
  List<WaterQuality> _historicalData = [];
  int _timeCounter = 0;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final initialData = await WaterQualityService.getWaterQuality();
    final history = await WaterQualityService.getHistoricalData();
    setState(() {
      _currentReading = initialData;
      _historicalData = history;
    });
  }

  Future<void> _refreshData() async {
    final newReading = await WaterQualityService.getWaterQuality();
    setState(() {
      _currentReading = newReading;
      _historicalData.add(WaterQuality(
        time: _timeCounter++,
        pH: newReading.pH,
        turbidity: newReading.turbidity,
        temperature: newReading.temperature,
        isDrinkable: newReading.isDrinkable,
      ));
      // Keep only last 10 readings for the chart
      if (_historicalData.length > 10) {
        _historicalData.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: SfCartesianChart(
              primaryXAxis: NumericAxis(title: AxisTitle(text: 'Time (s)')),
              primaryYAxis: NumericAxis(title: AxisTitle(text: 'Value')),
              series: [
                LineSeries<WaterQuality, int>(
                  dataSource: _historicalData,
                  xValueMapper: (data, _) => data.time,
                  yValueMapper: (data, _) => data.pH,
                  name: 'pH',
                ),
                LineSeries<WaterQuality, int>(
                  dataSource: _historicalData,
                  xValueMapper: (data, _) => data.time,
                  yValueMapper: (data, _) => data.turbidity,
                  name: 'Turbidity (NTU)',
                ),
              ],
            ),
          ),
          if (_currentReading != null) ...[
            Text('Latest pH: ${_currentReading!.pH.toStringAsFixed(1)}'),
            Text(
                'Latest Turbidity: ${_currentReading!.turbidity.toStringAsFixed(1)} NTU'),
            Text(
                'Temperature: ${_currentReading!.temperature.toStringAsFixed(1)}°C'),
            Text(
                'Drinkable: ${_currentReading!.isDrinkable ? "✅ Yes" : "❌ No"}',
                style: TextStyle(
                  color:
                      _currentReading!.isDrinkable ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ],
      ),
    );
  }
}

// Add time property to WaterQuality model (modify in water_quality_service.dart)
class WaterQuality {
  final int time; // Added for chart tracking
  final double pH;
  final double turbidity;
  final double temperature;
  final bool isDrinkable;

  WaterQuality({
    required this.time,
    required this.pH,
    required this.turbidity,
    required this.temperature,
    required this.isDrinkable,
  });
}
