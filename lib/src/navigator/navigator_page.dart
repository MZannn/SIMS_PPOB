import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_muhammadfauzan/src/home/home_page.dart';
import 'package:sims_ppob_muhammadfauzan/src/navigator/navigator_provider.dart';
import 'package:sims_ppob_muhammadfauzan/src/profile/profile_page.dart';
import 'package:sims_ppob_muhammadfauzan/src/top_up/top_up_page.dart';
import 'package:sims_ppob_muhammadfauzan/src/transaction/transaction_page.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<NavigatorProvider>(
        builder: (context, value, _) {
          switch (value.index) {
            case 0:
              return const HomePage();
            case 1:
              return const TopUpPage();
            case 2:
              return const TransactionPage();
            case 3:
              return const ProfilePage();
            default:
              return const Scaffold();
          }
        },
      ),
      bottomNavigationBar: Consumer<NavigatorProvider>(
        builder: (context, value, child) {
          return BottomAppBar(
            color: Colors.white,
            padding: EdgeInsets.zero,
            child: Container(
              height: 70,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      value.setIndex(0);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: value.index == 0
                              ? Colors.black
                              : Colors.grey[300],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "Home",
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      value.setIndex(1);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.money,
                          color: value.index == 1
                              ? Colors.black
                              : Colors.grey[300],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "Top Up",
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      value.setIndex(2);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.payment,
                          color: value.index == 2
                              ? Colors.black
                              : Colors.grey[300],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "Transaction",
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      value.setIndex(3);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: value.index == 3
                              ? Colors.black
                              : Colors.grey[300],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "Akun",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
