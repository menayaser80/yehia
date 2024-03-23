import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yehia/Screens/inner%20screen/Admin/Dashboard.dart';
import 'package:yehia/Screens/inner%20screen/medicine%20widget.dart';
import 'package:yehia/Widgets/namewidget.dart';
import 'package:yehia/Widgets/title%20widget.dart';
import 'package:yehia/constants/Appconstants.dart';
import 'package:yehia/constants/global%20method.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var emailcontroller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const AppNameTextWidget(fontSize: 20),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark
        ),
      ),
      drawer:  Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Image(
                image: AssetImage(
                  'assets/images/1.jpg',
                ),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
    ListTile(
    leading: const Icon(
    Icons.dashboard,
    color: Colors.green,
    ),
    title: const Text('Admin',style: TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
    ),),
    onTap: () {
    showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) {
    return Center(
    child: ClipRRect(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    borderRadius: BorderRadius.circular(30),
    child: Material(
    color: Colors.white.withOpacity(0.9),
    child: Container(
    height: 200,
    width: MediaQuery.of(context).size.width * 0.85,
    padding: const EdgeInsets.symmetric(
    horizontal: 20, vertical: 20),
    decoration: BoxDecoration(
    color: Colors.white.withOpacity(0.5),
    borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Form(
    key: formKey,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    SizedBox(
    width:
    MediaQuery.of(context).size.width *
    0.6,
    height: 50,
    child: TextFormField(
    controller: emailcontroller,
    obscureText: true,
    validator: (v) {
    if (v.toString() != '123') {
print("0");
    }
    },
    decoration: InputDecoration(
    prefixIcon: Icon(Icons.lock),
    fillColor: Color(0xfff0d8fa),
    filled: true,
    labelText: 'LocK',
    border: OutlineInputBorder(
    borderRadius:
    BorderRadius.circular(
    12)),
    ),
    keyboardType:
    TextInputType.emailAddress,
    onChanged: (value) {
    print(value);
    }),
    ),
    ],
    ),
    ),
      const SizedBox(
        height: 20.0,
      ),
      Center(
        child: GestureDetector(
          onTap: () async {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(20.0),
              color: const Color(0xffecf6ff),
            ),
            height: 40.0,
            width: 250.0,
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {
                    if (formKey.currentState!
                        .validate()) {
                      if(emailcontroller.text=='123')
                        {
                          navigateTo(context, DashboardScreen());
                        }
                      else
                        {
                          Fluttertoast.showToast(
                            msg: "Try Again",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey.shade600,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }

                    }
                  },
                  child: Text(
                    'Go To Dashboard',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
    ),
    ),
    ),
    ),
    );
    },
    );
    },
    ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: size.height * 0.25,
              child: ClipRRect(
                // borderRadius: BorderRadius.circular(50),
                child: Swiper(
                  autoplay: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      AppConstants.bannersImages[index],
                      fit: BoxFit.fill,
                    );
                  },
                  itemCount: AppConstants.bannersImages.length,
                  pagination: const SwiperPagination(
                    // alignment: Alignment.center,
                    builder: DotSwiperPaginationBuilder(
                        activeColor: Colors.red, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            const TitlesTextWidget(label: "Articles"),
            const SizedBox(
              height: 5.0,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (ctx, index) {
                    return ArticlesWidget();
                  }),
            ),

          ],
        ),
      ),
    );
  }
}