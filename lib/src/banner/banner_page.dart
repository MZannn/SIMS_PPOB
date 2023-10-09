import 'package:flutter/material.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/shortcut.dart';
import 'package:sims_ppob_muhammadfauzan/env/extension/on_context.dart';
import 'package:sims_ppob_muhammadfauzan/env/models/banner_model.dart';
import 'package:sims_ppob_muhammadfauzan/env/widget/ppob_app_bar.dart';

class BannerPage extends StatelessWidget {
  const BannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    var banner = ModalRoute.of(context)?.settings.arguments as BannerModel;
    Shortcut shortcut = Shortcut.of(context);
    return Scaffold(
      appBar: PPOBAppBar(
        title: 'Banner Page',
        onTap: () {
          context.close();
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.network("${banner.bannerImage}"),
            ),
            Text(
              "${banner.bannerName}",
              style: shortcut.text.titleLarge,
            ),
            Text(
              "${banner.description}",
              style: shortcut.text.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
