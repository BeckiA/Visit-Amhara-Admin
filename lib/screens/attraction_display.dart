import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:visit_amhara_admin_app/constants/colors.dart';
import 'package:visit_amhara_admin_app/screens/upload_attractions.dart';
import 'package:visit_amhara_admin_app/screens/view_attractions.dart';

class AttractionDisplay extends StatelessWidget {
  const AttractionDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Get.off(UploadAttractions());
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              width: 400,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    LineAwesomeIcons.plus_circle,
                    size: 80,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "ADD ATTRACTIONS",
                    style: Theme.of(context).textTheme.displayMedium,
                  )
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(ViewAttraction());
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              width: 400,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    LineAwesomeIcons.eye,
                    size: 80,
                  ),
                  Text(
                    "VIEW ATTRACTIONS",
                    style: Theme.of(context).textTheme.displayMedium,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
