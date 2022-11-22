import 'package:get/get.dart';

import '../../model/user_model.dart';

class UserController extends GetxController {
  final _data = User().obs;
  User get data => _data.value;
  setData(n) => _data.value = n;
}
