import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swm_app/model/facts_model.dart';

class CategoryService {
  FirebaseFirestore? _instance;

  List<Facts> _categories = [];

  List<Facts> getCategories() {
    return _categories;
  }

  Future<void> getCategoriesCollectionFromFirebase() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance!.collection('awafacts');

    DocumentSnapshot snapshot = await categories.doc().get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var categoriesData = data['categories'] as List<dynamic>;
      categoriesData.forEach((catData) {
        Facts cat = Facts.fromJson(catData);
        _categories.add(cat);
      });
    }
  }
}
