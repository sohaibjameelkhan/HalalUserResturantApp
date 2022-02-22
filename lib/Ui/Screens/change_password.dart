import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:halal_food_user_app/Helpers/botttom_navigation.dart';
import 'package:halal_food_user_app/Services/auth_services.dart';
import 'package:halal_food_user_app/Ui/Screens/signin_screen.dart';
import 'package:halal_food_user_app/Ui/Screens/signup_screen.dart';
import 'package:halal_food_user_app/Ui/Widgets/auth_textfield_widget.dart';
import 'package:halal_food_user_app/Ui/Widgets/button_widget.dart';
import 'package:halal_food_user_app/Ui/Widgets/heding_text_widgets.dart';
import 'package:halal_food_user_app/Utils/colors.dart';
import 'package:halal_food_user_app/Utils/res.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'home_screen.dart';

class ChangeAccountPassword extends StatefulWidget {
  const ChangeAccountPassword({Key? key}) : super(key: key);

  @override
  _ChangeAccountPasswordState createState() => _ChangeAccountPasswordState();
}

class _ChangeAccountPasswordState extends State<ChangeAccountPassword> {
  AuthServices authServices = AuthServices();
  TextEditingController _oldPassword = TextEditingController();
  TextEditingController _newPasswordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final spinkit = SpinKitWave(
    color: Colors.white,
    size: 50.0,
  );
  bool isLoadingspin = true;
  final currentuser = FirebaseAuth.instance.currentUser;

  void dispose() {
    _newPasswordcontroller.dispose();
  }

  var newPassword = "";

  changePassword() async {
    try {
      await currentuser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      pushNewScreen(context, withNavBar: false, screen: SignInScreen());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("Your Password has been changed sucessfully Login Again")));
    } catch (error) {}
  }

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LoadingOverlay(
          isLoading: isLoading,
          progressIndicator: SpinKitWave(color: MyAppColors.redcolor),
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            }, icon: Icon(Icons.arrow_back))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text("Change account",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 20)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text("Password",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 20)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: authtextfieldWidget(
                        headingtext: "New Password",
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
                        authcontroller: _newPasswordcontroller,
                        showImage: true,
                        showsuffix: true,
                        suffixImage: Res.personicon,
                        text: "Enter Your New  Password",
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please Enter more than 6 digit password";
                          } else if (value.length < 6)
                            return "Please Enter atleast 6 password";
                          return null;
                        }),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 360,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: buttonWidget(
                        text: "Save New Password",
                        showborder: false,
                        buttonwidth: double.infinity,
                        bacgroundcolor: MyAppColors.redcolor,
                        textColor: MyAppColors.whitecolor,
                        onTap: () {
                          setState(() {
                            newPassword = _newPasswordcontroller.text;
                          });
                          changePassword();
                          // _updatePassword();
                        }),
                  ),
                ],
              ),
            ),
          )),
    );
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

  _updatePassword() {
    makeLoadingTrue();
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? currentUser = firebaseAuth.currentUser;
    currentUser!.updatePassword(_oldPassword.text).then((value) {
      FirebaseFirestore.instance
          .collection("userCollection")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({'password': _newPasswordcontroller.text},
              SetOptions(merge: true)).whenComplete(() {
        makeLoadingFalse();
        Fluttertoast.showToast(msg: "Password Updated");
        setState(() {
          _oldPassword.clear();
          _newPasswordcontroller.clear();
        });
      });
    });
  }
}
