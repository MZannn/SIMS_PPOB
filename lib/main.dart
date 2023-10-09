import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/env.dart';
import 'package:sims_ppob_muhammadfauzan/src/home/home_provider.dart';
import 'package:sims_ppob_muhammadfauzan/src/login/login_provider.dart';
import 'package:sims_ppob_muhammadfauzan/src/navigator/navigator_provider.dart';
import 'package:sims_ppob_muhammadfauzan/src/payment/payment_provider.dart';
import 'package:sims_ppob_muhammadfauzan/src/profile/profile_provider.dart';
import 'package:sims_ppob_muhammadfauzan/src/register/register_provider.dart';
import 'package:sims_ppob_muhammadfauzan/src/splash/splash_provider.dart';
import 'package:sims_ppob_muhammadfauzan/src/top_up/top_up_provider.dart';
import 'package:sims_ppob_muhammadfauzan/src/transaction/transaction_provider.dart';

void main() {
  initializeDateFormatting('id_ID', null);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => RegisterProvider()),
        ChangeNotifierProvider(create: (context) => SplashProvider()),
        ChangeNotifierProvider(create: (context) => NavigatorProvider()),
        ChangeNotifierProvider(create: (context) => TopUpProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
        ChangeNotifierProvider(create: (context) => PaymentProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SIMS PPOB Muhammad Fauzan',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          dialogBackgroundColor: Colors.white,
          dialogTheme: DialogTheme(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          colorScheme: const ColorScheme.light(
            background: Color(0xFFFFFFFF),
            onBackground: Color(0xffCECECE),
            primary: Colors.red,
          ),
          fontFamily: 'Montserrat',
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            labelMedium: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
            labelSmall:
                TextStyle(fontSize: 10, color: Colors.black, letterSpacing: 0),
            bodySmall: TextStyle(fontSize: 12, color: Colors.black),
            bodyMedium: TextStyle(fontSize: 14, color: Colors.black),
            bodyLarge: TextStyle(fontSize: 24),
          ),
        ),
        routes: Env.routes,
        initialRoute: Env.initialRoute,
      ),
    );
  }
}
