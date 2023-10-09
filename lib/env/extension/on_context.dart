import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/shortcut.dart';

extension OnContext on BuildContext {
  Future<T?> toNamed<T extends Object?>(
      {required String route, Object? arguments}) {
    try {
      return Navigator.pushNamed<T>(this, route, arguments: arguments);
    } catch (e) {
      throw AlertDialog(
        title: Text("Gagal Membuka Rute $route"),
        content: Text("$e"),
      );
    }
  }

  Future<T?> toReplacementNamed<T extends Object?, TO>(
      {required String route, Object? arguments, TO? result}) {
    try {
      return Navigator.pushReplacementNamed(this, route, arguments: arguments);
    } catch (e) {
      throw AlertDialog(
        title: Text("Gagal Membuka Rute $route"),
        content: Text("$e"),
      );
    }
  }

  Future<T?> to<T extends Object?>({required Widget child, Object? arguments}) {
    try {
      return Navigator.push<T>(this, MaterialPageRoute(builder: (_) => child));
    } catch (e) {
      throw AlertDialog(
        title: Text("Gagal Membuka Rute $child"),
        content: Text("$e"),
      );
    }
  }

  Future<T?> removeToNamed<T extends Object?>(
      {required String route, Object? arguments}) {
    try {
      return Navigator.pushNamedAndRemoveUntil(this, route, (route) => false,
          arguments: arguments);
    } catch (e) {
      throw AlertDialog(
        title: Text("Gagal Membuka Rute $route"),
        content: Text("$e"),
      );
    }
  }

  void close<T extends Object?>([T? result]) => Navigator.pop<T>(this, result);

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackbar(
      {required String label,
      Color? color,
      Duration? duration,
      EdgeInsetsGeometry? margin,
      void Function(ScaffoldMessengerState snackbar)? onTap}) {
    Shortcut shortcut = Shortcut.of(this);
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        elevation: 2,
        content: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10.0,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: color ?? shortcut.color.primary,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<T?> dialog<T extends Object?>({
    bool barrierDismissible = true,
    Widget? image,
    String? title,
    String? contentLabel,
    Widget? child,
  }) {
    final Shortcut shortcut = Shortcut.of(this);
    return showDialog<T>(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: SizedBox(
          height: 200,
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              image ?? const SizedBox(),
              const SizedBox(
                height: 16,
              ),
              Text(
                title ?? '',
                style: shortcut.text.bodyMedium!,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                contentLabel ?? '',
                style: shortcut.text.titleLarge!.copyWith(),
              ),
              child ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
