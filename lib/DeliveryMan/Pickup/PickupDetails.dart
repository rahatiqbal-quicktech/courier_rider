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
import 'package:responsive_flutter/responsive_flutter.dart';

// ignore: camel_case_types
class QuickTechIT_DeliverymanPickupDetails extends StatefulWidget {
  @override
  _QuickTechIT_DeliverymanPickupDetailsState createState() =>
      _QuickTechIT_DeliverymanPickupDetailsState();
}

// ignore: camel_case_types
class _QuickTechIT_DeliverymanPickupDetailsState
    extends State<QuickTechIT_DeliverymanPickupDetails> {
  TextEditingController noteController = new TextEditingController();

  String pickupId = Get.parameters['pickupId'];

  DeliverymanPickupModel pickup;

  void initState() {
    getData();

    // Timer.periodic(Duration(seconds: 5), (_) => getData());

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getData() {
    DeliverymanNetwork().getPickup(pickupId).then((value) {
      setState(() {
        pickup = value;
      });
    });
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
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
              onPressed: () {
                Get.back();
              }),
          title: Text(
            "Pickup Details",
          ),
          // actions: [
          //   IconButton(
          //       icon: Icon(Icons.logout),
          //       onPressed: () {
          //         DeliverymanNetwork().logout();
          //       })
          // ],
        ),
        backgroundColor: UIColors.backgroundColor,
        bottomNavigationBar: BottomBar(),
        endDrawer: NavigationDrawer(),
        body: pickup == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                padding: EdgeInsets.all(10),
                physics: BouncingScrollPhysics(),
                child: Column(children: [
                  Container(
                    width: Get.width,
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Merchant Information",
                          style: TextStyle(
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2.5)),
                        ),
                        Divider(
                          color: UIColors.primaryColor,
                          thickness: 3,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  width: Get.width,
                                  child: Text(
                                    "Name",
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  width: Get.width,
                                  child: Text(
                                    pickup.firstName,
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  width: Get.width,
                                  child: Text(
                                    "Phone",
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  width: Get.width,
                                  child: Text(
                                    pickup.phoneNumber.toString(),
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ))
                          ],
                        ),
                        if (pickup.emailAddress != null)
                          SizedBox(
                            height: 5,
                          ),
                        if (pickup.emailAddress != null)
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: Get.width,
                                    child: Text(
                                      "Email",
                                      style: TextStyle(
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(2),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    width: Get.width,
                                    child: Text(
                                      pickup.emailAddress,
                                      style: TextStyle(
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(2),
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ))
                            ],
                          )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: Get.width,
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Pickup Information",
                          style: TextStyle(
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2.5)),
                        ),
                        Divider(
                          color: UIColors.primaryColor,
                          thickness: 3,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  width: Get.width,
                                  child: Text(
                                    "Address",
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  width: Get.width,
                                  child: Text(
                                    pickup.pickupAddress,
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  width: Get.width,
                                  child: Text(
                                    "Type",
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  width: Get.width,
                                  child: Text(
                                    pickup.pickuptype == 1
                                        ? "Next Day Delivery"
                                        : pickup.pickuptype == 2
                                            ? "Same Day Delivery"
                                            : "",
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        if (pickup.note != null)
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: Get.width,
                                    child: Text(
                                      "Note",
                                      style: TextStyle(
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(2),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    width: Get.width,
                                    child: Text(
                                      pickup.note != null ? pickup.note : "",
                                      style: TextStyle(
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(2),
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ))
                            ],
                          ),
                        if (pickup.note != null)
                          SizedBox(
                            height: 5,
                          ),
                        if (pickup.estimedparcel != null)
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: Get.width,
                                    child: Text(
                                      "Estimated Parcel",
                                      style: TextStyle(
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(2),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    width: Get.width,
                                    child: Text(
                                      pickup.estimedparcel != null
                                          ? pickup.estimedparcel
                                          : "",
                                      style: TextStyle(
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(2),
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ))
                            ],
                          ),
                        if (pickup.estimedparcel != null)
                          SizedBox(
                            height: 5,
                          ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  width: Get.width,
                                  child: Text(
                                    "Status",
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  width: Get.width,
                                  child: Text(
                                    pickup.status == 0
                                        ? "Not Assigned"
                                        : pickup.status == 1
                                            ? "Pending"
                                            : pickup.status == 2
                                                ? "Accepted"
                                                : pickup.status == 3
                                                    ? "Cancelled"
                                                    : "",
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  width: Get.width,
                                  child: Text(
                                    "Date",
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  width: Get.width,
                                  child: Text(
                                    pickup.createdAt,
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: Get.width,
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Pickup Status Update",
                          style: TextStyle(
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2.5)),
                        ),
                        Divider(
                          color: UIColors.primaryColor,
                          thickness: 3,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        // Container(
                        //   width: Get.width,
                        //   padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        //   decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.grey),
                        //     borderRadius: BorderRadius.circular(2),
                        //   ),
                        //   child: DropdownButtonFormField(
                        //     hint: Text(
                        //       "Area",
                        //       style: TextStyle(
                        //           fontSize:
                        //               ResponsiveFlutter.of(context).fontSize(2),
                        //           color: Colors.grey.withOpacity(.8)),
                        //     ), // Not necessary for Option 1
                        //     decoration: InputDecoration(
                        //       isDense: true,
                        //       enabledBorder: InputBorder.none,
                        //     ),
                        //     validator: (value) =>
                        //         value == null ? "Please select area" : null,
                        //     isExpanded: true,
                        //     value: _selectedStatus,
                        //     onChanged: (newValue) {
                        //       setState(() {
                        //         _selectedStatus = newValue;
                        //       });
                        //     },
                        //     items: status.map((value) {
                        //       return DropdownMenuItem(
                        //         child: new Text(value),
                        //         value: status.indexOf(value) + 1,
                        //       );
                        //     }).toList(),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Container(
                        //   height: 40,
                        //   width: Get.width,
                        //   color: UIColors.primaryColor,
                        //   child: TextButton(
                        //       onPressed: () {
                        //         DeliverymanNetwork().pickupStatusUpdate(
                        //             pickup.id.toString(),
                        //             _selectedStatus.toString());
                        //       },
                        //       child: Text(
                        //         "Submit",
                        //         style: TextStyle(
                        //           color: Colors.white,
                        //           fontSize:
                        //               ResponsiveFlutter.of(context).fontSize(2),
                        //         ),
                        //       )),
                        // ),
                        // SizedBox(
                        //   height: 50,
                        // ),
                        pickup.status == 3
                            ? Text(
                                "Already Cancelled",
                                style: TextStyle(
                                  color: UIColors.primaryColor,
                                  fontSize:
                                      ResponsiveFlutter.of(context).fontSize(3),
                                ),
                              )
                            : pickup.status == 2
                                ? Text(
                                    "Already Accepted",
                                    style: TextStyle(
                                      color: UIColors.primaryColor,
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(3),
                                    ),
                                  )
                                : pickup.status == 1
                                    ? Row(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 40,
                                                width: Get.width,
                                                color: UIColors.primaryColor,
                                                child: TextButton(
                                                    onPressed: () {
                                                      DeliverymanNetwork()
                                                          .pickupStatusUpdate(
                                                              pickup.id
                                                                  .toString(),
                                                              "3");
                                                    },
                                                    child: Text(
                                                      "Cancelled",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            ResponsiveFlutter
                                                                    .of(context)
                                                                .fontSize(2),
                                                      ),
                                                    )),
                                              )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 40,
                                                width: Get.width,
                                                color: UIColors.primaryColor,
                                                child: TextButton(
                                                    onPressed: () {
                                                      DeliverymanNetwork()
                                                          .pickupStatusUpdate(
                                                              pickup.id
                                                                  .toString(),
                                                              "2");
                                                    },
                                                    child: Text(
                                                      "Accepted",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            ResponsiveFlutter
                                                                    .of(context)
                                                                .fontSize(2),
                                                      ),
                                                    )),
                                              ))
                                        ],
                                      )
                                    : Container(
                                        height: 40,
                                        width: Get.width,
                                        color: UIColors.primaryColor,
                                        child: TextButton(
                                            onPressed: () {
                                              DeliverymanNetwork()
                                                  .pickupStatusUpdate(
                                                      pickup.id.toString(),
                                                      "1");
                                            },
                                            child: Text(
                                              "Assign as pending",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: ResponsiveFlutter.of(
                                                        context)
                                                    .fontSize(2),
                                              ),
                                            )),
                                      )
                      ],
                    ),
                  ),
                ])));
  }
}
