// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/env.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/shortcut.dart';
import 'package:sims_ppob_muhammadfauzan/env/extension/on_context.dart';
import 'package:sims_ppob_muhammadfauzan/env/models/services_model.dart';
import 'package:sims_ppob_muhammadfauzan/src/home/home_provider.dart';

class PaymentProvider extends ChangeNotifier {
  final PPOBApi api = PPOBApi();

  Future<void> payment(BuildContext context, ServiceModel serviceModel) async {
    Shortcut shortcut = Shortcut.of(context);
    try {
      Response response = await api.post(
        path: 'transaction',
        formdata: {
          'service_code': '${serviceModel.serviceCode}',
        },
        requiredAuthToken: true,
      );
      if (response.statusCode != 200) {
        context.dialog(
          image: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.red,
            ),
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 25,
            ),
          ),
          title: 'Pembayaran ${serviceModel.serviceName} sebesar',
          contentLabel: NumberFormat.currency(
            locale: 'id',
            symbol: 'Rp ',
            decimalDigits: 0,
          ).format(serviceModel.serviceTariff),
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              const Text("gagal"),
              TextButton(
                onPressed: () {
                  context.close();
                  context.close();
                },
                child: Text(
                  "Kembali ke Beranda",
                  style: shortcut.text.bodyMedium!.copyWith(
                    color: shortcut.color.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        Provider.of<HomeProvider>(context, listen: false).getBalance(context);
        context.dialog(
          barrierDismissible: false,
          image: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.green,
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 25,
            ),
          ),
          title: 'Pembayaran ${serviceModel.serviceName} sebesar',
          contentLabel: NumberFormat.currency(
            locale: 'id',
            symbol: 'Rp ',
            decimalDigits: 0,
          ).format(serviceModel.serviceTariff),
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              const Text("berhasil!"),
              TextButton(
                onPressed: () {
                  context.close();
                  context.close();
                },
                child: Text(
                  "Kembali ke Beranda",
                  style: shortcut.text.bodyMedium!.copyWith(
                    color: shortcut.color.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      context.snackbar(
        label: e.toString(),
      );
    }
  }
}
