import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yehia/model/medicine%20model.dart';



class Homeprovider with ChangeNotifier {
  List<Placemodel> products = [];

  List<Placemodel> get getProducts {
    return products;
  }

  Placemodel? findByProdId(String productId) {
    if (products
        .where((element) => element.PlaceId == productId)
        .isEmpty) {
      return null;
    }
    return products.firstWhere((element) => element.PlaceId == productId);
  }

  List<Placemodel> searchQuery(
      {required String searchText, required List<Placemodel> passedList}) {
    List<Placemodel> searchList = passedList
        .where(
          (element) =>
          element.name.toLowerCase().contains(
            searchText.toLowerCase(),
          ),
    )
        .toList();
    return searchList;
  }

  final productDb = FirebaseFirestore.instance.collection("Medicine");

  Future<List<Placemodel>> fetchProducts() async {
    try {
      await productDb.get().then((productSnapshot) {
        products.clear();
        // products = []
        for (var element in productSnapshot.docs) {
          products.insert(0, Placemodel.fromFirestore(element));
        }
      });
      notifyListeners();
      return products;
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<Placemodel>> fetchProductsStream() {
    try {
      return productDb.snapshots().map((snapshot) {
        products.clear();
        // products = []
        for (var element in snapshot.docs) {
          products.insert(0, Placemodel.fromFirestore(element));
        }
        return products;
      });
    } catch (e) {
      rethrow;
    }
  }
}