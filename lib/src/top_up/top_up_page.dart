import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/shortcut.dart';
import 'package:sims_ppob_muhammadfauzan/env/extension/on_context.dart';
import 'package:sims_ppob_muhammadfauzan/env/widget/ppob_app_bar.dart';
import 'package:sims_ppob_muhammadfauzan/env/widget/ppob_button.dart';
import 'package:sims_ppob_muhammadfauzan/env/widget/ppob_text_field.dart';
import 'package:sims_ppob_muhammadfauzan/src/home/home_provider.dart';
import 'package:sims_ppob_muhammadfauzan/src/navigator/navigator_provider.dart';
import 'package:sims_ppob_muhammadfauzan/src/top_up/top_up_provider.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({super.key});

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<TopUpProvider>(context, listen: false)
          .updateSelectedNominal(0);
      await Provider.of<HomeProvider>(context, listen: false)
          .getBalance(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController topUpController = TextEditingController();
    Shortcut shortcut = Shortcut.of(context);
    return Scaffold(
      appBar: PPOBAppBar(
        onTap: () {
          Provider.of<NavigatorProvider>(context, listen: false).setIndex(0);
        },
        title: "Top Up",
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
            Text("Silahkan Masukkan", style: shortcut.text.bodyLarge),
            Text(
              "Nominal Top Up",
              style: shortcut.text.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            Consumer<TopUpProvider>(
              builder: (context, value, child) {
                return PPOBTextField(
                  keyboardType: TextInputType.number,
                  controller: topUpController,
                  obscureText: false,
                  isFilled: value.isTopUpFormFilled,
                  isPassword: false,
                  hintText: "Masukkan nominal Top Up",
                  prefixIcon: Icons.money,
                  text: "Nominal Top Up",
                  onChanged: (text) {
                    if (text.isNotEmpty) {
                      value.topUpFormFilled(true);
                    } else {
                      value.topUpFormFilled(false);
                    }
                    value.updateSelectedNominal(int.parse(text));
                  },
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Consumer<TopUpProvider>(
              builder: (context, value, child) {
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: listNominalChip
                      .map(
                        (e) => InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            topUpController.text = e.toString();
                            value.updateSelectedNominal(e);
                          },
                          child: Container(
                            height: 50,
                            width: shortcut.query.size.width / 3.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: value.selectedNominal == e
                                    ? shortcut.color.primary
                                    : Colors.grey,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                NumberFormat.currency(
                                  locale: "id",
                                  symbol: "Rp ",
                                  decimalDigits: 0,
                                ).format(e),
                                style: shortcut.text.bodyMedium,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
            const SizedBox(
              height: 36,
            ),
            Consumer<TopUpProvider>(
              builder: (context, value, child) {
                return PPOBButton(
                  text: "Top Up",
                  color: topUpController.text != ''
                      ? shortcut.color.primary
                      : Colors.grey,
                  border: topUpController.text != ''
                      ? shortcut.color.primary
                      : Colors.grey[300]!,
                  onPressed: topUpController.text != ''
                      ? () {
                          context.dialog(
                            image: SizedBox(
                              width: 50,
                              height: 50,
                              child: Image.asset("assets/images/logo.png"),
                            ),
                            title: "Anda yakin untuk Top Up sebesar",
                            contentLabel: "${NumberFormat.currency(
                              locale: "id",
                              symbol: "Rp ",
                              decimalDigits: 0,
                            ).format(
                              int.parse(topUpController.text),
                            )} ?",
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                InkWell(
                                  onTap: () {
                                    context.close();
                                    value.topUp(
                                      context,
                                      int.parse(topUpController.text),
                                    );
                                    value.updateSelectedNominal(0);
                                    topUpController.clear();
                                  },
                                  child: SizedBox(
                                    height: 20,
                                    child: Text(
                                      "Ya, lanjutkan Top Up",
                                      style: shortcut.text.bodyMedium!.copyWith(
                                        color: shortcut.color.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                InkWell(
                                  onTap: () {
                                    context.close();
                                  },
                                  child: SizedBox(
                                    height: 20,
                                    child: Text(
                                      "Batalkan",
                                      style: shortcut.text.bodyMedium!.copyWith(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      : () {
                          context.snackbar(
                            label: "Mohon isi nominal Top Up",
                          );
                        },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

var listNominalChip = [
  10000,
  20000,
  50000,
  100000,
  250000,
  500000,
];
