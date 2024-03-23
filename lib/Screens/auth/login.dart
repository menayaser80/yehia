import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:yehia/Screens/bottom_bar.dart';
import 'package:yehia/Screens/auth/Register.dart';
import 'package:yehia/Screens/auth/forget%20password.dart';
import 'package:yehia/Widgets/Auth%20btn.dart';
import 'package:yehia/Widgets/text_widget.dart';
import 'package:yehia/constants/firebase%20constants.dart';
import 'package:yehia/constants/global%20method.dart';
class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailTextController = TextEditingController();
  final passTextController = TextEditingController();
  final passFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  var obscureText = true;
  @override
  void dispose() {
    emailTextController.dispose();
    passTextController.dispose();
    passFocusNode.dispose();
    super.dispose();
  }
  bool _isLoading = false;
  void submitFormOnLogin() async {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      formKey.currentState!.save();
      setState(() {
        _isLoading=true;
      });
      try
      {
        await authInstance.signInWithEmailAndPassword(
            email:emailTextController.text.toLowerCase().trim() ,
            password:passTextController.text.trim());
        navigateTo(context, BottomBarScreen());
        print('succesfully logged in');
      }
      on FirebaseException catch(error)
      {
        errorDialog(
          subtitle:'${error.message}' ,
          context:context,
        );
        setState(() {
          _isLoading=false;
        });
      } catch(error)
      {
        errorDialog(
          subtitle:'$error' ,
          context:context,
        );
        setState(() {
          _isLoading=false;
        });
      }finally{
        setState(() {
          _isLoading=false;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [

              Center(
                child: Image.asset(
                  "assets/images/RoشTaa logo 1.png",
                  width: 300,
                  height: 200,
                ),
              ),

              Form(
                  key: formKey,
                  child:Column(
                    children: [
                      Container(
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color(0xFFD9D9D9),
                        ),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete:()=>FocusScope.of(context).requestFocus(passFocusNode),
                          controller: emailTextController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if(value!.isEmpty || !value.contains('@')){
                              return 'Please enter a valid email address';
                            }else
                              {
                                return null;
                              }
                          },
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle:TextStyle(
                              color: Color(0xFF7441F2),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color(0xFFD9D9D9),
                        ),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          onEditingComplete:(){
                            submitFormOnLogin();
                          },
                          controller: passTextController,
                          focusNode: passFocusNode,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscureText,
                          validator: (value){
                            if(value!.isEmpty || value.length<7){
                              return 'Please enter a valid Password';
                            }else
                            {
                              return null;
                            }
                          },
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration:  InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: (){
                                setState(() {
                                  obscureText=!obscureText;
                                });
                              },
                              child: Icon(
                                obscureText?
                                Icons.visibility:Icons.visibility_off,
                                color: Colors.black,
                              ),
                            ),
                            labelText: 'Password',
                            labelStyle:TextStyle(
                              color: Color(0xFF7441F2),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(onPressed: (){
                  navigateTo(context,ForgetPasswordScreen());
                }, child: Text(
                  'Forget password?',
                  maxLines: 1,
                    style: TextStyle(

                        color: Color(0xFF7441F2),
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                      fontStyle: FontStyle.italic,
                    ),
                ),),
              ),
              SizedBox(
                height: 10,
              ),
              AuthButton(
                fct: (){
      submitFormOnLogin();
                },
                buttonText: 'Login',
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Textwidget(text: 'OR', color:Colors.black, textsize: 18),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              AuthButton(fct: (){
                navigateTo(context, BottomBarScreen());
              }, buttonText: 'Continue as a Guest',
              primary: Colors.black,),
              SizedBox(
                height: 10,
              ),
              RichText(
                  text:TextSpan(
                    text: 'Don\'t have an account?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    children: [
                     TextSpan(
                       text: '   Sign up',
                       style: TextStyle(
                         color: Color(0xFF7441F2),
                         fontSize: 18,
                         fontWeight: FontWeight.w600,
                       ),
                       recognizer: TapGestureRecognizer()..onTap=(){
      navigateTo(context, RegisterScreen());
                       },
                     ),
                    ]
                  ), ),
            ],
          ),
        ),
      ),
    );
  }
}
