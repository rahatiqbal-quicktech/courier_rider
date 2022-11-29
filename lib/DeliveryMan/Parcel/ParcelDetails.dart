/*
Author: QuickTech IT
Author URI: http://quicktech-ltd.com;
Description: QuickTech IT maintain standard quality for Website and Creative Design
*/

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:courier/DeliveryMan/Utils/BottomBar.dart';
import 'package:courier/DeliveryMan/Utils/NavigationDrawer.dart';
import 'package:courier/GlobalUtils/Decoration.dart';
import 'package:courier/GlobalUtils/UI_Colors.dart';
import 'package:courier/Models/DeliverymanParcelModel.dart';
import 'package:courier/Models/NotesModel.dart';
import 'package:courier/Network/DeliverymanNetwork.dart';
import 'package:courier/main.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
// import 'package:nb_utils/nb_utils.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart' as loc;

// ignore: camel_case_types
class QuickTechIT_DeliverymanParcelDetails extends StatefulWidget {
  const QuickTechIT_DeliverymanParcelDetails({Key key}) : super(key: key);

  @override
  _QuickTechIT_DeliverymanParcelDetailsState createState() =>
      _QuickTechIT_DeliverymanParcelDetailsState();
}

// ignore: camel_case_types
class _QuickTechIT_DeliverymanParcelDetailsState
    extends State<QuickTechIT_DeliverymanParcelDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController noteController = TextEditingController();

  String parcelId = Get.parameters['parcelId'];

  bool partialDelivery;

  TextEditingController partial_payment = TextEditingController();

  DeliverymanParcelModel parcel;
  List<NotesModel> notes;

  String status = "0";
  String msg = "";

  // Timer _timer;

  void initState() {
    getData();

    // _timer = Timer.periodic(Duration(seconds: 5), (_) => getData());

    super.initState();

    partialDelivery = false;
    // livelocation(parcelId);
    log("Parcel ID $parcelId");
    trackParcel(parcelId);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // _timer.cancel();
    super.dispose();
  }

  getData() {
    DeliverymanNetwork().getParcel(parcelId).then((value) {
      if (mounted)
        setState(() {
          parcel = value;
        });
    });

    DeliverymanNetwork().getNotes().then((value) {
      if (mounted)
        setState(() {
          notes = value;
        });
    });
  }

  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData> locationsubscription;
  final pref = GetStorage();
  trackParcel(String parcelid) async {
    await livelocation(parcelid);
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
  //         .collection('trackParcel')
  //         .doc(parcelid.toString())
  //         .set(
  //       {
  //         'lat': currentlocation.latitude,
  //         'lon': currentlocation.longitude,
  //         'name': pref.read('userName'),
  //         'parcelid': parcelid,
  //       },
  //       // SetOptions(merge: true),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          elevation: 0,
          backgroundColor: UIColors.primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
              onPressed: () {
                Get.back();
              }),
          title: const Text(
            "Parcel Details",
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
        body: parcel == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                physics: const BouncingScrollPhysics(),
                child: Column(children: [
                  Container(
                    width: Get.width,
                    color: Colors.white,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Merchant Information",
                          style: TextStyle(
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2.5),
                              fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: UIColors.primaryColor,
                          thickness: 3,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: SizedBox(
                                  width: Get.width,
                                  child: Text(
                                    "Name",
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                flex: 2,
                                child: SizedBox(
                                  width: Get.width,
                                  child: Text(
                                    parcel.firstName,
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: SizedBox(
                                  width: Get.width,
                                  child: Text(
                                    "Phone",
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                flex: 2,
                                child: SizedBox(
                                  width: Get.width,
                                  child: Text(
                                    parcel.phoneNumber.toString(),
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        if (parcel.emailAddress != null)
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    width: Get.width,
                                    child: Text(
                                      "Email",
                                      style: TextStyle(
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(2),
                                      ),
                                    ),
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    width: Get.width,
                                    child: Text(
                                      parcel.emailAddress,
                                      style: TextStyle(
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(2),
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ))
                            ],
                          ),
                        if (parcel.emailAddress != null)
                          const SizedBox(
                            height: 5,
                          ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: SizedBox(
                                  width: Get.width,
                                  child: Text(
                                    "Company",
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                flex: 2,
                                child: SizedBox(
                                  width: Get.width,
                                  child: Text(
                                    parcel.companyName,
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
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: Get.width,
                    color: Colors.white,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Customer Information",
                          style: TextStyle(
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2.5),
                              fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: UIColors.primaryColor,
                          thickness: 3,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: SizedBox(
                                  width: Get.width,
                                  child: Text(
                                    "Name",
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                flex: 2,
                                child: SizedBox(
                                  width: Get.width,
                                  child: Text(
                                    parcel.recipientName,
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: SizedBox(
                                  width: Get.width,
                                  child: Text(
                                    "Phone",
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                flex: 2,
                                child: SizedBox(
                                  width: Get.width,
                                  child: Text(
                                    parcel.recipientPhone.toString(),
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: SizedBox(
                                  width: Get.width,
                                  child: Text(
                                    "Address",
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                flex: 2,
                                child: SizedBox(
                                  width: Get.width,
                                  child: Text(
                                    parcel.recipientAddress,
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: SizedBox(
                                  width: Get.width,
                                  child: Text(
                                    "State",
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                flex: 2,
                                child: SizedBox(
                                  width: Get.width,
                                  child: Text(
                                    parcel.title,
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: SizedBox(
                                  width: Get.width,
                                  child: Text(
                                    "Area",
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                flex: 2,
                                child: SizedBox(
                                  width: Get.width,
                                  child: Text(
                                    parcel.zoneName,
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
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: Get.width,
                    color: Colors.white,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Parcel Information",
                          style: TextStyle(
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2.5),
                              fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: UIColors.primaryColor,
                          thickness: 3,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: SizedBox(
                                  width: Get.width,
                                  child: Text(
                                    "COD",
                                    style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                flex: 2,
                                child: SizedBox(
                                  width: Get.width,
                                  child: Text(
                                    parcel.cod.toString(),
                                    style: TextStyle(
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(2),
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.justify,
                                  ),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 40,
                                width: Get.width,
                                decoration:
                                    CustomDecoration().buttonDecoration(),
                                child: TextButton(
                                  onPressed: () async {
                                    String url = 'tel:${parcel.recipientPhone}';
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Text(
                                    "Call Customer",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(2.2)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                height: 40,
                                width: Get.width,
                                decoration:
                                    CustomDecoration().buttonDecoration(),
                                child: TextButton(
                                  onPressed: () async {
                                    String url = 'tel:${parcel.phoneNumber}';
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Text(
                                    "Call Merchant",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(2.2)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //         flex: 1,
                        //         child: Container(
                        //           width: Get.width,
                        //           child: Text(
                        //             "COD Charge",
                        //             style: TextStyle(
                        //               fontSize: ResponsiveFlutter.of(context)
                        //                   .fontSize(2),
                        //             ),
                        //           ),
                        //         )),
                        //     SizedBox(
                        //       width: 5,
                        //     ),
                        //     Expanded(
                        //         flex: 2,
                        //         child: Container(
                        //           width: Get.width,
                        //           child: Text(
                        //             "${parcel.codCharge}",
                        //             style: TextStyle(
                        //               fontSize: ResponsiveFlutter.of(context)
                        //                   .fontSize(2),
                        //             ),
                        //             textAlign: TextAlign.justify,
                        //           ),
                        //         ))
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //         flex: 1,
                        //         child: Container(
                        //           width: Get.width,
                        //           child: Text(
                        //             "Delivery Charge",
                        //             style: TextStyle(
                        //               fontSize: ResponsiveFlutter.of(context)
                        //                   .fontSize(2),
                        //             ),
                        //           ),
                        //         )),
                        //     SizedBox(
                        //       width: 5,
                        //     ),
                        //     Expanded(
                        //         flex: 2,
                        //         child: Container(
                        //           width: Get.width,
                        //           child: Text(
                        //             "${parcel.deliveryCharge}",
                        //             style: TextStyle(
                        //               fontSize: ResponsiveFlutter.of(context)
                        //                   .fontSize(2),
                        //             ),
                        //             textAlign: TextAlign.justify,
                        //           ),
                        //         ))
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //         flex: 1,
                        //         child: Container(
                        //           width: Get.width,
                        //           child: Text(
                        //             "Sub Total",
                        //             style: TextStyle(
                        //               fontSize: ResponsiveFlutter.of(context)
                        //                   .fontSize(2),
                        //             ),
                        //           ),
                        //         )),
                        //     SizedBox(
                        //       width: 5,
                        //     ),
                        //     Expanded(
                        //         flex: 2,
                        //         child: Container(
                        //           width: Get.width,
                        //           child: Text(
                        //             "${parcel.merchantAmount}",
                        //             style: TextStyle(
                        //               fontSize: ResponsiveFlutter.of(context)
                        //                   .fontSize(2),
                        //             ),
                        //             textAlign: TextAlign.justify,
                        //           ),
                        //         ))
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //         flex: 1,
                        //         child: Container(
                        //           width: Get.width,
                        //           child: Text(
                        //             "Paid",
                        //             style: TextStyle(
                        //               fontSize: ResponsiveFlutter.of(context)
                        //                   .fontSize(2),
                        //             ),
                        //           ),
                        //         )),
                        //     SizedBox(
                        //       width: 5,
                        //     ),
                        //     Expanded(
                        //         flex: 2,
                        //         child: Container(
                        //           width: Get.width,
                        //           child: Text(
                        //             parcel.merchantPaid.toString(),
                        //             style: TextStyle(
                        //               fontSize: ResponsiveFlutter.of(context)
                        //                   .fontSize(2),
                        //             ),
                        //             textAlign: TextAlign.justify,
                        //           ),
                        //         ))
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //         flex: 1,
                        //         child: Container(
                        //           width: Get.width,
                        //           child: Text(
                        //             "Due",
                        //             style: TextStyle(
                        //               fontSize: ResponsiveFlutter.of(context)
                        //                   .fontSize(2),
                        //             ),
                        //           ),
                        //         )),
                        //     SizedBox(
                        //       width: 5,
                        //     ),
                        //     Expanded(
                        //         flex: 2,
                        //         child: Container(
                        //           width: Get.width,
                        //           child: Text(
                        //             parcel.merchantDue.toString(),
                        //             style: TextStyle(
                        //               fontSize: ResponsiveFlutter.of(context)
                        //                   .fontSize(2),
                        //             ),
                        //             textAlign: TextAlign.justify,
                        //           ),
                        //         ))
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //         flex: 1,
                        //         child: Container(
                        //           width: Get.width,
                        //           child: Text(
                        //             "Status",
                        //             style: TextStyle(
                        //               fontSize: ResponsiveFlutter.of(context)
                        //                   .fontSize(2),
                        //             ),
                        //           ),
                        //         )),
                        //     SizedBox(
                        //       width: 5,
                        //     ),
                        //     Expanded(
                        //         flex: 2,
                        //         child: Container(
                        //           width: Get.width,
                        //           child: Text(
                        //             parcel.status == 1
                        //                 ? "Pending"
                        //                 : parcel.status == 2
                        //                     ? "Picked"
                        //                     : parcel.status == 3
                        //                         ? "In Transit"
                        //                         : parcel.status == 4
                        //                             ? "Delivered"
                        //                             : parcel.status == 5
                        //                                 ? "Hold"
                        //                                 : parcel.status == 6
                        //                                     ? "Return Pending"
                        //                                     : parcel.status == 7
                        //                                         ? "Return To Hub"
                        //                                         : parcel.status ==
                        //                                                 8
                        //                                             ? "Return To Merchant"
                        //                                             : parcel.status ==
                        //                                                     9
                        //                                                 ? "Cancelled"
                        //                                                 : "",
                        //             style: TextStyle(
                        //               fontSize: ResponsiveFlutter.of(context)
                        //                   .fontSize(2),
                        //             ),
                        //             textAlign: TextAlign.justify,
                        //           ),
                        //         ))
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //         flex: 1,
                        //         child: Container(
                        //           width: Get.width,
                        //           child: Text(
                        //             "Date",
                        //             style: TextStyle(
                        //               fontSize: ResponsiveFlutter.of(context)
                        //                   .fontSize(2),
                        //             ),
                        //           ),
                        //         )),
                        //     SizedBox(
                        //       width: 5,
                        //     ),
                        //     Expanded(
                        //         flex: 2,
                        //         child: Container(
                        //           width: Get.width,
                        //           child: Text(
                        //             parcel.createdAt,
                        //             style: TextStyle(
                        //               fontSize: ResponsiveFlutter.of(context)
                        //                   .fontSize(2),
                        //             ),
                        //             textAlign: TextAlign.justify,
                        //           ),
                        //         ))
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: Get.width,
                    color: Colors.white,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Actions",
                          style: TextStyle(
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2.5),
                              fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: UIColors.primaryColor,
                          thickness: 3,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        // Container(
                        //   height: 40,
                        //   width: Get.width,
                        //   decoration: CustomDecoration().buttonDecoration(),
                        //   child: TextButton(
                        //     onPressed: () async {
                        //       var status = Permission.storage;
                        //       if (await status.isGranted) {
                        //         generateParcelInvoice();
                        //       } else {
                        //         if (await status.request().isGranted) {
                        //           generateParcelInvoice();
                        //         }
                        //       }
                        //     },
                        //     child: Text(
                        //       "Invoice",
                        //       style: TextStyle(
                        //           color: Colors.white,
                        //           fontSize: ResponsiveFlutter.of(context)
                        //               .fontSize(2.2)),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  height: 40,
                                  width: Get.width,
                                  decoration:
                                      CustomDecoration().buttonDecoration(),
                                  child: TextButton(
                                      onPressed: () {
                                        status = "2";
                                        msg = "Picked";
                                        updateParcel();
                                      },
                                      child: Text(
                                        "Picked",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                        ),
                                      )),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  height: 40,
                                  width: Get.width,
                                  decoration:
                                      CustomDecoration().buttonDecoration(),
                                  child: TextButton(
                                      onPressed: () {
                                        status = "4";
                                        msg = "Deliver Parcel";
                                        updateParcel();
                                      },
                                      child: Text(
                                        "Delivered",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                        ),
                                      )),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  height: 40,
                                  width: Get.width,
                                  decoration:
                                      CustomDecoration().buttonDecoration(),
                                  child: TextButton(
                                      onPressed: () {
                                        status = "5";
                                        msg = "Hold Parcel";
                                        updateParcel();
                                      },
                                      child: Text(
                                        "Hold",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                        ),
                                      )),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  height: 40,
                                  width: Get.width,
                                  decoration:
                                      CustomDecoration().buttonDecoration(),
                                  child: TextButton(
                                      onPressed: () {
                                        status = "3";
                                        // msg = "Return Pending";
                                        msg = "Awaiting";
                                        updateParcel();
                                      },
                                      child: Text(
                                        "Awaiting",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                        ),
                                      )),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            // Expanded(
                            //     flex: 1,
                            //     child: Container(
                            //       height: 40,
                            //       width: Get.width,
                            //       decoration:
                            //           CustomDecoration().buttonDecoration(),
                            //       child: TextButton(
                            //           onPressed: () {
                            //             status = "8";
                            //             msg = "Return Parcel To Merchant";
                            //             updateParcel();
                            //           },
                            //           child: Text(
                            //             "Return To Merchant",
                            //             style: TextStyle(
                            //               color: Colors.white,
                            //               fontSize:
                            //                   ResponsiveFlutter.of(context)
                            //                       .fontSize(2),
                            //             ),
                            //           )),
                            //     )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  height: 40,
                                  width: Get.width,
                                  decoration:
                                      CustomDecoration().buttonDecoration(),
                                  child: TextButton(
                                      onPressed: () {
                                        status = "7";
                                        msg = "Return Parcel To Hub";
                                        updateParcel();
                                      },
                                      child: Text(
                                        "Return To Hub",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                        ),
                                      )),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  height: 40,
                                  width: Get.width,
                                  decoration:
                                      CustomDecoration().buttonDecoration(),
                                  child: TextButton(
                                      onPressed: () {
                                        status = "9";
                                        msg = "Cancel Parcel";
                                        updateParcel();
                                      },
                                      child: Text(
                                        "Cancelled",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                        ),
                                      )),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 40,
                          width: Get.width,
                          decoration: CustomDecoration().buttonDecoration(),
                          child: TextButton(
                              onPressed: () {
                                status = "6";
                                msg = "Partial Delivery";
                                setState(() {
                                  partialDelivery = true;
                                });
                                updateParcel();
                              },
                              child: Text(
                                "Partial Delivery",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      ResponsiveFlutter.of(context).fontSize(2),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ])));
  }

  void updateParcel() {
    String selectedNote;

    Get.defaultDialog(
        title: msg,
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              // Container(
              //   width: Get.width,
              //   child: Text(
              //     "Are your sure that you want to $msg?",
              //     style: TextStyle(
              //       fontSize: ResponsiveFlutter.of(context).fontSize(2),
              //       color: UIColors.blackColor,
              //     ),
              //     textAlign: TextAlign.left,
              //   ),
              // ),
              SizedBox(
                  width: Get.width,
                  child: Text("Note",
                      style: TextStyle(
                          fontSize: ResponsiveFlutter.of(context).fontSize(2),
                          color: UIColors.blackColor),
                      textAlign: TextAlign.left)),
              const SizedBox(
                height: 5,
              ),
              Container(
                // height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                child: DropdownButtonFormField(
                  hint: Text(
                    "Select Note",
                    style: TextStyle(
                        fontSize: ResponsiveFlutter.of(context).fontSize(2),
                        color: Colors.grey.withOpacity(.8)),
                  ), // Not necessary for Option 1
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                  ),
                  validator: (value) =>
                      value == null ? "Please select note" : null,
                  isExpanded: true,
                  value: selectedNote,
                  onChanged: (newValue) {
                    setState(() {
                      selectedNote = newValue;
                    });
                  },
                  items: notes.map((NotesModel value) {
                    return DropdownMenuItem(
                      child: Text(value.title),
                      // value: value.id.toString(),
                      value: value.title.toString(),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              partialDelivery == true
                  ? TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Partial Payment',
                      ),
                      keyboardType: TextInputType.number,
                      controller: partial_payment,
                    )
                  : Container(),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: Get.width,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.5),
                            blurRadius: 4,
                            offset: const Offset(
                                4, 4), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            partialDelivery = false;
                          });
                          Get.back();
                        },
                        child: Text(
                          'No, Cancel',
                          style: TextStyle(
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2),
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      width: Get.width,
                      height: 40,
                      decoration: CustomDecoration().buttonDecoration(),
                      child: TextButton(
                        onPressed: () {
                          if (partialDelivery) {
                            DeliverymanNetwork()
                                .parcelStatusUpdatePartialDelivery(
                                    parcel.id.toString(),
                                    status,
                                    selectedNote,
                                    partial_payment.text);

                            noteController.clear();

                            Get.back();
                          } else {
                            DeliverymanNetwork().parcelStatusUpdate(
                              parcel.id.toString(),
                              status,
                              selectedNote,
                            );

                            noteController.clear();

                            Get.back();
                          }
                        },
                        child: Text(
                          'Yes, Confirm',
                          style: TextStyle(
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2),
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  void generateParcelInvoice() async {
    final pw.Document pdf = pw.Document();

    const imageProvider = const AssetImage('assets/images/logo.png');

    final image = await flutterImageProvider(imageProvider);

    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Container(
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                  // pw.Row(
                  //     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       pw.Text("Parcel Invoice"),
                  //       pw.Text("Invoice- ${parcel.invoiceNo}"),
                  //     ]),
                  // pw.Divider(color: PdfColors.grey),
                  // pw.SizedBox(height: 20),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Image(image, width: 120),
                        pw.BarcodeWidget(
                            barcode: pw.Barcode.qrCode(),
                            data:
                                "https://gofastdelivery.com.bd/track/parcel/${parcel.trackingCode}",
                            width: 70,
                            height: 70),
                      ]),
                  pw.SizedBox(height: 20),
                  pw.Container(
                      width: double.infinity,
                      padding: const pw.EdgeInsets.all(10),
                      decoration: pw.BoxDecoration(
                          border: pw.Border.all(color: PdfColors.grey)),
                      child: pw.Text(
                          DateFormat.yMMMd()
                              .format(DateTime.parse(parcel.createdAt)),
                          style: const pw.TextStyle(fontSize: 18),
                          textAlign: pw.TextAlign.center)),
                  pw.SizedBox(height: 20),
                  pw.Text("MERCHANT : ${parcel.companyName}",
                      style: const pw.TextStyle(fontSize: 15)),
                  pw.Text("0" + parcel.phoneNumber.toString(),
                      style: const pw.TextStyle(fontSize: 15)),
                  pw.SizedBox(height: 20),
                  pw.Text("CUSTOMER : ${parcel.recipientName}",
                      style: const pw.TextStyle(fontSize: 15)),
                  pw.Text("0" + parcel.recipientPhone.toString(),
                      style: const pw.TextStyle(fontSize: 15)),
                  pw.SizedBox(height: 20),
                  pw.Text("ADDRESS : ${parcel.recipientAddress}",
                      style: const pw.TextStyle(fontSize: 15)),
                  pw.SizedBox(height: 20),
                  pw.Text("TRACKING ID : ${parcel.trackingCode}",
                      style: const pw.TextStyle(fontSize: 15)),
                  pw.SizedBox(height: 5),
                  pw.Text("INSTRUCTION",
                      style: const pw.TextStyle(fontSize: 15)),
                  pw.SizedBox(height: 10),
                  pw.Container(
                    width: double.infinity,
                    padding: const pw.EdgeInsets.all(10),
                    decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.black)),
                    child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text("COD",
                                style: const pw.TextStyle(fontSize: 15),
                                textAlign: pw.TextAlign.center),
                          ),
                          pw.Container(
                            width: 2,
                            height: 30,
                            color: PdfColors.black,
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text("TK ${parcel.cod}",
                                style: const pw.TextStyle(fontSize: 15),
                                textAlign: pw.TextAlign.center),
                          ),
                        ]),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Row(children: [
                    pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                            child: pw.Row(children: [
                          pw.Container(
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(color: PdfColors.grey)),
                            height: 10,
                            width: 10,
                          ),
                          pw.SizedBox(width: 20),
                          pw.Text("DELIVERY"),
                        ]))),
                    pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                            child: pw.Row(children: [
                          pw.Container(
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(color: PdfColors.grey)),
                            height: 10,
                            width: 10,
                          ),
                          pw.SizedBox(width: 20),
                          pw.Text("CANCELLED"),
                        ]))),
                    pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                            child: pw.Row(children: [
                          pw.Container(
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(color: PdfColors.grey)),
                            height: 10,
                            width: 10,
                          ),
                          pw.SizedBox(width: 20),
                          pw.Text("HOLD"),
                        ])))
                  ]),
                  pw.SizedBox(height: 20),
                  pw.Divider(color: PdfColors.black),
                  pw.SizedBox(height: 20),
                  pw.Container(
                      width: double.infinity,
                      child: pw.Text(
                          "NOTE: 128 KOLABAGAN , FIRST LANE , DHAKA\nPHONE: +88 01316006760 EMAIL: NFO@GEXCOURIERBD.COM",
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(fontSize: 15)))
                ]))
          ]; // Center
        }));

    String path = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);
    String fullPath = path + "/Parcel_Invoice_${parcel.id}.pdf";
    final File file = File(fullPath);

    if (file.existsSync()) {
      await file.writeAsBytes(await pdf.save());

      Get.snackbar("Already Download", "Invoice already downloaded",
          snackPosition: SnackPosition.TOP,
          backgroundColor: UIColors.primaryColor2,
          colorText: Colors.white,
          duration: const Duration(seconds: 10),
          mainButton: TextButton(
            child: Text(
              "Open",
              style: TextStyle(color: UIColors.primaryColor),
            ),
            onPressed: () {
              OpenFile.open(fullPath);
            },
          ));
    } else {
      try {
        await file.writeAsBytes(await pdf.save());

        Get.snackbar("Download Complete", "Invoice saved into downloads folder",
            snackPosition: SnackPosition.TOP,
            backgroundColor: UIColors.primaryColor2,
            colorText: Colors.white,
            duration: const Duration(seconds: 10),
            mainButton: TextButton(
              child: Text(
                "Open",
                style: TextStyle(color: UIColors.primaryColor),
              ),
              onPressed: () {
                OpenFile.open(fullPath);
              },
            ));
      } catch (e) {
        Get.snackbar("Download Failed", "Something went wrong",
            snackPosition: SnackPosition.TOP,
            backgroundColor: UIColors.primaryColor2,
            colorText: Colors.white,
            duration: const Duration(seconds: 10));
      }
    }
  }
}
