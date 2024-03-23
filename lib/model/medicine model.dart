import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Placemodel with ChangeNotifier {
  final String PlaceId,
      name,
      activeingredient,
      diagnosis,
      sideeffects,
      PlaceImage;
      Timestamp? createdAt;
  Placemodel({
    required this.PlaceId,
    required this.name,
    required this.activeingredient,
    required this.diagnosis,
    required this.sideeffects,
    required this.PlaceImage,
    this.createdAt,
  });

  factory Placemodel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Placemodel(
      PlaceId: data["MedicineId"], //doc.get(field),
      name: data['medicine Title'],
      activeingredient: data['active ingredient'],
      diagnosis: data['diagnosis'],
      sideeffects: data['side effects'],
      PlaceImage: data['MedicineImage']??"https://www.shutterstock.com/image-vector/medicine-pharmacy-hospital-set-drugs-labels-646593400",
      createdAt: data['createdAt'],
    );
  }
}

//