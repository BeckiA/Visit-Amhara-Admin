import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../authentication_repository/authentication_repository.dart';
import '../controllers/signin_controller.dart';

class UserProfileScreen extends StatelessWidget {
  final _authRepo = Get.put(AuthenticationRepository());

  @override
  Widget build(BuildContext context) {
    final userName = SignInController.instance.userName;
    final email = SignInController.instance.email;
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(
                  "https://faces-img.xcdn.link/image-lorem-face-3430.jpg"),
            ),
            SizedBox(height: 20.0),
            Text(
              userName,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              email.text,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Perform logout logic here
                AuthenticationRepository.instance.logout();
                // For example, you can use Get.offAllNamed('/login') to navigate to the login screen
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
