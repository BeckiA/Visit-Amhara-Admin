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
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            tileColor: Colors.blue.withOpacity(0.1),
                            leading: Icon(LineAwesomeIcons.user_1,
                                color: Colors.blue),
                            title:
                                Text("Name: ${snapshot.data![index].fullName}"),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data![index].phoneNo),
                                Text(snapshot.data![index].email),
                              ],
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 1.0,
                            indent: 10.0,
                            endIndent: 10.0,
                          ),
                        ],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "An error occurred while loading user information. Please try again later.",
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LineAwesomeIcons.user_tie,
                          size: 48.0,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          "No User Information has been found",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
