import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sims_ppob_muhammadfauzan/env/variable/constant.dart';
import 'package:sims_ppob_muhammadfauzan/src/banner/banner_page.dart';
import 'package:sims_ppob_muhammadfauzan/src/login/login_page.dart';
import 'package:sims_ppob_muhammadfauzan/src/navigator/navigator_page.dart';
import 'package:sims_ppob_muhammadfauzan/src/register/register_page.dart';
import 'package:sims_ppob_muhammadfauzan/src/payment/payment_page.dart';
import 'package:sims_ppob_muhammadfauzan/src/splash/splash_page.dart';
part 'routes.dart';
part 'api.dart';

typedef Env = Environment;

class Environment {
  static Map<String, Widget Function(BuildContext)> routes = {
    for (Routes route in [
      Routes.splash,
      Routes.login,
      Routes.homepage,
      Routes.register,
      Routes.payment,
      Routes.banner,
    ])
      route.path: (BuildContext context) => route.page,
  };
  static String initialRoute = Routes.splash.path;
}
