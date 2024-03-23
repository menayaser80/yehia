
import 'package:flutter/material.dart';
import 'package:yehia/Screens/inner%20screen/Admin/All%20places.dart';
import 'package:yehia/Screens/inner%20screen/Admin/add&edit%20place.dart';
import 'package:yehia/constants/global%20method.dart';
import 'package:yehia/services/chatservices/assets_manager.dart';


class DashboardButtonsModel {
  final String text, imagePath;
  final Function onPressed;

  DashboardButtonsModel({
    required this.text,
    required this.imagePath,
    required this.onPressed,
  });

  static List<DashboardButtonsModel> dashboardBtnList(context) =>
      [
        DashboardButtonsModel(
          text: "Add a new Medicine",
          imagePath: AssetsManager.cloud,
          onPressed: () {
           navigateTo(context, EditOrUploadPlaceScreen());
          },
        ),
        DashboardButtonsModel(
          text: "See all medicines",
          imagePath: AssetsManager.banner2,
          onPressed: () {
           navigateTo(context, AllplacesScreen());
          },
        ),

      ];
}
