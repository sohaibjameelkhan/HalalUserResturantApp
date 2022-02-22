import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:halal_food_user_app/Utils/colors.dart';

import '../../Utils/res.dart';

class CardWidget extends StatefulWidget {
  final String name;
  final String description;
  final String contactNumber;
  final String shopImage;
  final String shopId;
  final String address;

  CardWidget(this.name, this.description, this.contactNumber, this.shopImage,
      this.shopId, this.address);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    // ContactServices _contactServices = ContactServices();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: 130,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 2,
                      child: CachedNetworkImage(
                          height: 100,
                          width: 50,
                          imageBuilder: (context, imageProvider) => Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                          imageUrl: widget.shopImage,
                          //imageUrl: "http://via.placeholder.com/350x150",
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => SpinKitWave(
                                  color: MyAppColors.redcolor,
                                  type: SpinKitWaveType.start),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error))),

                  // child: Container(
                  //      height: 100,
                  //      width: 90,
                  //      decoration: BoxDecoration(
                  //          borderRadius: BorderRadius.circular(13),
                  //          image: DecorationImage(
                  //              fit: BoxFit.cover,
                  //              image:  CachedNetworkImage(
                  //
                  //                fit: BoxFit.cover,
                  //                  progressIndicatorBuilder: (context,url, downloadProgress)=> SpinKitWave(color: Colors.blue, type: SpinKitWaveType.start),
                  //                  errorWidget: (context,url,error)=> Icon(Icons.error),
                  //
                  //                  imageUrl: widget.image.toString()) as ImageProvider
                  //          )
                  //      ),
                  //    ),

                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(widget.name,
                                style: TextStyle(
                                    color: MyAppColors.blackcolor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 19)),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: RichText(
                            text: TextSpan(
                                text: widget.address,
                                style: TextStyle(
                                    color:
                                        MyAppColors.blackcolor.withOpacity(0.5),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12)),
                            maxLines: 2,

                            // child:
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Container(
                            child: RichText(
                              text: TextSpan(
                                  text: widget.description,
                                  style: TextStyle(
                                      color: MyAppColors.blackcolor
                                          .withOpacity(0.9),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13)),
                              maxLines: 2,

                              // child:
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
