
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yehia/Screens/inner%20screen/Admin/dashboard_btns.dart';
import 'package:yehia/Screens/inner%20screen/Admin/dashname.dart';
import 'package:yehia/Screens/inner%20screen/Admin/modeldash.dart';
import 'package:yehia/provider/theme_provider.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const DashNameTextWidget(fontSize: 20),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark
          ),


        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            DashboardButtonsModel.dashboardBtnList(context).length,
                (index) => DashboardButtonsWidget(
              text: DashboardButtonsModel.dashboardBtnList(context)[index].text,
              imagePath: DashboardButtonsModel.dashboardBtnList(context)[index]
                  .imagePath,
              onPressed: DashboardButtonsModel.dashboardBtnList(context)[index]
                  .onPressed,
            ),
          ),
        ));
  }
}