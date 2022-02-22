import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:halal_food_user_app/Services/auth_services.dart';
import 'package:halal_food_user_app/Ui/Screens/signin_screen.dart';
import 'package:halal_food_user_app/Ui/Widgets/button_widget.dart';
import 'package:halal_food_user_app/Ui/Widgets/profile_textfield_widget.dart';
import 'package:halal_food_user_app/Utils/colors.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  AuthServices authServices = AuthServices();
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 90,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(17),
                    bottomLeft: Radius.circular(17)),
                color: MyAppColors.redcolor),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 60,
                ),
                Text("Forgot Password",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 19)),
              ],
            ),
          ),
          SizedBox(
            height: 70,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Enter Your Email to Reset Password",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 17)),
            ],
          ),
          SizedBox(
            height: 80,
          ),
          ProfileTextFieldWidget(
            maxlength: 40,
            controller: _controller,
            text: "Enter Your Email",
            textfieldheight: 55,
            textfieldwidth: 300,
            validator: (value) {
              if (value.isEmpty ||
                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                return "";
              } else if (value.length <= 2) return "";
              return null;
            },
          ),
          SizedBox(
            height: 80,
          ),
          buttonWidget(
              text: "Send Link",
              showborder: false,
              buttonwidth: 200,
              bacgroundcolor: MyAppColors.redcolor,
              textColor: Colors.white,
              onTap: () {
                authServices
                    .resetPassword(email: _controller.text)
                    .whenComplete(() =>
                        Fluttertoast.showToast(msg: "Email Send SuccessFully"));
              })
        ],
      ),
    );
  }
}
