import 'package:courier/GlobalUtils/UI_Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class CustomDialog {
  BuildContext context;
  String title;
  String body;
  bool isOkButton;
  String okButtonText;
  VoidCallback okButtonClick;
  bool isCancelButton;
  String cancelButtonText;
  VoidCallback cancelButtonClick;

  CustomDialog(this.context,
      {this.title,
      this.body,
      this.isOkButton,
      this.okButtonText,
      this.okButtonClick,
      this.isCancelButton,
      this.cancelButtonText,
      this.cancelButtonClick}) {
    dataValidator();
  }

  void dataValidator() {
    if (title == null) {
      title = "Title";
    }
    if (body == null) {
      body = "Body shows here";
    }
    if (isOkButton == null) {
      isOkButton = false;
    }
    if (okButtonText == null) {
      okButtonText = "OK";
    }
    if (okButtonClick == null) {
      okButtonClick = () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      };
    }
    if (isCancelButton == null) {
      isCancelButton = false;
    }
    if (cancelButtonText == null) {
      cancelButtonText = "Cancel";
    }
    if (cancelButtonClick == null) {
      cancelButtonClick = () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      };
    }
  }

  void show() {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              backgroundColor: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    color: UIColors.primaryColor,
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      body,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize:
                              ResponsiveFlutter.of(context).fontSize(2.2)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isCancelButton)
                        Container(
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: UIColors.primaryColor)),
                          child: TextButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(5.0)),
                                overlayColor:
                                    MaterialStateProperty.all(Colors.grey)),
                            onPressed: cancelButtonClick,
                            child: Text(
                              cancelButtonText,
                              style: TextStyle(
                                  fontSize:
                                      ResponsiveFlutter.of(context).fontSize(2),
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      if (isCancelButton && isOkButton)
                        SizedBox(
                          width: 5,
                        ),
                      if (isOkButton)
                        Container(
                          height: 35,
                          decoration: BoxDecoration(
                            color: UIColors.primaryColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.all(5.0)),
                            ),
                            onPressed: okButtonClick,
                            child: Text(
                              okButtonText,
                              style: TextStyle(
                                  fontSize:
                                      ResponsiveFlutter.of(context).fontSize(2),
                                  color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ));
  }
}
