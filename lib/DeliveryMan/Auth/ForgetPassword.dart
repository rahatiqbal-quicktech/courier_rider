/*
Author: QuickTech IT
Author URI: http://quicktech-ltd.com;
Description: QuickTech IT maintain standard quality for Website and Creative Design
*/

import 'dart:ui';

import 'package:courier/GlobalUtils/Decoration.dart';
import 'package:courier/GlobalUtils/UI_Colors.dart';
import 'package:courier/Network/DeliverymanNetwork.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

// ignore: camel_case_types
class QuickTechIT_DeliverymanForgetPassword extends StatefulWidget {
  QuickTechIT_DeliverymanForgetPasswordState createState() =>
      QuickTechIT_DeliverymanForgetPasswordState();
}

// ignore: camel_case_types
class QuickTechIT_DeliverymanForgetPasswordState
    extends State<QuickTechIT_DeliverymanForgetPassword> {
  TextEditingController emailController = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.pageBackground,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FractionallySizedBox(
                    widthFactor: .7,
                    child: Image.network(
                        "https://image.freepik.com/free-vector/forgot-password-concept-illustration_114360-1010.jpg")),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: Get.width,
                  child: Text(
                    "Forget Password",
                    style: TextStyle(
                        color: UIColors.blackColor,
                        fontSize: ResponsiveFlutter.of(context).fontSize(4),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: Get.width,
                        child: Text(
                          'Email',
                          style: TextStyle(
                            color: UIColors.blackColor,
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: CustomDecoration().textFieldDecoration(),
                        child: TextFormField(
                          controller: emailController,
                          validator: (email) {
                            if (email.length == 0) {
                              return "Please enter your email";
                            } else if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(email))
                              return "Please enter an valid email";
                            else
                              return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              prefixIcon: Icon(
                                Icons.email,
                                color: UIColors.primaryColor,
                              ),
                              border: InputBorder.none,
                              hintStyle:
                                  TextStyle(color: Colors.grey.withOpacity(.8)),
                              hintText: "Email"),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: Get.width,
                        decoration: CustomDecoration().buttonDecoration(),
                        child: TextButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.all(8.0))),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              DeliverymanNetwork()
                                  .passwordReset(emailController.text);
                            }
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(2.2),
                                color: Colors.white),
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
      ),
    );
  }
}
