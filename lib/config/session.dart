import 'dart:convert';

import 'package:distro66_app/data/models/user_model.dart';
import 'package:distro66_app/presentation/controllers/c_user.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static Future<bool> saveUser(UserModel user) async {
    final pref = await SharedPreferences.getInstance();
    Map<String, dynamic> mapUser = user.toJson();
    String stringUser = jsonEncode(mapUser);
    bool success = await pref.setString('user', stringUser);
    if (success) {
      final cUser = Get.put(CUser());
      cUser.setData(user);
    }
    return success;
  }

  static Future<UserModel> getUser() async {
    UserModel user = UserModel(); // default value
    final pref = await SharedPreferences.getInstance();
    String? stringUser = pref.getString('user');
    if (stringUser != null) {
      Map<String, dynamic> mapUser = jsonDecode(stringUser);
      user = UserModel.fromJson(mapUser);
    }
    final cUser = Get.put(CUser());
    cUser.setData(user);

    return user;
  }

  static Future<bool> saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    bool success = await pref.setString('token', token);
    return success;
  }

  static Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('token');
  }

  static Future<void> clearToken() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('token');
  }
}
