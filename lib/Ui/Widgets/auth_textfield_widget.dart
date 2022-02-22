import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halal_food_user_app/Utils/colors.dart';

class authtextfieldWidget extends StatefulWidget {
  final headingtext;
  final int maxlength;
  final TextEditingController authcontroller;
  final TextInputType keyboardtype;
  final String text;
  final String suffixImage;
  final bool showImage;
  final bool showsuffix;
  final IconData suffixIcon;
  final IconData suffixIcon2;
  final Function(String) validator;
  final VoidCallback onPwdTap;
  final bool isPasswordField;
  final bool visible;

  //final bool showSuffix;
  authtextfieldWidget(
      {this.headingtext,
      this.visible = false,
      this.isPasswordField = false,
      required this.suffixIcon2,
      required this.maxlength,
      required this.authcontroller,
      required this.keyboardtype,
      required this.text,
      required this.suffixImage,
      required this.showsuffix,
      required this.showImage,
      required this.validator,
      required this.suffixIcon,
      required this.onPwdTap});

  @override
  _authtextfieldWidgetState createState() => _authtextfieldWidgetState();
}

class _authtextfieldWidgetState extends State<authtextfieldWidget> {
  // bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.headingtext,
              style: TextStyle(
                  color: MyAppColors.blackcolor.withOpacity(0.6),
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
        SizedBox(
          height: 7,
        ),
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(7)),
          child: TextFormField(
            // maxLength: widget.maxlength,
            // keyboardType: TextInputType.number,
            autocorrect: true,
            obscureText: widget.visible,

            keyboardType: widget.keyboardtype,

            controller: widget.authcontroller,
            validator: (val) => widget.validator(val!),
            decoration: InputDecoration(

              isDense: true,

              contentPadding: EdgeInsets.only(top: 10, left: 20),

              border: InputBorder.none,
            //   border: OutlineInputBorder(
            //
            //
            //
            //   ),
              // suffix: Icon(Icons.remove_red_eye_sharp),
              errorStyle: TextStyle(
             //   inherit: tr,
                height: 0.5,
              //  textBaseline: TextBaseline.ideographic,
                color: Colors.red,
                fontSize: 10,
              ),
  errorBorder: InputBorder.none,
  errorMaxLines: 1,
  suffixIconConstraints: BoxConstraints(
    minWidth: 2,
    minHeight: 2,
    ),
              hintText: widget.text,
              hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w400),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 15,top: 15),
                child: widget.isPasswordField
                    ? InkWell(
                        onTap: () => widget.onPwdTap(),
                        child: widget.visible
                            ? Icon(
                                CupertinoIcons.eye_slash,
                                size: 20,
                              )
                            : Icon(
                                CupertinoIcons.eye,
                                size: 20,
                              ),
                      )
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
