import 'package:flutter/material.dart';
import '../models/water_quality.dart';

class WaterQualityCard extends StatelessWidget {
  final WaterQuality waterQuality;

  const WaterQualityCard({required this.waterQuality});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('pH: ${waterQuality.pH}', style: TextStyle(fontSize: 18)),
            Text('Turbidity: ${waterQuality.turbidity} NTU',
                style: TextStyle(fontSize: 18)),
            Text('Temperature: ${waterQuality.temperature}°C',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text(
              'Drinkable: ${waterQuality.isDrinkable ? "Yes" : "No"}',
              style: TextStyle(
                fontSize: 20,
                color: waterQuality.isDrinkable ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
