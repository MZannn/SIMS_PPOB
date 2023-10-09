// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/env.dart';
import 'package:sims_ppob_muhammadfauzan/env/extension/on_context.dart';
import 'package:sims_ppob_muhammadfauzan/env/models/balance_model.dart';
import 'package:sims_ppob_muhammadfauzan/env/models/banner_model.dart';
import 'package:sims_ppob_muhammadfauzan/env/models/services_model.dart';
import 'package:sims_ppob_muhammadfauzan/env/models/user_model.dart';
import 'package:sims_ppob_muhammadfauzan/src/login/login_provider.dart';

class HomeProvider extends ChangeNotifier {
  final PPOBApi api = PPOBApi();
  UserModel? user;
  BalanceModel? balance;
  bool _isHidden = true;
  bool get isHidden => _isHidden;
  List<ServiceModel> services = [];
  List<BannerModel> banners = [];
  Future<UserModel> getUser(BuildContext context) async {
    try {
      Response response = await api.get(
        path: 'profile',
        requiredAuthToken: true,
      );
      if (response.statusCode == 200) {
        user = UserModel.fromJson(response.data['data']);
      } else {
        context.snackbar(label: response.data['message']);
      }
      notifyListeners();
      return user ?? UserModel();
    } catch (e) {
      throw context.snackbar(
        label: e.toString(),
      );
    }
  }

  Future<BalanceModel> getBalance(BuildContext context) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String email = storage.getString('email') ?? '';
    String password = storage.getString('password') ?? '';
    try {
      Response response = await api.get(
        path: 'balance',
        requiredAuthToken: true,
      );
      if (response.statusCode == 200) {
        balance = BalanceModel.fromJson(response.data['data']);
      } else if (response.statusCode == 401 && email != '' && password != '') {
        Provider.of<LoginProvider>(context, listen: false)
            .login(context, email, password);
      } else {
        context.snackbar(label: response.data['message']);
      }
      notifyListeners();
      return balance ?? BalanceModel();
    } catch (e) {
      throw context.snackbar(
        label: e.toString(),
      );
    }
  }

  void toggleHiddenWallet() {
    _isHidden = !_isHidden;
    notifyListeners();
  }

  Future<List<ServiceModel>> getServices(BuildContext context) async {
    List<ServiceModel> data = [];
    try {
      Response response = await api.get(
        path: 'services',
        requiredAuthToken: true,
      );
      if (response.statusCode != 200) {
        context.snackbar(label: response.data['message']);
      } else {
        data = response.data['data']
            .map<ServiceModel>((e) => ServiceModel.fromJson(e))
            .toList();
      }
      notifyListeners();
      return services = data;
    } catch (e) {
      throw context.snackbar(
        label: e.toString(),
      );
    }
  }

  Future<List<BannerModel>> getBanner(BuildContext context) async {
    List<BannerModel> data = [];
    try {
      Response response = await api.get(
        path: 'banner',
        requiredAuthToken: true,
      );
      if (response.statusCode != 200) {
        context.snackbar(label: response.data['message']);
      } else {
        data = response.data['data']
            .map<BannerModel>((e) => BannerModel.fromJson(e))
            .toList();
      }
      notifyListeners();
      return banners = data;
    } catch (e) {
      throw context.snackbar(label: e.toString());
    }
  }
}
