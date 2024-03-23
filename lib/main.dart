import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:yehia/Screens/Splach%20screen.dart';
import 'package:yehia/Screens/inner%20screen/productdetails.dart';
import 'package:yehia/constants/theme_data.dart';
import 'package:yehia/cubit/bloc%20observer.dart';
import 'package:yehia/cubit/bloc.dart';
import 'package:yehia/cubit/cashe%20helper.dart';
import 'package:yehia/cubit/dio%20helper.dart';
import 'package:yehia/provider/chatprovider/chats_provider.dart';
import 'package:yehia/provider/homeprovider.dart';
import 'package:yehia/provider/medicineprovider.dart';
import 'package:yehia/provider/theme_provider.dart';

import 'provider/chatprovider/models_provider.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
        () async {
          await CachHelper.init();
      DioHelper.init();
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeChangeProvider = ThemeProvider();

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  //Fetch the current theme
  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
    await themeChangeProvider.darkThemePreferences.getTheme();
  }

  final Future<FirebaseApp> firebaseinitilization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebaseinitilization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          } else if (snapshot.hasError) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: Text('An Error occured'),
                ),
              ),
            );
          }

          return MultiProvider(
            providers: [
              BlocProvider(create: (BuildContext context)=>NewsCubit()..getUserData(),
              ),
              ChangeNotifierProvider(create: (_) {
                //Notify about theme changes
                return themeChangeProvider;
              }),
              ChangeNotifierProvider(create: (_) {
                return PlaceProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return Homeprovider();
              }),
              ChangeNotifierProvider(
                create: (_) => ModelsProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => ChatProvider(),
              ),

            ],
            child: Consumer<ThemeProvider>(
                builder: (context, themeChangeProvider, ch) {
                  return MaterialApp(
                    routes: {
                      ProductDetailsScreen.routName: (context) =>
                      const ProductDetailsScreen(),

                    },
                    debugShowCheckedModeBanner: false,
                    title: 'News app',
                    theme: Styles.themeData(themeChangeProvider.getDarkTheme, context),
                    home: Welcome(),

                  );
                }),
          );
        });
  }
}
