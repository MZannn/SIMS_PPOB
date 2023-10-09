import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/env.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/shortcut.dart';
import 'package:sims_ppob_muhammadfauzan/env/extension/on_context.dart';
import 'package:sims_ppob_muhammadfauzan/src/home/home_provider.dart';
import 'package:sims_ppob_muhammadfauzan/src/home/widget/home_menu_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<HomeProvider>(context, listen: false).getUser(context);
      Provider.of<HomeProvider>(context, listen: false).getServices(context);
      Provider.of<HomeProvider>(context, listen: false).getBanner(context);
      await Provider.of<HomeProvider>(context, listen: false)
          .getBalance(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Shortcut shortcut = Shortcut.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Image.asset("assets/images/logo.png"),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "SIMS PPOB",
              style: shortcut.text.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
            ),
            child: Consumer<HomeProvider>(
              builder: (context, value, child) {
                return SizedBox(
                    height: 30,
                    width: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: !(value.user?.profileImage ?? '').contains('null')
                          ? Image.network(
                              "${value.user?.profileImage}",
                              fit: BoxFit.cover,
                            )
                          : Image.asset("assets/images/profile_photo_1.png"),
                    ));
              },
            ),
          ),
          const SizedBox(
            width: 24,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selamat Datang,",
                    style: shortcut.text.bodyLarge,
                  ),
                  Consumer<HomeProvider>(
                    builder: (context, value, child) {
                      return Text(
                        "${value.user?.firstName ?? ''} ${value.user?.lastName ?? ''}",
                        style: shortcut.text.titleLarge,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 150,
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
                            return Row(
                              children: [
                                Text(
                                  "Rp ",
                                  style: shortcut.text.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  !value.isHidden
                                      ? NumberFormat.currency(
                                          locale: 'id_ID',
                                          symbol: '',
                                          decimalDigits: 0,
                                        ).format(value.balance?.balance)
                                      : "••••••••••",
                                  style: shortcut.text.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: !value.isHidden ? 24 : 36,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                        Consumer<HomeProvider>(
                          builder: (context, value, child) {
                            return InkWell(
                              onTap: () {
                                value.toggleHiddenWallet();
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Lihat Saldo",
                                    style: shortcut.text.bodySmall!.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(
                                    Icons.visibility_outlined,
                                    size: 16,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Consumer<HomeProvider>(
                    builder: (context, value, child) {
                      return Wrap(
                        spacing: 10,
                        runSpacing: 16,
                        children: value.services
                            .map(
                              (e) => HomeMenuItem(
                                onTap: () {
                                  context.toNamed(
                                    route: Routes.payment.path,
                                    arguments: e,
                                  );
                                },
                                asset: e.serviceIcon ?? "",
                                text: e.serviceName!.contains('Berlangganan') ||
                                        e.serviceName!.contains('Voucher') ||
                                        e.serviceName!.contains('Paket') ||
                                        e.serviceName!.contains('Pajak')
                                    ? e.serviceName!
                                        .replaceAll('Berlangganan', '')
                                        .replaceAll('Pajak', '')
                                        .replaceAll('Voucher', '')
                                        .replaceAll('Paket', '')
                                    : e.serviceName!,
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Temukan promo menarik",
                    style: shortcut.text.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Consumer<HomeProvider>(
              builder: (context, value, child) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.only(
                    left: 24,
                  ),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: value.listBanner
                        .map(
                          (e) => InkWell(
                            onTap: () {
                              context.toNamed(
                                route: Routes.banner.path,
                                arguments: e,
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                right: 8,
                              ),
                              width: 250,
                              child: Image.network(
                                "${e.bannerImage}",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
