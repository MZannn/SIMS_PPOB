// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/env.dart';
import 'package:sims_ppob_muhammadfauzan/env/extension/on_context.dart';
import 'package:sims_ppob_muhammadfauzan/src/home/home_provider.dart';

class TopUpProvider extends ChangeNotifier {
  int _selectedNominal = 0;
  int get selectedNominal => _selectedNominal;
  final PPOBApi api = PPOBApi();
  bool isTopUpFormFilled = false;

  void updateSelectedNominal(int nominal) {
    _selectedNominal = nominal;

    notifyListeners();
  }

  void topUpFormFilled(bool value) {
    isTopUpFormFilled = value;
    notifyListeners();
  }

  Future<void> topUp(BuildContext context, int topUpAmount) async {
    try {
      Response response = await api.post(
        path: 'topup',
        formdata: {
          'top_up_amount': topUpAmount,
        },
        requiredAuthToken: true,
      );
      if (response.statusCode != 200) {
        context.snackbar(
          label: response.data['message'],
        );
      } else {
        Provider.of<HomeProvider>(context, listen: false).getBalance(context);
        _selectedNominal = 0;
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
