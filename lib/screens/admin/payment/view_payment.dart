import 'package:flutter/material.dart';
import 'package:ocean_live/screens/admin/Details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class ViewPayment extends StatefulWidget {
  String email;
  String studentname;
  ViewPayment({this.email, this.studentname});
  static bool isPay = false;

  @override
  _ViewPaymentState createState() => _ViewPaymentState();
}

class _ViewPaymentState extends State<ViewPayment> {
  String studentid;
  void studentId() async {
    await for (var snapshot in _firestore
        .collection('new users')
        .where("E Mail", isEqualTo: widget.email)
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        studentid = message.documentID;
        print("${studentid}paymentStudent");
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    studentId();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              closeIcon(context),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
              child: Text("Show Payment"),
              onPressed: () {
                setState(() {
                  ViewPayment.isPay = true;
                });
              }),
          SizedBox(
            height: 20,
          ),
          Visibility(
            visible: true,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Table(
                    defaultColumnWidth: IntrinsicColumnWidth(),
                    children: [
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 80),
                          child: Text(
                            "Name",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 160),
                          child: Text(
                            "widget.student",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 80),
                          child: Text(
                            "Total Amount",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 160),
                          child: Text(
                            " widget.totalAmount",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 80),
                          child: Text(
                            "Amount Paid",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 160),
                          child: Text(
                            " widget.amountPaid",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 80),
                          child: Text(
                            "Due Amount",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 160),
                          child: Text(
                            "widget.dueAmount",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 80),
                          child: Text(
                            "Paid Date",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 160),
                          child: Text(
                            " widget.paidDate",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 80),
                          child: Text(
                            "Next Payment Date",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 160),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("widget.nextDate",
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        )
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 80),
                          child: Text(
                            "Payment Mode",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 160),
                          child: Text(
                            "widget.payMode",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ViewPaymentDb extends StatefulWidget {
  String student;
  String amountPaid;
  String totalAmount;
  String dueAmount;
  String paidDate;
  String nextDate;
  String payMode;

  ViewPaymentDb(
      {this.nextDate,
      this.paidDate,
      this.amountPaid,
      this.dueAmount,
      this.payMode,
      this.student,
      this.totalAmount});
  @override
  _ViewPaymentDbState createState() => _ViewPaymentDbState();
}

class _ViewPaymentDbState extends State<ViewPaymentDb> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Table(
              defaultColumnWidth: IntrinsicColumnWidth(),
              children: [
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 80),
                    child: Text(
                      "Name",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 160),
                    child: Text(
                      widget.student,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 80),
                    child: Text(
                      "Total Amount",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 160),
                    child: Text(
                      widget.totalAmount,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 80),
                    child: Text(
                      "Amount Paid",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 160),
                    child: Text(
                      widget.amountPaid,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 80),
                    child: Text(
                      "Due Amount",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 160),
                    child: Text(
                      widget.dueAmount,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 80),
                    child: Text(
                      "Paid Date",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 160),
                    child: Text(
                      widget.paidDate,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 80),
                    child: Text(
                      "Next Payment Date",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 160),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.nextDate, style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  )
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 80),
                    child: Text(
                      "Payment Mode",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 160),
                    child: Text(
                      widget.payMode,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
