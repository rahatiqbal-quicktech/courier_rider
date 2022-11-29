/*
Author: QuickTech IT
Author URI: http://quicktech-ltd.com;
Description: QuickTech IT maintain standard quality for Website and Creative Design
*/

import 'package:courier/DeliveryMan/Utils/BottomBar.dart';
import 'package:courier/DeliveryMan/Utils/NavigationDrawer.dart';
import 'package:courier/GlobalUtils/UI_Colors.dart';
import 'package:courier/Models/DeliverymanPickupModel.dart';
import 'package:courier/Network/DeliverymanNetwork.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class QuickTechIT_DeliverymanPickup extends StatefulWidget {
  @override
  _QuickTechIT_DeliverymanPickupState createState() =>
      _QuickTechIT_DeliverymanPickupState();
}

// ignore: camel_case_types
class _QuickTechIT_DeliverymanPickupState
    extends State<QuickTechIT_DeliverymanPickup> {
  List<DeliverymanPickupModel> pickups = [];

  int startFrom = 0;

  String searchData;

  bool isData = true;
  bool isLoading = false;

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
        DeliverymanNetwork().getPickups(startFrom).then((value) {
          if (value.length < 20) {
            isData = false;
          }
          setState(() {
            pickups = value;
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          elevation: 0,
          backgroundColor: UIColors.primaryColor,
          iconTheme: IconThemeData(color: Colors.white),
          automaticallyImplyLeading: false,
          title: Text(
            "My Pickups",
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
          child: pickups.length == 0 && isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : pickups.length == 0
                  ? Center(
                      child: Text("No Pickups Available"),
                    )
                  : RefreshIndicator(
                      onRefresh: () {
                        setState(() {
                          pickups.clear();
                          startFrom = 0;
                          isData = true;
                        });
                        return getData();
                      },
                      child: SingleChildScrollView(
                          padding: EdgeInsets.all(10),
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              Container(
                                width: Get.width,
                                margin: EdgeInsets.all(8),
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
                                    hintText: "Search Request",
                                  ),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: pickups.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (searchData != null) {
                                    if (pickups[index]
                                            .pickupAddress
                                            .toLowerCase()
                                            .contains(searchData) ||
                                        pickups[index]
                                            .firstName
                                            .toLowerCase()
                                            .contains(searchData) ||
                                        pickups[index]
                                            .phoneNumber
                                            .toLowerCase()
                                            .contains(searchData)) {
                                      return parcelItem(pickups[index]);
                                    } else {
                                      return Container();
                                    }
                                  } else {
                                    return parcelItem(pickups[index]);
                                  }
                                },
                              ),
                              if (isLoading)
                                Center(
                                  child: CircularProgressIndicator(),
                                )
                            ],
                          )),
                    ),
        ));
  }

  Widget parcelItem(DeliverymanPickupModel item) {
    return InkWell(
      onTap: () {
        Get.toNamed('/deliveryman/pickup/details/${item.id}').whenComplete(() => getData());
      },
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.5),
              blurRadius: 4,
              offset: Offset(4, 4), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: Get.width,
                    child: Text(
                      item.firstName,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  item.status == 0
                      ? "Not Assigned"
                      : item.status == 1
                          ? "Pending"
                          : item.status == 2
                              ? "Accepted"
                              : item.status == 3
                                  ? "Cancelled"
                                  : "",
                  style: TextStyle(fontSize: 16, color: UIColors.primaryColor),
                )
              ],
            ),
            Container(
              width: Get.width,
              child: Text(
                item.phoneNumber.toString(),
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              width: Get.width,
              child: Text(
                item.pickupAddress,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
