import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:halal_food_user_app/Helpers/auth_state_handler.dart';
import 'package:halal_food_user_app/Helpers/botttom_navigation.dart';
import 'package:halal_food_user_app/Models/user_model.dart';
import 'package:halal_food_user_app/Services/auth_services.dart';
import 'package:halal_food_user_app/Ui/Screens/fogot_password.dart';
import 'package:halal_food_user_app/Ui/Screens/signup_screen.dart';
import 'package:halal_food_user_app/Ui/Widgets/auth_textfield_widget.dart';
import 'package:halal_food_user_app/Ui/Widgets/button_widget.dart';
import 'package:halal_food_user_app/Ui/Widgets/heding_text_widgets.dart';
import 'package:halal_food_user_app/Utils/colors.dart';
import 'package:halal_food_user_app/Utils/res.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  AuthServices authServices = AuthServices();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final spinkit = SpinKitWave(
    color: Colors.white,
    size: 50.0,
  );
  bool isLoadingspin = true;

  bool isLoading = false;

  makeLoadingTrue() {
    isLoading = true;
    setState(() {});
  }

  makeLoadingFalse() {
    isLoading = false;
    setState(() {});
  }

  bool isvisible = false;
  bool isvisible1 = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: LoadingOverlay(
      isLoading: isLoading,
      progressIndicator: SpinKitWave(color: MyAppColors.redcolor),
      child: Scaffold(
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Row(
                  children: [
                    Text(
                      "i don't have an account",
                      style: TextStyle(
                          color: MyAppColors.blackcolor,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                            color: MyAppColors.redcolor,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back))
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [Image.asset(Res.restaurant)],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    HeadingTextWidget(
                      headingtext: 'Sign In',
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Text(
                      "Welcome to halal market & butchers",
                      style: TextStyle(
                          color: MyAppColors.blackcolor.withOpacity(0.6),
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Text(
                      "Login to continue",
                      style: TextStyle(
                          color: MyAppColors.blackcolor.withOpacity(0.6),
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: authtextfieldWidget(
                        headingtext: "Email",
                        onPwdTap: () {
                          setState(() {
                            isvisible = !isvisible;
                          });
                        },
                        visible: isvisible,
                        isPasswordField: false,
                        suffixIcon2: Icons.visibility_off,
                        suffixIcon: Icons.remove_red_eye_sharp,
                        maxlength: 20,
                        keyboardtype: TextInputType.emailAddress,
                        authcontroller: _emailController,
                        showImage: false,
                        showsuffix: false,
                        suffixImage: Res.personicon,
                        text: "Enter Your Email",
                        validator: (value) {
                          if (value.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return "Please Enter Valid Email Address";
                          } else if (value.length <= 2)
                            return "Please Enter more than 2 words";
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: authtextfieldWidget(
                          headingtext: "Password",
                          onPwdTap: () {
                            setState(() {
                              isvisible1 = !isvisible1;
                            });
                          },
                          visible: isvisible1,
                          isPasswordField: true,
                          suffixIcon2: Icons.visibility_off,
                          suffixIcon: Icons.remove_red_eye_sharp,
                          maxlength: 20,
                          keyboardtype: TextInputType.number,
                          authcontroller: _passwordController,
                          showImage: true,
                          showsuffix: true,
                          suffixImage: Res.personicon,
                          text: "Enter Your Password",
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Please Enter more than 6 digit password";
                            } else if (value.length < 6)
                              return "Please Enter atleast 6 password";
                            return null;
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: MyAppColors.blackcolor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));

                            // );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: buttonWidget(
                          text: "Sign in",
                          showborder: false,
                          buttonwidth: double.infinity,
                          bacgroundcolor: MyAppColors.redcolor,
                          textColor: MyAppColors.whitecolor,
                          onTap: () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            _loginUser(context);
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ]),
          )),
    ));
  }

  _loginUser(BuildContext context) async {
    makeLoadingTrue();

    try {
      ///This will allow user to register in firebase
      return await authServices
          .loginUser(
              email: _emailController.text, password: _passwordController.text)
          .whenComplete(() => makeLoadingFalse())
          .then((value) async {
        // FirebaseAuth firebaseAuth = FirebaseAuth.instance;

        //   FirebaseAuth.instance.currentUser.uid.c;
        authServices
            .checkIfUserAllowed(value.uid.toString())
            .first
            .then((value) async {
          await UserLoginStateHandler.saveUserLoggedInSharedPreference(true);

          if (value.isapprove == true) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Bottomnavigation()));
            Fluttertoast.showToast(msg: "Login Successfully");
          } else {
            return showDialog<void>(
              context: context,
              barrierDismissible: false,
              // false = user must tap button, true = tap outside dialog
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  title: Text('ALert!'),
                  content: Text("You Are Blocked"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Okay'),
                      onPressed: () {
                        makeLoadingFalse();
                        Navigator.of(dialogContext)
                            .pop(); // Dismiss alert dialog
                      },
                    ),
                  ],
                );
              },
            );
          }
        });
        // await UserLoginStateHandler.saveUserLoggedInSharedPreference(true);
      });
    } on FirebaseAuthException catch (e) {
      makeLoadingFalse();
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        // false = user must tap button, true = tap outside dialog
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('ALert!'),
            content: Text(e.message.toString()),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  makeLoadingFalse();
                  Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                },
              ),
            ],
          );
        },
      );
    }
  }

  void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        //message to show toast
        toastLength: Toast.LENGTH_LONG,
        //duration for message to show
        gravity: ToastGravity.CENTER,
        //where you want to show, top, bottom
        timeInSecForIosWeb: 1,
        //for iOS only
        //backgroundColor: Colors.red, //background Color for message
        textColor: Colors.red,
        //message text color
        fontSize: 16.0 //message font size
        );
  }
}
