import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:halal_food_user_app/Helpers/helper.dart';

import 'package:halal_food_user_app/Models/shop_model.dart';
import 'package:halal_food_user_app/Services/shop_services.dart';
import 'package:halal_food_user_app/Utils/colors.dart';
import 'package:halal_food_user_app/Utils/res.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopDetails extends StatefulWidget {
  final String ShopId;
  final String shoptitle;
  final String shopaddress;
  final String shopdescription;
  final String phonenumber;
  final String email;
  final String shopimage;
  final double latitude;
  final double longititude;

  ShopDetails({
    required this.ShopId,
    required this.shoptitle,
    required this.shopaddress,
    required this.shopdescription,
    required this.phonenumber,
    required this.email,
    required this.shopimage,
    required this.latitude,
    required this.longititude,
  });

  @override
  _ShopDetailsState createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  bool isFavourite = false;

  Set<Marker> _marker = Set<Marker>();

  Completer<GoogleMapController> _controller = Completer();

  // Position? currentPosition;
  // var geolocator = Geolocator();

  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );
  // void showLocationPins() {
  //   var sourceposition = LatLng(
  //       currentLocation!.latitude ?? 0.0, currentLocation!.longitude ?? 0.0);
  //
  //   var destinationPosition =
  //   LatLng(destinationLatlng.latitude, destinationLatlng.longitude);
  //
  //   _marker.add(Marker(
  //     markerId: MarkerId('sourcePosition'),
  //     position: sourceposition,
  //   ));
  //
  //   _marker.add(
  //     Marker(
  //       markerId: MarkerId('destinationPosition'),
  //       position: destinationPosition,
  //     ),
  //   );
  //
  //   setPolylinesInMap();
  // }
  // void updatePinsOnMap() async {
  //   CameraPosition cameraPosition = CameraPosition(
  //     zoom: 20,
  //     tilt: 80,
  //     bearing: 30,
  //     target: LatLng(
  //         currentLocation!.latitude ?? 0.0, currentLocation!.longitude ?? 0.0),
  //   );

  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);
  //
  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
  // void locateposition() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   currentPosition = position;
  //   LatLng latLatPosition = LatLng(position.latitude, position.longitude);
  //
  //   CameraPosition cameraPosition =
  //   new CameraPosition(target: latLatPosition, zoom: 14);
  //
  //   //newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  //
  //   // String address =
  //   // await AssistantMethods.SearchCoordinateAdress(position, context);
  // //  print("this is your address :: " + address);
  // }
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  bool _hasCallSupport = false;
  Future<void>? _launched;
  String _phone = '1235';

  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunch('tel:123').then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ShopServices _contactServices = ShopServices();
    CameraPosition _initialCameraPosition = CameraPosition(
      zoom: 20,
      target: LatLng(widget.latitude, widget.longititude),
    );

    Future<void> _makePhoneCall(String phoneNumber) async {
      // Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
      // Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
      // such as spaces in the input, which would cause `launch` to fail on some
      // platforms.
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      await launch(launchUri.toString());
    }

    //final shop = Provider.of<ShopModel>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: 230,
                  width: double.infinity,
                  child: Image.network(widget.shopimage.toString()),
                  //       decoration: BoxDecoration(
                  //
                  //           image: DecorationImage(
                  //          fit: BoxFit.cover,
                  //          image: Image.network(widget.shopimage) as ImageProvider
                  //           )
                  //
                  //   )
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Text(
                        widget.shoptitle,
                        style: TextStyle(
                            color: MyAppColors.blackcolor,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => UpdatePassword())

                        // );
                      },
                    ),
                    IconButton(
                        icon: Icon(isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border),
                        onPressed: () {
                          setState(() {
                            isFavourite = !isFavourite;
                          });
                          _contactServices.updateShopFavourite(ShopModel(
                              shopId: widget.ShopId,
                              isFavorite: isFavourite,
                              userID: getUserID()));
                        }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: widget.shopaddress,
                            style: TextStyle(
                                color: MyAppColors.blackcolor.withOpacity(0.5),
                                fontWeight: FontWeight.w600,
                                fontSize: 12)),
                        maxLines: 2,

                        // child:
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  child: RichText(
                    text: TextSpan(
                        text: widget.shopdescription,
                        style: TextStyle(
                            color: MyAppColors.blackcolor.withOpacity(0.5),
                            fontWeight: FontWeight.w600,
                            fontSize: 12)),
                    maxLines: 2,

                    // child:
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Text(
                        "Contact Info",
                        style: TextStyle(
                            color: MyAppColors.blackcolor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      onTap: _makingPhoneCall,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(Res.phoneicon),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      child: Text(
                        widget.phonenumber.toString(),
                        style: TextStyle(
                            color: MyAppColors.blackcolor.withOpacity(0.4),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onTap: _hasCallSupport
                          ? () => setState(() {
                                _launched = _makePhoneCall(widget.phonenumber);
                              })
                          : null,
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => UpdatePassword())

                      // );
                      //   },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(Res.emailicon),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      child: Text(
                        widget.email,
                        style: TextStyle(
                            color: MyAppColors.blackcolor.withOpacity(0.4),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onTap: () => launch(
                        'mailto:${widget.email}?subject=Hi&body=How are you%20plugin'
                        // "mailto:abhi@androidcoding.in?subject=Hi&body=How are you%20plugin"

                      ),

                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 20),
                child: Row(
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          color: MyAppColors.redcolor,
                          borderRadius: BorderRadius.circular(33)),
                      child: Image.asset(Res.facebook),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          color: MyAppColors.redcolor,
                          borderRadius: BorderRadius.circular(33)),
                      child: Image.asset(Res.twitter),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          color: MyAppColors.redcolor,
                          borderRadius: BorderRadius.circular(33)),
                      child: Image.asset(Res.instagarm),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          color: MyAppColors.redcolor,
                          borderRadius: BorderRadius.circular(33)),
                      child: Image.asset(Res.globe),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          color: MyAppColors.redcolor,
                          borderRadius: BorderRadius.circular(33)),
                      child: Image.asset(Res.whatsapp),
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
                  height: 200,
                  width: double.infinity,
                  color: Colors.red,
                  child: GoogleMap(
                    zoomControlsEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomGesturesEnabled: true,

                    myLocationEnabled: true,

                    //   markers: ,
                    mapType: MapType.normal,
                    markers: _marker,
                    //    initialCameraPosition: _kGooglePlex,
                    //   initialCameraPosition: _initialCameraPosition,
                    initialCameraPosition: CameraPosition(
                      zoom: 4,
                      target: LatLng(widget.latitude, widget.longititude),
                    ),
                    //  markers: ,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                  // floatingActionButton: FloatingActionButton.extended(
                  //   onPressed: _goToTheLake,
                  //   label: Text('To the lake!'),
                  //   icon: Icon(Icons.directions_boat),
                  // ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _makingPhoneCall() async {
    const url = 'tel:9876543210';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
