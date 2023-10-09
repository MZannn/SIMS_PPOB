import 'package:flutter/material.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/shortcut.dart';

class HomeMenuItem extends StatelessWidget {
  const HomeMenuItem({
    super.key,
    this.onTap,
    required this.asset,
    required this.text,
  });
  final void Function()? onTap;
  final String asset;
  final String text;
  @override
  Widget build(BuildContext context) {
    Shortcut shortcut = Shortcut.of(context);
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: shortcut.query.size.width / 8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Image.network(
                asset,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              text,
              style: shortcut.text.bodySmall!.copyWith(
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
