// ignore_for_file: use_build_context_synchronously
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/env.dart';
import 'package:sims_ppob_muhammadfauzan/env/extension/on_context.dart';
import 'package:sims_ppob_muhammadfauzan/src/navigator/navigator_provider.dart';

class LoginProvider extends ChangeNotifier {
  final PPOBApi api = PPOBApi();
  bool obscureText = true;
  bool isEmailFilled = false;
  bool isPasswordFilled = false;
  void toggleObscureText() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void emailFilled(bool value) {
    isEmailFilled = value;
    notifyListeners();
  }

  void passwordFilled(bool value) {
    isPasswordFilled = value;
    notifyListeners();
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    try {
      Response response = await api.post(
        path: 'login',
        formdata: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode != 200) {
        context.snackbar(
          label: response.data['message'],
        );
      } else {
        storage.setString('token', response.data['data']['token']);
        storage.setString('email', email);
        storage.setString('password', password);
        Provider.of<NavigatorProvider>(context, listen: false).setIndex(0);
        await context.removeToNamed(
          route: Routes.homepage.path,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}
