import 'package:get/get.dart';
import 'package:visit_amhara_admin_app/controllers/firestore_queries/attraction_queries.dart';

import 'attraction.dart';

class EditAttractionController extends GetxController {
  static EditAttractionController get instance => Get.find();
  final _attractQuery = Get.put(AttractionQuery());
  getAttractionData() {
    // final attractionId =
  }
  Future<List<Attraction>> getAllAttractions() async {
    return await _attractQuery.allAttractionData();
  }
}
