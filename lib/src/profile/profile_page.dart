// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/env.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/shortcut.dart';
import 'package:sims_ppob_muhammadfauzan/env/extension/on_context.dart';
import 'package:sims_ppob_muhammadfauzan/env/models/user_model.dart';
import 'package:sims_ppob_muhammadfauzan/env/widget/ppob_app_bar.dart';
import 'package:sims_ppob_muhammadfauzan/env/widget/ppob_button.dart';
import 'package:sims_ppob_muhammadfauzan/env/widget/ppob_text_field.dart';
import 'package:sims_ppob_muhammadfauzan/src/navigator/navigator_provider.dart';
import 'package:sims_ppob_muhammadfauzan/src/profile/profile_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      user = await Provider.of<ProfileProvider>(context, listen: false)
          .getUser(context);
      emailController.text = user?.email ?? '';
      firstNameController.text = user?.firstName ?? '';
      lastNameController.text = user?.lastName ?? '';
    });
    super.initState();
  }

  UserModel? user;
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Shortcut shortcut = Shortcut.of(context);
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: PPOBAppBar(
        title: 'Akun',
        onTap: () {
          Provider.of<NavigatorProvider>(context, listen: false).setIndex(0);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<ProfileProvider>(
              builder: (context, value, child) {
                return Stack(
                  children: [
                    Container(
                      height: 105,
                      width: 105,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: SizedBox(
                          height: 105,
                          width: 105,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: value.pictureFile != null
                                ? Image.file(value.pictureFile!)
                                : !(value.user?.profileImage ?? '')
                                        .contains('null')
                                    ? Image.network(
                                        '${value.user?.profileImage}',
                                        fit: BoxFit.cover,
                                      )
                                    : const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        backgroundImage: AssetImage(
                                          "assets/images/profile_photo_1.png",
                                        ),
                                      ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        value.pickImage(context);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        margin: const EdgeInsets.only(top: 65, left: 65),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            30,
                          ),
                          border: Border.all(
                            color: Colors.grey[500]!,
                          ),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Consumer<ProfileProvider>(
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
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: shortcut.text.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Consumer<ProfileProvider>(
                      builder: (context, value, child) {
                        return PPOBTextField(
                          readOnly: true,
                          controller: emailController,
                          obscureText: false,
                          isFilled: value.isEmailFilled,
                          isPassword: false,
                          hintText: "Email Anda",
                          prefixIcon: Icons.alternate_email_rounded,
                          text: "Email",
                          isEmail: true,
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
                      height: 24,
                    ),
                    Text(
                      "Nama Depan",
                      style: shortcut.text.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Consumer<ProfileProvider>(
                      builder: (context, value, child) {
                        return PPOBTextField(
                          controller: firstNameController,
                          obscureText: false,
                          isFilled: value.isfirstNameFilled,
                          isPassword: false,
                          hintText: "Nama Depan",
                          prefixIcon: Icons.person,
                          text: "Nama Depan",
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
                      height: 24,
                    ),
                    Text(
                      "Nama Belakang",
                      style: shortcut.text.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Consumer<ProfileProvider>(
                      builder: (context, value, child) {
                        return PPOBTextField(
                          controller: lastNameController,
                          obscureText: false,
                          isFilled: value.islastNameFilled,
                          isPassword: false,
                          hintText: "Nama Belakang",
                          prefixIcon: Icons.person,
                          text: "Nama Belakang",
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
                      height: 36,
                    ),
                    Consumer<ProfileProvider>(
                      builder: (context, value, child) {
                        return PPOBButton(
                          onPressed: () {
                            value.updateProfile(
                              context,
                              value.pictureFile,
                              firstNameController.text,
                              lastNameController.text,
                            );
                          },
                          text: "Edit Profile",
                          color: Colors.white,
                          textColor: shortcut.color.primary,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    PPOBButton(
                      onPressed: () async {
                        Provider.of<ProfileProvider>(context, listen: false)
                            .logout();
                        await context.removeToNamed(route: Routes.splash.path);
                      },
                      text: "Logout",
                      color: shortcut.color.primary,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
