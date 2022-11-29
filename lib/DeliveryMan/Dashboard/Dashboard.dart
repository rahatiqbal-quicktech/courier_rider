/*
Author: QuickTech IT
Author URI: http://quicktech-ltd.com;
Description: QuickTech IT maintain standard quality for Website and Creative Design
*/

import 'dart:async';

import 'package:courier/DeliveryMan/Utils/BottomBar.dart';
import 'package:courier/DeliveryMan/Utils/NavigationDrawer.dart';
import 'package:courier/GlobalUtils/UI_Colors.dart';
import 'package:courier/Models/DeliverymanDashboardModel.dart';
import 'package:courier/Network/DeliverymanNetwork.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

// ignore: camel_case_types
class QuickTechIT_DeliverymanDashboard extends StatefulWidget {
  const QuickTechIT_DeliverymanDashboard({Key key}) : super(key: key);

  @override
  _QuickTechIT_DeliverymanDashboardState createState() =>
      _QuickTechIT_DeliverymanDashboardState();
}

// ignore: camel_case_types
class _QuickTechIT_DeliverymanDashboardState
    extends State<QuickTechIT_DeliverymanDashboard> {
  DeliverymanDashboardModel report;

  Timer _timer;

  @override
  void initState() {
    getData();

    _timer = Timer.periodic(const Duration(seconds: 15), (_) => getData());

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  getData() {
    DeliverymanNetwork().getDashboardData().then((value) {
      setState(() {
        report = value;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      primary: true,
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
        title: Text(GetStorage().read('userName')),
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
      body: Container(
        // decoration: BoxDecoration(image: CustomDecoration().watermark()),
        child: SafeArea(
          child: report == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        // Container(
                        //   width: Get.width,
                        //   child: Text(
                        //     "Order Overall Status",
                        //     style: TextStyle(
                        //         fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
                        //         fontWeight: FontWeight.bold),
                        //     textAlign: TextAlign.center,
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // TextButton(
                        //   onPressed: () {
                        //     data();
                        //   },
                        //   child: Text("data"),
                        // ),
                        GridView.count(
                          shrinkWrap: true,
                          primary: false,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                          crossAxisCount: 2,
                          childAspectRatio: 1.4,
                          children: <Widget>[
                            singleReports(
                                "Total Pending", report.totalPending, 2),
                            singleReports(
                                "Total Awaiting", report.totalInTransit, 1),
                            singleReports(
                                "Total Parcel", report.totalParcel, 0),
                            singleReports(
                                "Total Picked", report.totalPickup, 4),
                            singleReports(
                                "Total Delivered", report.totalDelivery, 1),
                            singleReports("Total Hold", report.totalHold, 2),
                            singleReports(
                                "Total Cancelled", report.totalCancel, 3),
                            singleReports(
                                "Returned Pending", report.returnPending, 4),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: Get.width,
                          child: Text(
                            "Payment Overall Status",
                            style: TextStyle(
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(2.5),
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          primary: false,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                          crossAxisCount: 2,
                          childAspectRatio: 1.5,
                          children: <Widget>[
                            singleReports2(
                                "Total Amount", report.totalAmount, 5),
                            singleReports2("Paid Amount", report.paidAmount, 2),
                            singleReports2(
                                "Unpaid Amount", report.unpaidAmount, 3),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  List<Color> colors = [
    // Colors.black,
    // Colors.green,
    // Colors.teal,
    // Colors.orange,
    // Colors.blue,
    // Colors.pinkAccent
    const Color(0xFF1d2941),
    const Color(0xFF5f45da),
    const Color(0xFF670a91),
    const Color(0xFF096709),
    const Color(0xFF1f6e91),
    const Color(0xFFde3163),
    const Color(0xFFf012be),
  ];

  singleReports(String title, int value, int index) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colors[index],
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: colors[index].withOpacity(.5),
            blurRadius: 4,
            offset: const Offset(4, 4), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title == null ? "" : title,
            style: TextStyle(
                color: Colors.white,
                fontSize: ResponsiveFlutter.of(context).fontSize(2.2)),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            value == null ? "" : value.toString(),
            style: TextStyle(
                color: Colors.white,
                fontSize: ResponsiveFlutter.of(context).fontSize(3.5)),
          )
        ],
      ),
    );
  }

  singleReports2(String title, int value, int index) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colors[index],
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: colors[index].withOpacity(.5),
            blurRadius: 4,
            offset: const Offset(4, 4), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title ?? "",
            style: TextStyle(
                color: Colors.white,
                fontSize: ResponsiveFlutter.of(context).fontSize(2)),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            value == null ? "" : value.toString(),
            style: TextStyle(
                color: Colors.white,
                fontSize: ResponsiveFlutter.of(context).fontSize(3.5)),
          )
        ],
      ),
    );
  }
}
