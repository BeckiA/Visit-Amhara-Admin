import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;

  const UserModel(
      {this.id,
      required this.email,
      required this.password,
      required this.fullName,
      required this.phoneNo});

  factory UserModel.fromsnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();

    return UserModel(
        id: document.id,
        password: data!["Password"],
        fullName: data["FullName"],
        email: data["Email"],
        phoneNo: data["Phone"]);
  }
}
