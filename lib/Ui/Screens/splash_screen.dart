import 'package:flutter/material.dart';
import 'package:halal_food_user_app/Ui/Screens/signin_screen.dart';
import 'package:halal_food_user_app/Ui/Widgets/button_widget.dart';
import 'package:halal_food_user_app/Utils/colors.dart';
import 'package:halal_food_user_app/Utils/res.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 140,
          width: 170,
          decoration: BoxDecoration(),
          child: Center(
            child: Image.asset(
              Res.logo,
              height: 180,
              width: 180,
            ),
          ),
        ),
        SizedBox(
          height: 100,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: buttonWidget(
              text: "Get Started",
              showborder: false,
              buttonwidth: double.infinity,
              bacgroundcolor: MyAppColors.redcolor,
              textColor: MyAppColors.whitecolor,
              onTap: () {
                Navigator.pushReplacement(
                             context, MaterialPageRoute(builder: (context) => SignInScreen()));
              }),
        )
      ],
    ));
  }
}
