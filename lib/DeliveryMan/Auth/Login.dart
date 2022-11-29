/*
Author: QuickTech IT
Author URI: http://quicktech-ltd.com;
Description: QuickTech IT maintain standard quality for Website and Creative Design
*/

import 'package:courier/GlobalUtils/Decoration.dart';
import 'package:courier/GlobalUtils/UI_Colors.dart';
import 'package:courier/Network/DeliverymanNetwork.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

// ignore: camel_case_types
class QuickTechIT_DeliveryManLogin extends StatefulWidget {
  @override
  _QuickTechIT_DeliveryManLoginState createState() =>
      _QuickTechIT_DeliveryManLoginState();
}

// ignore: camel_case_types
class _QuickTechIT_DeliveryManLoginState
    extends State<QuickTechIT_DeliveryManLogin> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.pageBackground,
      body: Container(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // FractionallySizedBox(
                  //   widthFactor: .7,
                  //   child: Container(
                  //     child: Image.asset('assets/images/logo.png'),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 50,
                  // ),
                  Container(
                    width: Get.width,
                    child: Text(
                      "Deliveryman Login",
                      style: TextStyle(
                          color: UIColors.blackColor,
                          fontSize: ResponsiveFlutter.of(context).fontSize(3.5),
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
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2),
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
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: UIColors.primaryColor,
                                ),
                                hintStyle: TextStyle(
                                    color: Colors.grey.withOpacity(.8)),
                                hintText: "Email"),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: Get.width,
                          child: Text(
                            "Password",
                            style: TextStyle(
                              color: UIColors.blackColor,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2),
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
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            controller: passwordController,
                            validator: (value) {
                              if (value.length == 0) {
                                return "Please enter your password";
                              } else
                                return null;
                            },
                            decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.lock_rounded,
                                  color: UIColors.primaryColor,
                                ),
                                hintStyle: TextStyle(
                                    color: Colors.grey.withOpacity(.8)),
                                hintText: "Password"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed('/deliveryman/password/reset');
                          },
                          child: Container(
                            width: Get.width,
                            child: Text(
                              "Forget Password",
                              style: TextStyle(
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(1.8),
                                color: UIColors.primaryColor,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
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
                                DeliverymanNetwork().login(emailController.text,
                                    passwordController.text, false);
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: ResponsiveFlutter.of(context)
                                      .fontSize(2.2),
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
