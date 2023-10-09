import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/env.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/shortcut.dart';
import 'package:sims_ppob_muhammadfauzan/env/extension/on_context.dart';
import 'package:sims_ppob_muhammadfauzan/env/widget/ppob_button.dart';
import 'package:sims_ppob_muhammadfauzan/env/widget/ppob_text_field.dart';
import 'package:sims_ppob_muhammadfauzan/src/login/login_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Shortcut shortcut = Shortcut.of(context);
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 48,
                        width: 48,
                        child: Image.asset(
                          "assets/images/logo.png",
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        "SIMS PPOB",
                        style: shortcut.text.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Masuk atau buat akun\nuntuk memulai",
                    style: shortcut.text.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Consumer<LoginProvider>(
                    builder: (context, value, _) {
                      return PPOBTextField(
                        keyboardType: TextInputType.emailAddress,
                        isEmail: true,
                        controller: emailController,
                        text: "Email",
                        prefixIcon: Icons.alternate_email_rounded,
                        hintText: "Masukkan email anda",
                        isFilled: value.isEmailFilled,
                        isPassword: false,
                        obscureText: false,
                        onChanged: (text) {
                          if (text.isNotEmpty) {
                            value.emailFilled(true);
                          } else {
                            value.emailFilled(false);
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Consumer<LoginProvider>(
                    builder: (context, value, _) {
                      return PPOBTextField(
                        controller: passwordController,
                        text: "Password",
                        prefixIcon: Icons.lock_outline_rounded,
                        hintText: "Masukkan password anda",
                        isFilled: value.isPasswordFilled,
                        isPassword: true,
                        obscureText: value.obscureText,
                        onChanged: (text) {
                          if (text.isNotEmpty) {
                            value.passwordFilled(true);
                          } else {
                            value.passwordFilled(false);
                          }
                        },
                        suffixOnTap: () {
                          value.toggleObscureText();
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Consumer<LoginProvider>(
                    builder: (context, value, _) {
                      return PPOBButton(
                        color: shortcut.color.primary,
                        text: "Masuk",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            value.login(
                              context,
                              emailController.text,
                              passwordController.text,
                            );
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Belum punya akun? registrasi ",
                      style: shortcut.text.bodySmall,
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.toReplacementNamed(
                                route: Routes.register.path,
                              );
                            },
                          text: "di sini",
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
