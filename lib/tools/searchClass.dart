import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Sale_App/tools/app_data.dart';

class BTSSearch {
  searchByName(String searchField) {
    return Firestore.instance
        .collection(appProducts)
        .where("searchKey",
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }

  
}
