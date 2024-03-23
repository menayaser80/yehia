import 'package:flutter/material.dart';
import 'package:yehia/Screens/on%20boarding%20screen.dart';
import 'package:yehia/constants/global%20method.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3),(){
    navigateTo(context, Onboarding());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xF5F5F5F5),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'appLogo',
                      child: Image.asset(
                        'assets/images/RoشTaa logo 1.png',
                        width: 300,
                        height: 400,
                      ),
                    ),


                  ],
                ),
              ),
              Positioned(
                left: 0,
                child: Image.asset(
                  "assets/images/Vector2.png",
                  width: 222,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  "assets/images/Vector3.png",
                  width: 222,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
