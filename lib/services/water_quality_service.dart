import 'dart:math';

class WaterQuality {
  final int time; // <-- Add this
  final double pH;
  final double turbidity;
  final double temperature;
  final bool isDrinkable;

  WaterQuality({
    required this.time, // <-- Add to constructor
    required this.pH,
    required this.turbidity,
    required this.temperature,
    required this.isDrinkable,
  });
}

// Then modify getWaterQuality() to include time:
Future<WaterQuality> getWaterQuality() async {
  await Future.delayed(Duration(seconds: 1));
  final random = Random();
  return WaterQuality(
    time: DateTime.now().millisecondsSinceEpoch, // or use a counter
    pH: 6.5 + random.nextDouble() * 2.0,
    turbidity: 5.0 + random.nextDouble() * 10.0,
    temperature: 20.0 + random.nextDouble() * 15.0,
    isDrinkable: random.nextDouble() > 0.3, // 70% chance drinkable
  );
}
