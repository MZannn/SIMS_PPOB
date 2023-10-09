// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sims_ppob_muhammadfauzan/env/class/env.dart';
import 'package:sims_ppob_muhammadfauzan/env/extension/on_context.dart';
import 'package:sims_ppob_muhammadfauzan/env/models/user_model.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

class ProfileProvider extends ChangeNotifier {
  File? pictureFile;
  UserModel? user;
  final PPOBApi api = PPOBApi();
  bool isEmailFilled = true;
  bool isfirstNameFilled = true;
  bool islastNameFilled = true;
  void emailFilled(bool value) {
    isEmailFilled = value;
    notifyListeners();
  }

  void firstNameFilled(bool value) {
    isfirstNameFilled = value;
    notifyListeners();
  }

  void lastNameFilled(bool value) {
    islastNameFilled = value;
    notifyListeners();
  }

  Future<File> pickImage(BuildContext context) async {
    XFile? file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );
    int? fileSize = await file?.length();
    if (file != null && fileSize! < 100000) {
      pictureFile = File(file.path);
      notifyListeners();
      return pictureFile!;
    } else if (fileSize! > 100000) {
      pictureFile = null;
      throw context.snackbar(label: 'File size too large');
    } else {
      throw context.snackbar(label: 'No image selected');
    }
  }

  Future<UserModel> updateProfile(BuildContext context, File? imageFile,
      String firstName, String lastName) async {
    try {
      if (imageFile != null &&
          (firstName != user!.firstName || lastName != user!.lastName)) {
        FormData formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(
            imageFile.path,
            filename: basename(
              imageFile.path,
            ),
            contentType: basename(imageFile.path).contains('.jpg')
                ? MediaType.parse('image/jpeg')
                : MediaType.parse('image/png'),
          ),
        });
        Response updateImageResponse = await api.put(
          path: 'profile/image',
          formdata: formData,
          requiredAuthToken: true,
        );
        Response updateProfileResponse = await api.put(
          path: 'profile/update',
          formdata: {
            'first_name': firstName,
            'last_name': lastName,
          },
          requiredAuthToken: true,
        );

        if (updateImageResponse.statusCode != 200 &&
            updateProfileResponse.statusCode != 200) {
          context.snackbar(
              label:
                  '${updateImageResponse.data['message']} & ${updateProfileResponse.data['message']}');
        } else {
          pictureFile = null;
          context.snackbar(label: 'Profile Updated');
          notifyListeners();
          user = UserModel.fromJson(updateProfileResponse.data['data']);
        }
      } else if (imageFile == null &&
          (firstName != user!.firstName || lastName != user!.lastName)) {
        Response updateProfileResponse = await api.put(
          path: 'profile/update',
          formdata: {
            'first_name': firstName,
            'last_name': lastName,
          },
          requiredAuthToken: true,
        );
        if (updateProfileResponse.statusCode != 200) {
          context.snackbar(label: updateProfileResponse.data['message']);
        } else {
          context.snackbar(label: 'Detail Profile Updated');
          notifyListeners();
          user = UserModel.fromJson(updateProfileResponse.data['data']);
        }
      } else if (imageFile != null &&
          (firstName == user!.firstName && lastName == user!.lastName)) {
        FormData formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(
            imageFile.path,
            filename: basename(
              imageFile.path,
            ),
            contentType: basename(imageFile.path).contains('.jpg')
                ? MediaType.parse('image/jpeg')
                : MediaType.parse('image/png'),
          ),
        });
        Response updateImageResponse = await api.put(
          path: 'profile/image',
          formdata: formData,
          requiredAuthToken: true,
        );

        if (updateImageResponse.statusCode != 200) {
          context.snackbar(label: updateImageResponse.data['message']);
        } else {
          pictureFile = null;
          context.snackbar(label: 'Profile Image Updated');
          notifyListeners();
          user = UserModel.fromJson(updateImageResponse.data['data']);
        }
      } else {
        context.snackbar(label: 'Tidak ada perubahan');
      }
      return user ?? UserModel();
    } catch (e) {
      throw context.snackbar(
        label: e.toString(),
      );
    }
  }

  Future<UserModel> getUser(BuildContext context) async {
    try {
      Response response = await api.get(
        path: 'profile',
        requiredAuthToken: true,
      );
      if (response.statusCode != 200) {
        context.snackbar(label: response.data['message']);
      }
      notifyListeners();
      return user = UserModel.fromJson(response.data['data']);
    } catch (e) {
      throw context.snackbar(
        label: e.toString(),
      );
    }
  }

  Future<void> logout() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.remove('token');
    await storage.remove('email');
    await storage.remove('password');
  }
}
