import 'package:get/get.dart';
import 'package:distro66_app/data/models/user_model.dart';

class CUser extends GetxController {
  final _data = UserModel().obs;
  UserModel get token => _data.value;
  UserModel get data => _data.value;
  setData(n) => _data.value = n;
}
