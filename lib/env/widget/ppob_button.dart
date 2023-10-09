import 'package:flutter/material.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/shortcut.dart';

class PPOBButton extends StatelessWidget {
  const PPOBButton({
    super.key,
    required this.text,
    required this.color,
    this.onPressed,
    this.textColor = Colors.white,
    this.border = Colors.red,
  });
  final void Function()? onPressed;
  final String text;
  final Color color;
  final Color textColor;
  final Color border;
  @override
  Widget build(BuildContext context) {
    Shortcut shortcut = Shortcut.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        backgroundColor: color,
        side: BorderSide(
          color: border,
          width: 2,
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: shortcut.text.labelMedium!.copyWith(
          color: textColor,
        ),
      ),
    );
  }
}
