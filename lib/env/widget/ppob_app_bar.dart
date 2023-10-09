import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/shortcut.dart';
import 'package:sims_ppob_muhammadfauzan/src/navigator/navigator_provider.dart';

class PPOBAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PPOBAppBar({
    super.key,
    required this.title,
    this.onTap,
  });
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    Shortcut shortcut = Shortcut.of(context);
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 120,
      leading: Consumer<NavigatorProvider>(
        builder: (context, value, child) {
          return InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
              ),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back, color: Colors.black),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Kembali",
                    style: shortcut.text.bodyMedium!.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      title: Text(
        title,
        style: shortcut.text.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
