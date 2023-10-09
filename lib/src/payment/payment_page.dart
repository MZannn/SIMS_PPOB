import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/shortcut.dart';
import 'package:sims_ppob_muhammadfauzan/env/extension/on_context.dart';
import 'package:sims_ppob_muhammadfauzan/env/models/services_model.dart';
import 'package:sims_ppob_muhammadfauzan/env/widget/ppob_app_bar.dart';
import 'package:sims_ppob_muhammadfauzan/env/widget/ppob_button.dart';
import 'package:sims_ppob_muhammadfauzan/env/widget/ppob_text_field.dart';
import 'package:sims_ppob_muhammadfauzan/src/home/home_provider.dart';
import 'package:sims_ppob_muhammadfauzan/src/payment/payment_provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    ServiceModel service =
        ModalRoute.of(context)?.settings.arguments as ServiceModel;
    Shortcut shortcut = Shortcut.of(context);
    TextEditingController transactionController = TextEditingController(
      text: service.serviceTariff.toString(),
    );
    return Scaffold(
      appBar: PPOBAppBar(
        title: 'Pembayaran',
        onTap: () {
          context.close();
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
              "Pembayaran",
              style: shortcut.text.bodyMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.network(
                    '${service.serviceIcon}',
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  '${service.serviceName}',
                  style: shortcut.text.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 36,
            ),
            PPOBTextField(
              readOnly: true,
              controller: transactionController,
              obscureText: false,
              isFilled: true,
              isPassword: false,
              hintText: "",
              prefixIcon: Icons.money,
              text: "Nominal",
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 150,
            ),
            Consumer<PaymentProvider>(
              builder: (context, value, child) {
                return PPOBButton(
                  text: "Bayar",
                  color: shortcut.color.primary,
                  onPressed: () {
                    value.payment(
                      context,
                      service,
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
