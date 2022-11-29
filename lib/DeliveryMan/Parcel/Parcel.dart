/*
Author: QuickTech IT
Author URI: http://quicktech-ltd.com;
Description: QuickTech IT maintain standard quality for Website and Creative Design
*/

import 'package:courier/DeliveryMan/Utils/BottomBar.dart';
import 'package:courier/DeliveryMan/Utils/NavigationDrawer.dart';
import 'package:courier/GlobalUtils/UI_Colors.dart';
import 'package:courier/Models/DeliverymanParcelModel.dart';
import 'package:courier/Network/DeliverymanNetwork.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// ignore: camel_case_types
class QuickTechIT_DeliverymanParcel extends StatefulWidget {
  const QuickTechIT_DeliverymanParcel({Key key}) : super(key: key);

  @override
  _QuickTechIT_DeliverymanParcelState createState() =>
      _QuickTechIT_DeliverymanParcelState();
}

// ignore: camel_case_types
class _QuickTechIT_DeliverymanParcelState
    extends State<QuickTechIT_DeliverymanParcel> {
  String type = Get.parameters['type'];

  List<DeliverymanParcelModel> parcels = [];

  String deliverymanId = GetStorage().read("userId").toString();

  String searchData;

  int startFrom = 0;

  bool isData = true;
  bool isLoading = false;

  @override
  void initState() {
    getData();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<bool> getData() async {
    if (!isLoading) {
      if (isData) {
        setState(() {
          isLoading = true;
        });
        DeliverymanNetwork().getParcels(startFrom, type).then((value) {
          if (value.length < 20) {
            isData = false;
          }
          setState(() {
            parcels = value;
            isLoading = false;
          });
        });
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          elevation: 0,
          backgroundColor: UIColors.primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          automaticallyImplyLeading: false,
          title: const Text(
            "My Parcels",
          ),
          // actions: [
          //   IconButton(
          //       icon: Icon(Icons.logout),
          //       onPressed: () {
          //         DeliverymanNetwork().logout();
          //       })
          // ],
        ),
        backgroundColor: UIColors.pageBackground,
        bottomNavigationBar: BottomBar(),
        endDrawer: NavigationDrawer(),
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.maxScrollExtent ==
                scrollInfo.metrics.pixels) {
              getData();
            }
            return true;
          },
          child: parcels.length == 0 && isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : parcels.length == 0
                  ? const Center(
                      child: Text("No Parcel Available"),
                    )
                  : RefreshIndicator(
                      onRefresh: () {
                        setState(() {
                          parcels.clear();
                          startFrom = 0;
                          isData = true;
                        });
                        return getData();
                      },
                      child: SingleChildScrollView(
                          padding: const EdgeInsets.all(10),
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              Container(
                                width: Get.width,
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: TextFormField(
                                  onChanged: (val) {
                                    setState(() {
                                      searchData = val.toLowerCase();
                                    });
                                  },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        color: Colors.grey.withOpacity(.8)),
                                    hintText: "Search Parcel",
                                  ),
                                ),
                              ),
                              // SizedBox(height: 10),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: parcels.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (searchData != null) {
                                    if (parcels[index]
                                            .recipientName
                                            .toLowerCase()
                                            .contains(searchData) ||
                                        parcels[index]
                                            .recipientAddress
                                            .toLowerCase()
                                            .contains(searchData) ||
                                        parcels[index]
                                            .recipientPhone
                                            .toLowerCase()
                                            .contains(searchData) ||
                                        parcels[index]
                                            .firstName
                                            .toLowerCase()
                                            .contains(searchData) ||
                                        parcels[index]
                                            .phoneNumber
                                            .toLowerCase()
                                            .contains(searchData) ||
                                        parcels[index]
                                            .companyName
                                            .toLowerCase()
                                            .contains(searchData)) {
                                      return parcelItem(parcels[index]);
                                    } else {
                                      return Container();
                                    }
                                  } else {
                                    return parcelItem(parcels[index]);
                                  }
                                },
                              ),
                              if (isLoading)
                                const Center(
                                  child: CircularProgressIndicator(),
                                )
                            ],
                          )),
                    ),
        ));
  }

  Widget parcelItem(DeliverymanParcelModel item) {
    return InkWell(
      onTap: () {
        Get.toNamed('/deliveryman/parcel/details/${item.id}');
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.5),
              blurRadius: 4,
              offset: const Offset(4, 4), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              width: Get.width,
              child: Text(
                item.recipientName ?? "",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: Get.width,
              child: Text(
                item.recipientAddress ?? "",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cod= N ${item.cod}, Charge= N ${item.deliveryCharge + item.codCharge}",
                  style: const TextStyle(fontSize: 15),
                ),
                Text(
                  item.merchantpayStatus == null
                      ? "Unpaid"
                      : item.merchantpayStatus == 0
                          ? "Processing"
                          : "Paid",
                  style: TextStyle(fontSize: 15, color: UIColors.primaryColor),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  GetStorage().read(item.status.toString()),
                  style: TextStyle(fontSize: 16, color: UIColors.primaryColor),
                ),
                Text(
                  item.createdAt,
                  style: const TextStyle(fontSize: 15),
                )
              ],
            ),
            SizedBox(
              width: Get.width,
              child: Text(
                deliverymanId == item.deliverymanId &&
                        deliverymanId == item.pickupmanId
                    ? "Pickup Assign\nDeliveryman Assign"
                    : deliverymanId == item.pickupmanId
                        ? "Pickup Assign"
                        : deliverymanId == item.deliverymanId
                            ? "Deliveryman Assign"
                            : "",

                // deliverymanId == item.pickupmanId && item.deliverymanId == null
                //     ? "Pickup Assign"
                //     : deliverymanId == item.deliverymanId &&
                //             item.pickupmanId == null
                //         ? "Deliveryman Assign"
                //         : deliverymanId == item.deliverymanId &&
                //                 deliverymanId == item.pickupmanId
                //             ? "Pickup Assign\nDeliveryman Assign"
                //             : "",
                style: const TextStyle(fontSize: 16, color: Colors.green),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> livelocation(String parcelid) async {
  //   locationsubscription = location.onLocationChanged.handleError((onError) {
  //     print(onError);
  //     locationsubscription?.cancel();
  //     setState(() {
  //       locationsubscription = null;
  //     });
  //   }).listen((loc.LocationData currentlocation) async {
  //     await FirebaseFirestore.instance
  //         .collection('location')
  //         .doc(parcelid.toString())
  //         .set(
  //       {
  //         'latitude': currentlocation.latitude,
  //         'longitude': currentlocation.longitude,
  //         'name': pref.read('userName'),
  //         'parcelid': parcelid,
  //       },
  //       // SetOptions(merge: true),
  //     );
  //   });
  // }
}
