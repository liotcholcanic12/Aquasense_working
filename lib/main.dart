import 'package:brb2/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';
import 'widgets/drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

  runApp(MaterialApp(
    home: isLoggedIn ? AppDrawer() : LoginScreen(),
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Persistent Login Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: isLoggedIn ? DashboardScreen() : LoginScreen(),
    );
  }
}
