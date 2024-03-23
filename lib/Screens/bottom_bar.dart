import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:provider/provider.dart';
import 'package:yehia/Screens/chat_screen.dart';
import 'package:yehia/Screens/inner%20screen/Album.dart';
import 'package:yehia/Screens/inner%20screen/Home_screen.dart';
import 'package:yehia/Screens/inner%20screen/searchscreen.dart';
import 'package:yehia/Screens/inner%20screen/user.dart';
import 'package:yehia/Screens/pick%20product.dart';
import 'package:yehia/provider/theme_provider.dart';
class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
int Selectedindex=0;
final  List<Map<String,dynamic>> pages=[
  {
    'page':const HomeScreen(),
    'title':'Home Screen'
  },
  {
    'page':const Searchscreen(),
    'title':'Searchscreen'
  },
  {
    'page': pick_product(),
    'title':'Category Screen',
  },
  {
    'page': Photobook(),
    'title':'Category Screen',
  },

  {
    'page': ChatScreen(),
    'title':'ChatGpt',
  },
  {
    'page': SettingScreen(),
    'title':'User Screen',
  },
];
void Selectedpage(int index){
setState(() {
  Selectedindex=index;
});
}
  @override
  Widget build(BuildContext context) {
    final themeState=Provider.of<ThemeProvider>(context);

    bool isdark= themeState.getDarkTheme;
    return Scaffold(

        body:pages[Selectedindex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor:isdark
         ? Theme.of(context).cardColor
              :Colors.white,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: Selectedindex,
          unselectedItemColor:isdark?Colors.white10:Colors.black12,
          selectedItemColor:isdark?Colors.lightBlue.shade200:Colors.black87,
          onTap: Selectedpage,
            items:<BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(
             Selectedindex==0?IconlyBold.home: IconlyLight.home,
              ),
                label: 'Home',
              ),
              BottomNavigationBarItem(icon: Icon(
                Selectedindex==1?IconlyBold.search: IconlyLight.search,
              ),
                label: 'search',
              ),
              BottomNavigationBarItem(icon:
              Icon(
                  Selectedindex==2?IconlyBold.notification: IconlyLight.notification,
                ),

                label: 'Weather',
              ),
              BottomNavigationBarItem(icon:
              Icon(
                Selectedindex==3?IconlyBold.image: IconlyLight.image,
              ),

                label: 'image',
              ),
              BottomNavigationBarItem(icon:
              Icon(
                Selectedindex==4?IconlyBold.chat: IconlyLight.chat,
              ),

                label: 'ChatGpt',
              ),
              BottomNavigationBarItem(icon: Icon(
                Selectedindex==5?IconlyBold.user2:IconlyLight.user2,
              ),
                label: 'User Screen',
              ),
            ],
        ),
      );

  }
}
