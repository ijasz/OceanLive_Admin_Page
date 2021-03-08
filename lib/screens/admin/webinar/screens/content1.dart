import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocean_live/screens/admin/webinar/edit_alert/Content1_EditAlert.dart';
import 'package:ocean_live/screens/admin/webinar/upload%20alert/Content1_UploadAlert.dart';
import '../webinar.dart';

/// < Content 1 > ///

final _firestore = FirebaseFirestore.instance;

class Content1 extends StatefulWidget {
  static TextEditingController paymentController = TextEditingController();

  @override
  _Content1State createState() => _Content1State();
}

class _Content1State extends State<Content1> {
  bool _visibility = false;
  String payment;

  Widget _paymentField() {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 40, left: 5),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1, color: Colors.black54)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 1, color: Colors.blueAccent),
        ),
        labelText: 'Payment',
        labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
      ),
      controller: Content1.paymentController,
      onChanged: (value) {
        payment = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Color(0xff0090E9),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                setState(() {
                  _visibility = !_visibility;
                });
              },
              child: Row(
                children: [
                  Icon(
                    Icons.payment_outlined,
                    color: Colors.blue,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Payment Mode',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Visibility(
              visible: _visibility,
              child: Container(height: 40, width: 100, child: _paymentField()),
            ),
            Spacer(),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                displayDialog(name: Content1UploadAlert(), context: context);
              },
              color: Colors.blue,
              child: Row(
                children: [
                  Icon(
                    Icons.download_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Upload',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(width: 20),
            // RaisedButton(
            //   color: Colors.white,
            //   shape: RoundedRectangleBorder(
            //     side: BorderSide(
            //       color: Color(0xff0090E9),
            //       width: 3,
            //     ),
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: Row(
            //     children: [
            //       Icon(
            //         Icons.edit_outlined,
            //         color: Colors.blue,
            //       ),
            //       SizedBox(width: 5),
            //       Padding(
            //         padding: EdgeInsets.all(10),
            //         child: Text(
            //           'Edit',
            //           style: TextStyle(
            //             fontSize: 17,
            //             color: Color(0xff0090E9),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            //   textColor: Colors.white,
            //   onPressed: () {
            //     displayDialog(context: context, name: Content1EditAlert());
            //   },
            // ),
            SizedBox(width: 20),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Color(0xff0090E9),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.date_range_outlined,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 5),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Date and Time',
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xff0090E9),
                      ),
                    ),
                  ),
                ],
              ),
              textColor: Colors.white,
              onPressed: () {
                // DateTimePicker();
              },
            ),
          ],
        ),
        SizedBox(height: 50),
      ],
    );
  }
}
