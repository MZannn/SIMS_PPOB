import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/env.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/shortcut.dart';
import 'package:sims_ppob_muhammadfauzan/env/extension/on_context.dart';
import 'package:sims_ppob_muhammadfauzan/env/widget/ppob_button.dart';
import 'package:sims_ppob_muhammadfauzan/env/widget/ppob_text_field.dart';
import 'package:sims_ppob_muhammadfauzan/src/register/register_provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    Shortcut shortcut = Shortcut.of(context);
    TextEditingController emailController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 36,
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
                  "Lengkapi data untuk\nmembuat akun",
                  style: shortcut.text.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 48,
                ),
                Consumer<RegisterProvider>(
                  builder: (context, value, _) {
                    return PPOBTextField(
                      isEmail: true,
                      keyboardType: TextInputType.emailAddress,
                      text: "Email",
                      controller: emailController,
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
                Consumer<RegisterProvider>(
                  builder: (context, value, _) {
                    return PPOBTextField(
                      controller: firstNameController,
                      text: "Nama depan",
                      prefixIcon: Icons.person,
                      hintText: "Nama depan",
                      isFilled: value.isFirstNameFilled,
                      isPassword: false,
                      obscureText: false,
                      onChanged: (text) {
                        if (text.isNotEmpty) {
                          value.firstNameFilled(true);
                        } else {
                          value.firstNameFilled(false);
                        }
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Consumer<RegisterProvider>(
                  builder: (context, value, _) {
                    return PPOBTextField(
                      controller: lastNameController,
                      text: "Nama Belakang",
                      prefixIcon: Icons.person,
                      hintText: "Nama belakang",
                      isFilled: value.isLastNameFilled,
                      isPassword: false,
                      obscureText: false,
                      onChanged: (text) {
                        if (text.isNotEmpty) {
                          value.lastNameFilled(true);
                        } else {
                          value.lastNameFilled(false);
                        }
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Consumer<RegisterProvider>(
                  builder: (context, value, _) {
                    return PPOBTextField(
                      controller: passwordController,
                      text: "Password",
                      prefixIcon: Icons.lock_outline_rounded,
                      hintText: "Masukkan password anda",
                      isFilled: value.isPasswordFilled,
                      isPassword: true,
                      obscureText: value.obscureTextPassword,
                      onChanged: (text) {
                        if (text.isNotEmpty) {
                          value.passwordFilled(true);
                        } else {
                          value.passwordFilled(false);
                        }
                      },
                      suffixOnTap: () {
                        value.toggleObscureTextPassword();
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Consumer<RegisterProvider>(
                  builder: (context, value, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        PPOBTextField(
                          controller: confirmPasswordController,
                          text: "Konfirmasi Password",
                          prefixIcon: Icons.lock_outline_rounded,
                          hintText: "Konfirmasi Password",
                          isFilled: value.isConfirmPasswordFilled,
                          isPassword: true,
                          obscureText: value.obscureTextConfirmPassword,
                          onChanged: (text) {
                            if (text.isNotEmpty) {
                              value.confirmPasswordFilled(true);
                            } else {
                              value.confirmPasswordFilled(false);
                            }
                            if (confirmPasswordController.text ==
                                passwordController.text) {
                              value.isEqualsPassword = true;
                            } else {
                              value.isEqualsPassword = false;
                            }
                          },
                          suffixOnTap: () {
                            value.toggleObscureTextConfirmPassword();
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        value.isConfirmPasswordFilled
                            ? (!value.isEqualsPassword
                                ? Text(
                                    "Password tidak sama",
                                    style: shortcut.text.bodySmall!.copyWith(
                                      color: shortcut.color.primary,
                                    ),
                                  )
                                : const SizedBox())
                            : const SizedBox(),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 36,
                ),
                Consumer<RegisterProvider>(
                  builder: (_, value, __) {
                    return PPOBButton(
                      color: shortcut.color.primary,
                      text: "Registrasi",
                      onPressed: () {
                        if (formKey.currentState!.validate() &&
                            passwordController.text ==
                                confirmPasswordController.text) {
                          value.register(
                            context,
                            emailController.text,
                            firstNameController.text,
                            lastNameController.text,
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
                    text: "Sudah punya akun? login ",
                    style: shortcut.text.bodySmall,
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.toReplacementNamed(
                              route: Routes.login.path,
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
    );
  }
}
