import 'package:flutter/material.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/shortcut.dart';

class PPOBTextField extends StatelessWidget {
  const PPOBTextField({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.isFilled,
    required this.isPassword,
    required this.hintText,
    this.suffixOnTap,
    this.onChanged,
    required this.prefixIcon,
    required this.text,
    this.isEmail = false,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
  });
  final bool obscureText;
  final bool readOnly;
  final TextEditingController controller;
  final bool isFilled;
  final bool isPassword;
  final void Function()? suffixOnTap;
  final void Function(String)? onChanged;
  final String hintText;
  final IconData prefixIcon;
  final String text;
  final bool isEmail;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    Shortcut shortcut = Shortcut.of(context);
    return TextFormField(
      readOnly: readOnly,
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText,
      style: shortcut.text.bodyMedium,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          size: 20,
        ),
        prefixIconConstraints: BoxConstraints.tight(
          const Size(40, 20),
        ),
        prefixIconColor: isFilled ? Colors.black : Colors.grey,
        hintText: hintText,
        hintStyle: shortcut.text.bodyMedium!.copyWith(
          color: Colors.grey,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 8,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: readOnly ? Colors.grey[300]! : shortcut.color.primary,
            width: 2,
          ),
        ),
        suffixIcon: isPassword
            ? IconButton(
                onPressed: suffixOnTap,
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20,
                ),
              )
            : const SizedBox(),
        suffixIconColor: Colors.grey,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$text Tidak boleh kosong";
        }
        if (isEmail && !emailRegex.hasMatch(value)) {
          return 'Format email salah';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}

final RegExp emailRegex = RegExp(
  r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
);
