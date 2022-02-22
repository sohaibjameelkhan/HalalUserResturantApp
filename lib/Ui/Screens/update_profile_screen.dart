import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:halal_food_user_app/Models/user_model.dart';
import 'package:halal_food_user_app/Services/user_services.dart';
import 'package:halal_food_user_app/Ui/Screens/profile_screen.dart';
import 'package:halal_food_user_app/Ui/Widgets/button_widget.dart';
import 'package:halal_food_user_app/Ui/Widgets/profile_textfield_widget.dart';
import 'package:halal_food_user_app/Utils/colors.dart';
import 'package:halal_food_user_app/Utils/res.dart';

import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';

class UpdateProfileScreen extends StatefulWidget {
  final String docID;
  final String fullName;
  final String userimage;

  UpdateProfileScreen(
    this.docID,
    this.fullName,
    this.userimage,
  );

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<UpdateProfileScreen> {
  UserServices userServices = UserServices();
  TextEditingController firstNameController = TextEditingController();

  TextEditingController contactNumberController = TextEditingController();
  File? _image;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  makeLoadingTrue() {
    isLoading = true;
    setState(() {});
  }

  makeLoadingFalse() {
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    ///We have to populate our text editing controllers with speicifid product details
    firstNameController = TextEditingController(text: widget.fullName);

    //contactNumberController = TextEditingController(text: widget.userimage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _getUI(context),
      ),
    );
  }

  Widget _getUI(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      progressIndicator: SpinKitWave(color: MyAppColors.redcolor),
      child: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(Res.profilebac)
        //   )
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 36,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text("Update Profile",
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
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 3, color: MyAppColors.redcolor),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: _image == null
                                ? AssetImage(
                                    Res.personicons,
                                  )
                                : FileImage(_image!) as ImageProvider)),
                    height: 120,
                    width: 120,
                    // child: _image == null
                    //     ? Image.asset(Res.profileavatar)
                    //     : Image.file(_image!,fit: BoxFit.cover,),
                  ),
                  Positioned.fill(
                    top: -50,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 40,
                        width: 40,
                        child: IconButton(
                          icon: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                            size: 19,
                          ),
                          onPressed: () {
                            getImage(true);
                          },
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyAppColors.redcolor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    ProfileTextFieldWidget(
                      maxlength: 20,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please Enter Full Name";
                        }
                        return null;
                      },
                      controller: firstNameController,
                      textfieldheight: 70,
                      textfieldwidth: 300,
                      text: "Enter Your Full Name",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              buttonWidget(
                text: "Save",
                onTap: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  // showDialog(
                  //     context: context,
                  //     barrierDismissible: false,
                  //     builder: (BuildContext context) {
                  //     //   return SpinKitWave(
                  //     //       color: Colors.blue, type: SpinKitWaveType.start);
                  //     // });
                  makeLoadingTrue();
                  _image == null
                      ?
                      //getUrl(context, file: _image).then((imgUrl) {
                      userServices
                          .updateUserDetailsWithoutImage(UserModel(
                            userID: widget.docID,
                            fullName: firstNameController.text,
                            // userNumber: contactNumberController.text,
                            // userImage: imgUrl,
                          ))
                          .whenComplete(() => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileScreen())))
                      : getUrl(context, file: _image).then((imgUrl) {
                          userServices.updateUserDetailswithImage(UserModel(
                            userID: widget.docID,
                            fullName: firstNameController.text,
                            userImage: imgUrl,
                          ));
                          makeLoadingFalse().whenComplete(() =>
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileScreen())));
                        });
                },
                showborder: false,
                textColor: Colors.white,
                bacgroundcolor: MyAppColors.redcolor,
                buttonwidth: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getUrl(BuildContext context, {File? file}) async {
    String postFileUrl = "";
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('backendClass/${file!.path.split('/').last}');
      UploadTask uploadTask = storageReference.putFile(file);

      await uploadTask.whenComplete(() async {
        await storageReference.getDownloadURL().then((fileURL) {
          print("I am fileUrl $fileURL");
          postFileUrl = fileURL;
        });
      });
    } catch (e) {
      rethrow;
    }

    return postFileUrl.toString();
  }

  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    PickedFile? pickedFile;
    // Let user select photo from gallery
    if (gallery) {
      pickedFile = await picker.getImage(
        source: ImageSource.gallery,
      );
    }
    // Otherwise open camera to get new photo
    else {
      pickedFile = await picker.getImage(
        source: ImageSource.camera,
      );
    }

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
