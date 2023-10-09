import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/env.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/shortcut.dart';
import 'package:sims_ppob_muhammadfauzan/src/splash/splash_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      String? token;
      token = await Provider.of<SplashProvider>(context, listen: false)
          .checkToken();
      await Future.delayed(const Duration(seconds: 2), () {
        if (token != null) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.homepage.path,
            (route) => false,
          );
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.login.path,
            (route) => false,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Shortcut shortcut = Shortcut.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png"),
            const SizedBox(
              height: 16,
            ),
            Text(
              "SIMS PPOB",
              style: shortcut.text.titleLarge,
            ),
            Text(
              "Muhammad Fauzan",
              style: shortcut.text.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
