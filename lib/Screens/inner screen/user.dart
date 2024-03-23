import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yehia/Screens/auth/login.dart';
import 'package:yehia/Screens/inner%20screen/Edit%20profile.dart';
import 'package:yehia/Widgets/text_widget.dart';
import 'package:yehia/constants/firebase%20constants.dart';
import 'package:yehia/constants/global%20method.dart';

import 'package:yehia/cubit/bloc.dart';
import 'package:yehia/cubit/states.dart';
import 'package:yehia/provider/theme_provider.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final User? user=authInstance.currentUser;
  @override
  Widget build(BuildContext context) {
    final themeState=Provider.of<ThemeProvider>(context);
    final Color color=themeState.getDarkTheme?Colors.white:Colors.black;
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state){} ,
      builder: (context,state){
        var usermodel=NewsCubit.get(context).usermodel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child:usermodel!=null? Column(
            children: [
              Container(
                height: 190.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      child: Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0,),
                            topRight: Radius.circular(4.0,),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                                '${usermodel!.cover}'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      alignment: AlignmentDirectional.topCenter,
                    ),
                    CircleAvatar(
                      radius: 64.0,
                      backgroundColor:Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage('${usermodel.image}'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '${usermodel.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                '${usermodel.bio}',
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                '${usermodel.shopping_address}',
                style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.grey),

              ),
              Text(
                '${usermodel.phone}',
                style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40.0,
                        width: double.infinity,
                        color: Colors.white,
                        child: OutlinedButton(
                          onPressed: ()async{
                            await launchUrl(Uri.parse("tel:+201095011004"));
                          },
                          child:Row(
                            children: [
                              Icon(Icons.phone_callback_outlined,color: Colors.blue,),
                              SizedBox(width: 5,),
                              Text("Contact us",style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),),
                            ],

                          ),
                        ),

                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    OutlinedButton(
                      onPressed: (){
                        navigateTo(context, EditProfile());
                      },
                      child:Icon(
                        IconlyLight.edit,
                        size: 16.0,
                      ),

                    ),
                  ],
                ),
              ),
              SwitchListTile(
                title:Textwidget(
                  text:themeState.getDarkTheme?'DarkMode':'LightMode',
                  color: color,
                  textsize: 18.0,
                ),
                secondary: Icon(
                    themeState.getDarkTheme?Icons.dark_mode_outlined
                        :Icons.light_mode_outlined),
                value:themeState.getDarkTheme ,
                onChanged: (bool value){
                  setState(() {
                    themeState.setDarkTheme=value;
                  });
                },
              ),
              listtile(
                  title:user==null?'Login':'LogOut',
                  icon:user==null?IconlyLight.login:IconlyLight.logout,
                  color: color,
                  onpressed: (){
                    if(user==null)
                    {
                      navigateTo(context, LoginScreen());
                      return;
                    }
                    warningDialog(title: 'Sign out', subtitle: 'Do you want sign out?', fct:()async{
                      await authInstance.signOut();
                      navigateTo(context, LoginScreen());
                    }, context: context);
                  }
              ),
            ],
          ):SizedBox(),
        );
      },
    );
  }
}