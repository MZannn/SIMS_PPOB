// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/env.dart';
import 'package:sims_ppob_muhammadfauzan/env/extension/on_context.dart';

class RegisterProvider extends ChangeNotifier {
  bool isEmailFilled = false;
  bool isFirstNameFilled = false;
  bool isLastNameFilled = false;
  bool isPasswordFilled = false;
  bool isConfirmPasswordFilled = false;
  bool obscureTextPassword = true;
  bool obscureTextConfirmPassword = true;
  bool isEqualsPassword = false;
  final PPOBApi api = PPOBApi();
  void emailFilled(bool value) {
    isEmailFilled = value;
    notifyListeners();
  }

  void firstNameFilled(bool value) {
    isFirstNameFilled = value;
    notifyListeners();
  }

  void lastNameFilled(bool value) {
    isLastNameFilled = value;
    notifyListeners();
  }

  void passwordFilled(bool value) {
    isPasswordFilled = value;
    notifyListeners();
  }

  void confirmPasswordFilled(bool value) {
    isConfirmPasswordFilled = value;
    notifyListeners();
  }

  void toggleObscureTextPassword() {
    obscureTextPassword = !obscureTextPassword;
    notifyListeners();
  }

  void toggleObscureTextConfirmPassword() {
    obscureTextConfirmPassword = !obscureTextConfirmPassword;
    notifyListeners();
  }

  Future<void> register(
    BuildContext context,
    String email,
    String firstName,
    String lastName,
    String password,
  ) async {
    try {
      Response response = await api.post(
        path: 'registration',
        formdata: {
          'email': email,
          'first_name': firstName,
          'last_name': lastName,
          'password': password,
        },
      );
      if (response.statusCode != 200) {
        context.snackbar(
          label: response.data['message'],
        );
      } else {
        context.removeToNamed(
          route: Routes.login.path,
        );
      }
    } catch (e) {
      context.snackbar(
        label: e.toString(),
      );
    }
  }
}
