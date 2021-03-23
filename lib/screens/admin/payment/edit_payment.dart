import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:ocean_live/screens/admin/notification/send_notification.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ocean_live/screens/admin/Details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _firestore = FirebaseFirestore.instance;

class EditPay extends StatefulWidget {
  String student;
  String amountPaid;
  String totalAmount;
  String dueAmount;
  String paidDate;
  String nextDate;
  String payMode;
  EditPay(
      {this.nextDate,
      this.paidDate,
      this.amountPaid,
      this.dueAmount,
      this.payMode,
      this.student,
      this.totalAmount});
  @override
  _EditPayState createState() => _EditPayState();
}

class _EditPayState extends State<EditPay> {
  String editPayment;
  String subPayment;

  void paymentid() async {
    await for (var snapshot in _firestore
        .collection('student')
        .doc(editPayment)
        .collection("payment")
        .where("name", isEqualTo: name.text)
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        //print(message.documentID);
        subPayment = message.documentID;
        print("${subPayment}jayaaaa");
      }
    }
  }

  void studentpaymentid() async {
    await for (var snapshot in _firestore
        .collection('student')
        .where("studentname", isEqualTo: widget.student)
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        //print(message.documentID);
        editPayment = message.documentID;
        print("${editPayment}latha");
      }
      paymentid();
    }
  }

  TextEditingController name;
  TextEditingController total;
  TextEditingController paid;
  TextEditingController due;
  TextEditingController paidDate;
  TextEditingController nextDate;
  TextEditingController mode;
  bool isTotal = false,
      isPaid = false,
      isDue = false,
      isDate = false,
      isNextDate = false,
      isMode = false,
      isName = false;
  var paymentEditId = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    studentpaymentid();
    name = TextEditingController(text: widget.student);
    total = TextEditingController(text: widget.totalAmount);
    paid = TextEditingController(text: widget.amountPaid);
    due = TextEditingController(text: widget.dueAmount);
    paidDate = TextEditingController(text: widget.paidDate);
    nextDate = TextEditingController(text: widget.nextDate);
    mode = TextEditingController(text: widget.payMode);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: EdgeInsets.all(3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: closeIcon(context),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 80,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 50.0),
                  child: Text(
                    "Total Amount",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                )),
                Expanded(
                  flex: 2,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: total,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: customDecor(),
                          style: TextStyle(fontSize: 20),
                        ),
                        toggleError(isTotal)
                      ]),
                ),
                SizedBox(
                  width: 100,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 80,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 50.0),
                  child: Text(
                    "Amount Paid",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                )),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: paid,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: customDecor(),
                        style: TextStyle(fontSize: 20),
                      ),
                      toggleError(isPaid),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 80,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 50.0),
                  child: Text(
                    "Due Amount",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                )),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: due,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: customDecor(),
                        style: TextStyle(fontSize: 20),
                      ),
                      toggleError(isDue),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 80,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 50.0),
                  child: Text(
                    "Paid Date",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                )),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: paidDate,
                        readOnly: true,
                        decoration: customIconDecor(
                            icon: Icon(FontAwesomeIcons.calendarAlt),
                            context: context),
                        style: TextStyle(fontSize: 20),
                      ),
                      toggleError(isDate)
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 80,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 50.0),
                  child: Text(
                    "Next Payment Date",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                )),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: nextDate,
                        readOnly: true,
                        decoration: customIconDecor(
                            icon: Icon(FontAwesomeIcons.calendarAlt),
                            context: context),
                        style: TextStyle(fontSize: 20),
                      ),
                      toggleError(isNextDate)
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 80,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 50.0),
                  child: Text(
                    "Payment Mode",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                )),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: mode,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp("[A-Za-z ]{1,32}"))
                        ],
                        decoration: customDecor(),
                        style: TextStyle(fontSize: 20),
                      ),
                      toggleError(isMode)
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                dynamicSizeButton(
                    text: "Save Details",
                    onPress: () {
                      _firestore
                          .collection("student")
                          .doc(editPayment)
                          .collection("payment")
                          .doc(subPayment)
                          .set({
                        "name": name.text,
                        "totalamount": total.text,
                        "amountpaid": paid.text,
                        "dueamount": due.text,
                        "paiddate": paidDate.text,
                        "nextpaymentdate": nextDate.text,
                        "paymentmode": mode.text,
                      });
                      Navigator.pop(context);
                      // setState(() {
                      //   isTotal = total.text.isEmpty;
                      //   print(isTotal);
                      //   isPaid = paid.text.isEmpty;
                      //   isDue = due.text.isEmpty;
                      //   isDate = paidDate.text.isEmpty;
                      //   isNextDate = nextDate.text.isEmpty;
                      //   isMode = mode.text.isEmpty;
                      // });
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
