/*
Author: QuickTech IT
Author URI: http://quicktech-ltd.com;
Description: QuickTech IT maintain standard quality for Website and Creative Design
*/

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courier/DeliveryMan/Auth/ForgetPassword.dart';
import 'package:courier/DeliveryMan/Auth/Login.dart';
import 'package:courier/DeliveryMan/Auth/PasswordVerify.dart';
import 'package:courier/DeliveryMan/Dashboard/Dashboard.dart';
import 'package:courier/DeliveryMan/Parcel/Parcel.dart';
import 'package:courier/DeliveryMan/Parcel/ParcelDetails.dart';
import 'package:courier/DeliveryMan/Pickup/Pickup.dart';
import 'package:courier/DeliveryMan/Pickup/PickupDetails.dart';
import 'package:courier/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart' as loc;

data() async {
  // Timer.periodic(
  //   Duration(seconds: 1),
  //   (timer) {
  //     log("message");
  //   },
  // );
  await FirebaseFirestore.instance
      .collection('data')
      .doc('${pref.read('userId')}')
      .set(
    {
      'lat': " currentlocation.latitude",
      'lon': "currentlocation.longitude",
      'name': "pref.read('userName')",
      'parcelid': "parcelid",
      'userId': "pref.read('userId')",
    },
    // SetOptions(merge: true),
  ).then((value) {
    log("data");
  });
}

final loc.Location location = loc.Location();
StreamSubscription<loc.LocationData> locationsubscription;
final pref = GetStorage();

Future<void> livelocation(String parcelid) async {
  log("Parcel Id from main $parcelid");
  locationsubscription = location.onLocationChanged.handleError((onError) {
    print(onError);
    locationsubscription?.cancel();
  }).listen((loc.LocationData currentlocation) async {
    Timer.periodic(Duration(seconds: 30), (timer) async {
      log(pref.read('userId').toString());
      await FirebaseFirestore.instance
          .collection('trackParcel')
          .doc('${pref.read('userId')}')
          .set(
        {
          'lat': currentlocation.latitude,
          'lon': currentlocation.longitude,
          'name': pref.read('userName'),
          'parcelid': parcelid,
          'userId': pref.read('userId'),
        },
        // SetOptions(merge: true),
      );
    });
    // await FirebaseFirestore.instance
    //     .collection('trackParcel')
    //     .doc(parcelid.toString())
    //     .set(
    //   {
    //     'lat': currentlocation.latitude,
    //     'lon': currentlocation.longitude,
    //     'name': pref.read('userName'),
    //     'parcelid': parcelid,
    //   },
    //   // SetOptions(merge: true),
    // );
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await GetStorage.init();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  HttpOverrides.global = MyHttpOverrides();

  runApp(GetMaterialApp(
    initialRoute: '/',
    defaultTransition: Transition.fade,
    getPages: [
      GetPage(
        name: '/',
        page: () => QuickTechIT_SplashScreen(),
      ),
      GetPage(
        name: '/deliveryman/login',
        page: () => QuickTechIT_DeliveryManLogin(),
        transition: Transition.zoom,
      ),
      GetPage(
        name: '/deliveryman/password/reset',
        page: () => QuickTechIT_DeliverymanForgetPassword(),
      ),
      GetPage(
        name: '/deliveryman/password/verify/:id',
        page: () => QuickTechIT_DeliverymanPasswordVerify(),
      ),
      GetPage(
        name: '/deliveryman/home',
        page: () => QuickTechIT_DeliverymanDashboard(),
      ),
      GetPage(
        name: '/deliveryman/pickup',
        page: () => QuickTechIT_DeliverymanPickup(),
      ),
      GetPage(
        name: '/deliveryman/parcel/:type',
        page: () => QuickTechIT_DeliverymanParcel(),
      ),
      GetPage(
        name: '/deliveryman/parcel/details/:parcelId',
        page: () => QuickTechIT_DeliverymanParcelDetails(),
      ),
      GetPage(
        name: '/deliveryman/pickup/details/:pickupId',
        page: () => QuickTechIT_DeliverymanPickupDetails(),
      ),
    ],
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
