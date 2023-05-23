import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:visit_amhara_admin_app/controllers/attraction.dart';
import 'package:visit_amhara_admin_app/controllers/firestore_queries/attraction_queries.dart';

import '../constants/colors.dart';
import '../controllers/edit_attraction_controllers.dart';

class ViewAttraction extends StatelessWidget {
  final AttractionQuery attractionQuery = Get.put(AttractionQuery());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attraction Items"),
      ),
      body: FutureBuilder<List<Attraction>>(
        future: attractionQuery.allAttractionData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No attractions found"),
            );
          } else {
            final attractions = snapshot.data!;
            return ListView.builder(
              itemCount: attractions.length,
              itemBuilder: (context, index) {
                final attraction = attractions[index];
                return ListTile(
                  leading: Image.network(attraction.picture),
                  title: Text(attraction.title),
                  subtitle: Text(attraction.location),
                  onTap: () {
                    // Handle attraction item tap
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
