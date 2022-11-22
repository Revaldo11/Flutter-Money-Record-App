import 'dart:convert';
import 'package:get/get.dart';
import 'package:money_record/components/controller/user_controller.dart';
import 'package:money_record/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

//shared preferences digunakan untuk menyimpan data user yang sedang login ke dalam aplikasi
//agar ketika aplikasi dijalankan kembali, data user yang sedang login tidak hilang dan tetap tersimpan di dalam
//aplikasi tersebut sampai user logout dari aplikasi tersebut atau aplikasi tersebut di uninstall
//dari perangkat user tersebut

class Session {
  static Future<bool> saveUser(User user) async {
    final pref = await SharedPreferences.getInstance();
    Map<String, dynamic> mapUser = user.toJson();
    String stringUser = jsonEncode(mapUser);
    bool success = await pref.setString('user', stringUser);
    if (success) {
      final userController = Get.put(UserController());
      userController.setData(user);
    }
    return success;
  } // menyimpan data user ke dalam shared preferences

  static Future<User> getUser() async {
    User user = User(); // default value
    final pref = await SharedPreferences.getInstance();
    String? stringUser = pref.getString('user');
    if (stringUser != null) {
      Map<String, dynamic> mapUser = jsonDecode(stringUser);
      user = User.fromJson(mapUser);
    }

    final userController = Get.put(UserController());
    userController.setData(user);

    return user;
  } // mengambil data user dari shared preferences

  static Future<bool> removeUser() async {
    final pref = await SharedPreferences.getInstance();
    bool success = await pref.remove('user');
    if (success) {
      final userController = Get.put(UserController());
      userController.setData(User());
    }
    return success;
  } // menghapus data user dari shared preferences
}
