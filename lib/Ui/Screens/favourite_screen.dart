import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:halal_food_user_app/Models/shop_model.dart';
import 'package:halal_food_user_app/Services/shop_services.dart';
import 'package:halal_food_user_app/Services/user_services.dart';
import 'package:halal_food_user_app/Ui/Screens/shop_details.dart';
import 'package:halal_food_user_app/Ui/Widgets/home_card_widget.dart';
import 'package:halal_food_user_app/Utils/colors.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen(
      {Key? key,
      menuScreenContext,
      bool? hideStatus,
      Null Function()? onScreenHideButtonPressed})
      : super(key: key);

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  List<ShopModel> searchedContact = [];

  List<ShopModel> contactList = [];

  bool isSearchingAllow = false;
  bool isSearched = false;
  List<ShopModel> contactListDB = [];

  void _searchedContacts(String val) async {
    print(contactListDB.length);
    searchedContact.clear();
    for (var i in contactListDB) {
      var lowerCaseString = i.name.toString().toLowerCase() +
          " " +
          i.address.toString().toLowerCase() +
          i.phone.toString();

      var defaultCase = i.description.toString() +
          " " +
          i.description.toString() +
          i.phone.toString();

      if (lowerCaseString.contains(val) || defaultCase.contains(val)) {
        searchedContact.add(i);
      } else {
        setState(() {
          isSearched = true;
        });
      }
    }
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    ShopServices _contactServices = ShopServices();
    UserServices userServices = UserServices();
    return SafeArea(
      child: Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text("Your Favourite",
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
                    Text("shops",
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
              StreamProvider.value(
                  value: _contactServices.streamFavouriteShops(),
                  initialData: [ShopModel()],
                  builder: (context, child) {
                    contactListDB = context.watch<List<ShopModel>>();
                    List<ShopModel> list = context.watch<List<ShopModel>>();
                    return list.isEmpty
                        ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: Text("Add Shops",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20)),
                        ))
                        : list[0].shopId == null
                        ? Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: SpinKitWave(
                            color: MyAppColors.redcolor,
                            type: SpinKitWaveType.start),
                      ),
                    )
                        : list.isEmpty
                        ? Center(child: Text("No Data"))
                        : searchedContact.isEmpty
                        ? isSearched == true
                        ? Center(child: Text("NO Data"))
                        : Container(

                      // height: 550,
                      // width: MediaQuery.of(context).size.width,

                        child: ListView.builder(
                            itemCount: list.length,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, i) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShopDetails(
                                                ShopId: list[i].shopId.toString(),
                                                shoptitle: list[i]
                                                    .name
                                                    .toString(),
                                                shopaddress: list[
                                                i]
                                                    .address
                                                    .toString(),
                                                shopdescription:
                                                list[i]
                                                    .description
                                                    .toString(),
                                                phonenumber: list[
                                                i]
                                                    .phone
                                                    .toString(),
                                                email: list[i]
                                                    .email
                                                    .toString(),
                                                shopimage: list[i]
                                                    .images
                                                    .toString(),
                                                latitude: double
                                                    .parse(list[i]
                                                    .latitude
                                                    .toString()),
                                                longititude: double
                                                    .parse(list[i]
                                                    .longitude
                                                    .toString()),
                                              )));
                                },
                                child: CardWidget(
                                  list[i].name.toString(),
                                  list[i].description.toString(),
                                  list[i]
                                      .phone
                                      .toString(),
                                  list[i].images.toString(),
                                  list[i].shopId.toString(),
                                  list[i].address.toString(),
                                ),
                              );
                            }))
                        : Container(
                      // height: 550,
                      // width: MediaQuery.of(context).size.width,

                        child: ListView.builder(
                            itemCount: searchedContact.length,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, i) {
                              return CardWidget(
                                searchedContact[i].name.toString(),
                                searchedContact[i]
                                    .description
                                    .toString(),
                                searchedContact[i]
                                    .phone
                                    .toString(),
                                searchedContact[i].images.toString(),
                                searchedContact[i].shopId.toString(),
                                searchedContact[i].address.toString(),
                              );
                            }));
                  }),
            ],
          )),
    );
  }
}
