import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_live/screens/admin/Details.dart';
import 'package:ocean_live/screens/admin/payment/edit_payment.dart';
import 'package:ocean_live/screens/admin/payment/view_payment.dart';
import 'package:ocean_live/screens/admin/staff/edit_staff.dart';
import 'package:ocean_live/screens/admin/staff/view_staff.dart';
import 'package:ocean_live/screens/admin/student/edit_student.dart';
import 'package:ocean_live/screens/admin/student/view_student.dart';

class PaymentDb extends StatefulWidget {
  static String pay;
  static String amount;
  static String total;
  static String due;
  static String paid;
  static String next;
  static String paym;

  String student;
  String amountPaid;
  String totalAmount;
  String dueAmount;
  String paidDate;
  String nextDate;
  String payMode;
  PaymentDb(
      {this.nextDate,
      this.paidDate,
      this.amountPaid,
      this.dueAmount,
      this.payMode,
      this.student,
      this.totalAmount});

  @override
  _PaymentDbState createState() => _PaymentDbState();
}

class _PaymentDbState extends State<PaymentDb> {
  // void PayId() async {
  //   print("${StudentDb.paymentId}dropdownnnnnnnnnnn");
  //   await for (var snapshot in _firestore
  //       .collection('student')
  //       .where("studentimage", isEqualTo: widget.studentImage)
  //       .snapshots(includeMetadataChanges: true)) {
  //     for (var message in snapshot.docs) {
  //       //print(message.documentID);
  //       setState(() {
  //         StudentDb.paymentId = message.documentID;
  //       });
  //       print("${StudentDb.paymentId}studentjjjjjjjjjjjjjjjjjjjjjjj");
  //     }
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Color(0xFFDFDFDF), width: 1),
            ),
          ),
          children: [
            CellWidget(
              text: "${widget.student}",
            ),
            CellWidget(text: "${widget.totalAmount}"),
            CellWidget(text: "${widget.amountPaid}"),
            CellWidget(text: "${widget.dueAmount}"),
            CellWidget(text: "${widget.paidDate}"),
            CellWidget(text: "${widget.nextDate}"),
            CellWidget(text: "${widget.payMode}"),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      displayDialog(
                          name: flag == 1
                              ? ViewStaffDetails()
                              : flag == 2
                                  ? ViewStudentDetails()
                                  : ViewPayment(
                                      // student: widget.student,
                                      // totalAmount: widget.totalAmount,
                                      // amountPaid: widget.amountPaid,
                                      // dueAmount: widget.dueAmount,
                                      // paidDate: widget.paidDate,
                                      // payMode: widget.payMode,
                                      // nextDate: widget.nextDate,
                                      ),
                          context: context);
                    },
                    child: Icon(FontAwesomeIcons.elementor, size: 15),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        displayDialog(
                            name: flag == 1
                                ? EditStaffDetails()
                                : flag == 2
                                    ? EditStudent()
                                    : EditPay(
                                        student: widget.student,
                                        totalAmount: widget.totalAmount,
                                        amountPaid: widget.amountPaid,
                                        dueAmount: widget.dueAmount,
                                        paidDate: widget.paidDate,
                                        payMode: widget.payMode,
                                        nextDate: widget.nextDate,
                                      ),
                            context: context);
                      },
                      child: Icon(FontAwesomeIcons.pencilAlt, size: 15)),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      displayDialog(
                          name: DeleteDetails(
                            studentname: widget.student,
                          ),
                          context: context);
                    },
                    child: Icon(FontAwesomeIcons.trashAlt, size: 15),
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
