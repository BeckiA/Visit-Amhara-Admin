import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:visit_amhara_admin_app/models/user_model.dart';

import '../controllers/user_controller.dart';
import '../controllers/user_info_controller.dart';

class Users extends StatelessWidget {
  Users({super.key});
  final controller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Visit Amhara Users List")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<List<UserModel>>(
              future: controller.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // print("This is workking");
                  if (snapshot.hasData) {
                    print("I'm the body and I'm excuting");
                    // UserModel userData = snapshot.hasData as UserModel;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              iconColor: Colors.blue,
                              tileColor: Colors.blue.withOpacity(0.1),
                              leading: const Icon(LineAwesomeIcons.user_1),
                              title: Text(
                                  "Name: ${snapshot.data![index].fullName}"),
                              subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(snapshot.data![index].phoneNo),
                                    Text(snapshot.data![index].email)
                                  ]),
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    print("Error: ${snapshot.error}");
                    print("Stack trace: ${snapshot.stackTrace}");

                    // Return an error message widget or handle the error in an appropriate way
                    return const Center(
                      child: Text(
                          "An error occurred while loading user information. Please try again later."),
                    );
                  } else {
                    return const Center(
                      child: Text("No User Information has been found"),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}
