import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Authorized emails (replace with your backend logic)
  static const _authorizedEmails = ['admin@aquasense.com', 'user@example.com'];

  static Future<bool> login(String email, String password) async {
    // Simple validation (replace with API call)
    if (_authorizedEmails.contains(email) && password.length >= 6) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);
      await prefs.setString('user_email', email);
      return true;
    }
    return false;
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_logged_in') ?? false;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
