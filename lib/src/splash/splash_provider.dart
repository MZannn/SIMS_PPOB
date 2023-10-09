import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashProvider extends ChangeNotifier {
  Future<String?> checkToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? token = storage.getString('token');
    return token;
  }
}
