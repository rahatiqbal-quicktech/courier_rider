import 'package:courier/GlobalUtils/UI_Colors.dart';
import 'package:courier/Network/DeliverymanNetwork.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationDrawer extends StatefulWidget {
  NavigationDrawerState createState() => NavigationDrawerState();
}

class NavigationDrawerState extends State<NavigationDrawer> {
  final pref = GetStorage();

  List<String> parcelTypes = [];

  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    parcelTypes.clear();
    parcelTypes.add("0");
    int i = 1;
    do {
      parcelTypes.add(i.toString());
      i++;
    } while (pref.read(i.toString()) != null);
    super.didChangeDependencies();
  }

  _launchURL() async {
    const url = 'https://quicktech-ltd.com/';
    if (await canLaunch(url)) {
      await launch(
        url,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: Container(
        color: UIColors.pageBackground,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: UIColors.primaryColor,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(20),
                        ),
                      ),
                      width: Get.width,
                      padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
                      child: Column(
                        children: [
                          Text(
                            pref.read('userName'),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: ResponsiveFlutter.of(context)
                                    .fontSize(3.2)),
                          ),
                          Text(
                            "${pref.read('userPhone').toString()}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ResponsiveFlutter.of(context)
                                    .fontSize(2.5)),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      dense: true,
                      title: Text(
                        'Dashboard',
                        style: TextStyle(
                            color: UIColors.blackColor,
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      ),
                      leading: Icon(
                        Icons.home,
                        color: UIColors.blackColor,
                      ),
                      onTap: () {
                        Get.offAndToNamed('/deliveryman/home');
                      },
                    ),
                    ExpansionTile(
                      title: Text(
                        'My Parcels',
                        style: TextStyle(
                            color: UIColors.blackColor,
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      ),
                      leading: Icon(
                        Icons.shopping_bag,
                        color: UIColors.blackColor,
                      ),
                      children: parcelTypes.map((String i) {
                        if (i == "0") {
                          return ListTile(
                            dense: true,
                            title: Text(
                              "All",
                              style: TextStyle(
                                  color: UIColors.blackColor,
                                  fontSize: ResponsiveFlutter.of(context)
                                      .fontSize(2)),
                            ),
                            onTap: () {
                              Get.offAndToNamed('/deliveryman/parcel/$i');
                            },
                          );
                        } else {
                          return ListTile(
                            dense: true,
                            title: Text(
                              pref.read(i),
                              style: TextStyle(
                                  color: UIColors.blackColor,
                                  fontSize: ResponsiveFlutter.of(context)
                                      .fontSize(2)),
                            ),
                            onTap: () {
                              Get.offAndToNamed('/deliveryman/parcel/$i');
                            },
                          );
                        }
                      }).toList(),
                    ),
                    ListTile(
                      dense: true,
                      title: Text(
                        'Pickup Manage',
                        style: TextStyle(
                            color: UIColors.blackColor,
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      ),
                      leading: Icon(
                        Icons.directions_bike,
                        color: UIColors.blackColor,
                      ),
                      onTap: () {
                        Get.offAndToNamed('/deliveryman/pickup');
                      },
                    ),
                    ListTile(
                      dense: true,
                      title: Text(
                        'Logout',
                        style: TextStyle(
                            color: UIColors.blackColor,
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2)),
                      ),
                      leading: Icon(
                        Icons.logout,
                        color: UIColors.blackColor,
                      ),
                      onTap: () {
                        DeliverymanNetwork().logout();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
