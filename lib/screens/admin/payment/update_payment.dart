import 'package:flutter/services.dart';
import 'package:ocean_live/screens/admin/student/student_db.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_live/screens/admin/Details.dart';
import 'package:ocean_live/screens/admin/notification/send_notification.dart';
final _firestore = FirebaseFirestore.instance;
class UpdatePayment extends StatefulWidget {
  @override
  _UpdatePaymentState createState() => _UpdatePaymentState();
}

class _UpdatePaymentState extends State<UpdatePayment> {
  TextEditingController name = TextEditingController();
  TextEditingController total = TextEditingController();
  TextEditingController paid = TextEditingController();
  TextEditingController due = TextEditingController();
  TextEditingController paidDate = TextEditingController();
  TextEditingController nextDate = TextEditingController();
  TextEditingController mode = TextEditingController();
  bool isTotal = false,
      isPaid = false,
      isDue = false,
      isDate = false,
      isNextDate = false,
      isMode = false,
      isName = false;

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
                        "Name",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                    )),
                Expanded(
                  flex: 2,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: name,
                          decoration: customDecor(),
                          style: TextStyle(fontSize: 20),
                        ),
                        toggleError(isName)
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
                        readOnly: false,
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
                        readOnly: false,
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
                          .doc(StudentDb.paymentId)
                          .collection("payment")
                          .add({
                        "name": name.text,
                        "totalAmount": total.text,
                        "amountPaid": paid.text,
                        "dueAmount": due.text,
                        "paidDate": paidDate.text,
                        "nextPayment": nextDate.text,
                        "payMode": mode.text,
                      });
                      Navigator.pop(context);
                      setState(() {
                        isTotal = total.text.isEmpty;
                        print(isTotal);
                        isPaid = paid.text.isEmpty;
                        isDue = due.text.isEmpty;
                        isDate = paidDate.text.isEmpty;
                        isNextDate = nextDate.text.isEmpty;
                        isMode = mode.text.isEmpty;
                      });
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
Text _heading({text}) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 18, color: Color(0xFF555454), fontWeight: FontWeight.w600),
  );
}