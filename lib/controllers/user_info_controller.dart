import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';

class UserInfoController extends GetxController {
  static UserInfoController get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<UserModel>> allUser() async {
    final snapshot = await _db.collection("Users").get();
    final userData =
        snapshot.docs.map((e) => UserModel.fromsnapshot(e)).toList();
    return userData;
  }
}
