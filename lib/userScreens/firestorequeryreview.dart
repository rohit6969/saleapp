import 'package:Sale_App/tools/app_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewService {
  getLatestReview() {
    return Firestore.instance.collection("appProducts").document("Car").snapshots();
  }

  getData() {
    return Firestore.instance.collection('appProducts').getDocuments();
  }
}
