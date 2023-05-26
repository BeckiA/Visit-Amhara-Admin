import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:visit_amhara_admin_app/controllers/user_info_controller.dart';
import 'package:visit_amhara_admin_app/models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final _userRepo = Get.put(UserInfoController());
  Future<List<UserModel>> getUserData() async {
    return await _userRepo.allUser();
  }
}
