import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/env.dart';
import 'package:sims_ppob_muhammadfauzan/env/models/transaction_history_model.dart';

class TransactionProvider extends ChangeNotifier {
  final PPOBApi api = PPOBApi();
  List<TransactionHistory> transactionHistories = [];

  Future<List<TransactionHistory>> getTransactionHistory() async {
    try {
      Response response = await api.get(
        path: 'transaction/history',
        param: {
          "offset": 0,
          "limit": 5,
        },
        requiredAuthToken: true,
      );
      List<TransactionHistory> data = response.data['data']['records']
          .map<TransactionHistory>((e) => TransactionHistory.fromJson(e))
          .toList();
      notifyListeners();
      return transactionHistories = data;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<TransactionHistory>> showMoreTransactionHistory() async {
    try {
      Response response = await api.get(
        path: 'transaction/history',
        param: {
          "offset": transactionHistories.length,
          "limit": 5,
        },
        requiredAuthToken: true,
      );
      List<TransactionHistory> data = response.data['data']['records']
          .map<TransactionHistory>((e) => TransactionHistory.fromJson(e))
          .toList();
      notifyListeners();
      return transactionHistories = [...transactionHistories, ...data];
    } catch (e) {
      throw e.toString();
    }
  }
}
