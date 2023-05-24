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
                return Card(
                  child: Row(children: [
                    Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      width: 140,
                      height: 140,
                      child: Image.network(
                        attraction.picture,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                attraction.title,
                                style: const TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(LineAwesomeIcons.map_marker),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    attraction.location,
                                    style: const TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                      LineAwesomeIcons.identification_badge),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    attraction.categoryId,
                                    style: const TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Latitude:",
                                    style: TextStyle(
                                        fontFamily: "Montserrat", fontSize: 14),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    attraction.latitude.toString(),
                                    style: const TextStyle(
                                        fontFamily: "Montserrat", fontSize: 14),
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Longitiude:",
                                    style: TextStyle(
                                        fontFamily: "Montserrat", fontSize: 14),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    attraction.longitiude.toString(),
                                    style: const TextStyle(
                                        fontFamily: "Montserrat", fontSize: 14),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.toNamed('/edit-attraction',
                                arguments: {"id": attraction.id});
                          },
                          icon: const Icon(
                            LineAwesomeIcons.edit,
                            size: 35,
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              LineAwesomeIcons.trash,
                              size: 35,
                              color: Colors.redAccent,
                            ))
                      ],
                    ),
                  ]),
                );
              },
            );
          }
        },
      ),
    );
  }
}
