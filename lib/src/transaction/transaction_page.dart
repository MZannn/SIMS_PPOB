// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/shortcut.dart';
import 'package:sims_ppob_muhammadfauzan/env/widget/ppob_app_bar.dart';
import 'package:sims_ppob_muhammadfauzan/src/home/home_provider.dart';
import 'package:sims_ppob_muhammadfauzan/src/navigator/navigator_provider.dart';
import 'package:sims_ppob_muhammadfauzan/src/transaction/transaction_provider.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<TransactionProvider>(context, listen: false)
          .getTransactionHistory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Shortcut shortcut = Shortcut.of(context);
    return Scaffold(
      appBar: PPOBAppBar(
        title: 'Transaksi',
        onTap: () {
          Provider.of<NavigatorProvider>(context, listen: false).setIndex(0);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: shortcut.query.size.width,
              padding: const EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 24,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: const DecorationImage(
                  image: AssetImage(
                    "assets/images/background_saldo.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Saldo Anda",
                    style: shortcut.text.bodyLarge!.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Consumer<HomeProvider>(
                    builder: (context, value, child) {
                      return Text(
                        NumberFormat.currency(
                          locale: 'id_ID',
                          symbol: 'Rp ',
                          decimalDigits: 0,
                        ).format(value.balance?.balance),
                        style: shortcut.text.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            Text(
              "Transaksi",
              style: shortcut.text.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Consumer<TransactionProvider>(
              builder: (context, value, child) {
                return Column(
                  children: List.generate(
                        value.transactionHistory.length,
                        (index) => Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          margin: const EdgeInsets.only(
                            bottom: 24,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey[300]!,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${value.transactionHistory[index].transactionType == "TOPUP" ? '+' : '-'} ${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(
                                      value.transactionHistory[index]
                                          .totalAmount,
                                    )}",
                                    style: shortcut.text.bodyLarge!.copyWith(
                                      color: value.transactionHistory[index]
                                                  .transactionType ==
                                              "TOPUP"
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                  Text(
                                    DateFormat(
                                            "dd MMMM yyyy, HH:mm WIB", 'id_ID')
                                        .format(value.transactionHistory[index]
                                            .createdOn!),
                                    style: shortcut.text.bodySmall!.copyWith(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "${value.transactionHistory[index].description}",
                                    style: shortcut.text.bodySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ) +
                      [
                        Container(
                          child: TextButton(
                            onPressed: () {
                              value.showMoreTransactionHistory();
                            },
                            child: Text(
                              "Show More",
                              style: shortcut.text.bodyMedium!.copyWith(
                                color: shortcut.color.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
