import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:halal_food_user_app/Helpers/auth_state_handler.dart';
import 'package:halal_food_user_app/Models/user_model.dart';
import 'package:halal_food_user_app/Services/auth_services.dart';
import 'package:halal_food_user_app/Services/user_services.dart';
import 'package:halal_food_user_app/Ui/Screens/signin_screen.dart';
import 'package:halal_food_user_app/Ui/Screens/update_profile_screen.dart';
import 'package:halal_food_user_app/Ui/Widgets/button_widget.dart';
import 'package:halal_food_user_app/Utils/colors.dart';
import 'package:halal_food_user_app/Utils/res.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import 'change_password.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen(
      {Key? key,
      menuScreenContext,
      bool? hideStatus,
      Null Function()? onScreenHideButtonPressed})
      : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    UserServices userServices = UserServices();
    AuthServices authServices = AuthServices();
    return Scaffold(
      body: Container(
        child: StreamProvider.value(
            value: userServices
                .fetchUserRecord(FirebaseAuth.instance.currentUser!.uid),
            initialData: UserModel(),
            builder: (context, child) {
              UserModel model = context.watch<UserModel>();
              return Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Manage",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 20)),
                        IconButton(
                            onPressed: () {
                              UserLoginStateHandler
                                      .saveUserLoggedInSharedPreference(false)
                                  .whenComplete(() {
                                Fluttertoast.showToast(
                                    msg: "LogOut SuccessFully");
                              });
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInScreen()));
                            },
                            icon: Icon(
                              Icons.logout,
                              color: MyAppColors.redcolor,
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text("Your Account",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 20)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Stack(
                    children: [
                      model.userImage == null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(Res.personicons),
                            )
                          : CachedNetworkImage(
                              height: 100,
                              width: 100,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                    width: 80.0,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                              imageUrl: model.userImage.toString(),
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      SpinKitWave(
                                          color: MyAppColors.redcolor,
                                          type: SpinKitWaveType.start),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        model.fullName != null
                            ? Text(model.fullName.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15))
                            : Text("Null"),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateProfileScreen(
                                            model.docId.toString(),
                                            model.fullName.toString(),
                                            model.userImage.toString(),
                                          )));
                            },
                            child: Image.asset(Res.edit))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Personal details",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15)),
                        InkWell(
                          onTap: () {
                            pushNewScreen(context,
                                withNavBar: false,
                                screen: ChangeAccountPassword());
                          },
                          child: Text("Change Password",
                              style: TextStyle(
                                  color: MyAppColors.redcolor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(9)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 13),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Account",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                                Text(model.userEmail.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
