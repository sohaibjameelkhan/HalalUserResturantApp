import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:halal_food_user_app/Helpers/botttom_navigation.dart';
import 'package:halal_food_user_app/Helpers/helper.dart';
import 'package:halal_food_user_app/Models/user_model.dart';
import 'package:halal_food_user_app/Services/auth_services.dart';
import 'package:halal_food_user_app/Services/user_services.dart';
import 'package:halal_food_user_app/Ui/Screens/home_screen.dart';
import 'package:halal_food_user_app/Ui/Screens/signin_screen.dart';
import 'package:halal_food_user_app/Ui/Widgets/auth_textfield_widget.dart';
import 'package:halal_food_user_app/Ui/Widgets/button_widget.dart';
import 'package:halal_food_user_app/Ui/Widgets/heding_text_widgets.dart';
import 'package:halal_food_user_app/Utils/colors.dart';
import 'package:halal_food_user_app/Utils/res.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthServices authServices = AuthServices();
  UserServices userServices = UserServices();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  final spinkit = SpinKitWave(
    color: Colors.white,
    size: 50.0,
  );
  bool isLoadingspin = true;

  makeLoadingTrue() {
    isLoading = true;
    setState(() {});
  }

  makeLoadingFalse() {
    isLoading = false;
    setState(() {});
  }

  bool isvisible = false;

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
                      "Already have an account?",
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
                                builder: (context) => SignInScreen()));
                      },
                      child: Text(
                        "SignIn",
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
                      headingtext: 'Sign Up',
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
                      "Create account to continue",
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
                        headingtext: "Full Name",
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
                        keyboardtype: TextInputType.text,
                        authcontroller: _fullNameController,
                        showImage: false,
                        showsuffix: false,
                        suffixImage: Res.personicon,
                        text: "Enter Your Full Name",
                        validator: (value) {
                          if (value.isEmpty) {
                            return "please enter your name ";
                          }
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
                        showImage: true,
                        showsuffix: true,
                        suffixImage: Res.personicon,
                        text: "Enter Your Email",
                        validator: (value) {
                          if (value.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return "please enter your valid email";
                          } else if (value.length <= 2) return "";
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
                              isvisible = !isvisible;
                            });
                          },
                          visible: isvisible,
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
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: buttonWidget(
                          text: "Sign Up",
                          showborder: false,
                          buttonwidth: double.infinity,
                          bacgroundcolor: MyAppColors.redcolor,
                          textColor: MyAppColors.whitecolor,
                          onTap: () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            _signUpUser(context);
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

  _signUpUser(BuildContext context) async {
    makeLoadingTrue();

    try {
      ///This will allow user to register in firebase
      return await authServices
          .registerUser(
              email: _emailController.text, password: _passwordController.text)
          .then((value) {
        userServices.createUser(UserModel(
            fullName: _fullNameController.text,
            userEmail: _emailController.text,
            isapprove: false,
            password: _passwordController.text,
            userID: getUserID()));
        makeLoadingFalse();
      }).then((value) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Bottomnavigation()));
        return Fluttertoast.showToast(msg: "Registered SucessFully");
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
}
