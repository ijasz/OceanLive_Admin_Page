import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_live/screens/admin/batch_syllabus.dart';
import 'package:ocean_live/screens/admin/course.dart';
import 'package:ocean_live/screens/admin/course/view_course.dart';
import 'package:ocean_live/screens/admin/payment/payment_db.dart';
import 'package:ocean_live/screens/admin/payment/update_payment.dart';
import 'package:ocean_live/screens/admin/staff/staff_db.dart';
import 'package:ocean_live/screens/admin/staff/update_satff.dart';
import 'package:ocean_live/screens/admin/student/student_db.dart';
import 'package:ocean_live/screens/admin/student/update_student.dart';

import '../../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
int flag = 0;

class Details extends StatelessWidget {
  List<String> heading = [];
  List<Widget> head = [];
  Details({
    @required this.text,
  }) {
    heading.clear();
    if (text.toLowerCase() == "staff") {
      head.add(HeadingWidget(
        text: "Photo",
      ));
      head.add(HeadingWidget(
        text: "Staff Name",
      ));
      head.add(HeadingWidget(
        text: "Mobile Number",
      ));
      head.add(HeadingWidget(
        text: "Email Id",
      ));
      head.add(HeadingWidget(
        text: "DOB",
      ));
      head.add(HeadingWidget(
        text: "DOJ",
      ));
      head.add(HeadingWidget(
        text: "Address",
      ));
      head.add(HeadingWidget(
        text: "Qualification",
      ));
      head.add(HeadingWidget(
        text: "",
      ));
    } else if (text.toLowerCase() == "student") {
      head.add(HeadingWidget(
        text: "Photo",
      ));
      head.add(HeadingWidget(
        text: "Student Name",
      ));
      head.add(HeadingWidget(
        text: "Mobile Number",
      ));
      head.add(HeadingWidget(
        text: "Email Id",
      ));
      head.add(HeadingWidget(
        text: "DOB",
      ));
      head.add(HeadingWidget(
        text: "State",
      ));
      head.add(HeadingWidget(
        text: "Gender",
      ));
      head.add(HeadingWidget(
        text: "Qualification",
      ));
      head.add(HeadingWidget(
        text: "",
      ));
    } else {
      head.add(HeadingWidget(
        text: "Student Name",
      ));
      head.add(HeadingWidget(
        text: "Total Amount",
      ));
      head.add(HeadingWidget(
        text: "Amount Paid",
      ));
      head.add(HeadingWidget(
        text: "Due Amount",
      ));
      head.add(HeadingWidget(
        text: "Paid Date",
      ));
      head.add(HeadingWidget(
        text: "Next Payment Date",
      ));
      head.add(HeadingWidget(
        text: "Payment Mode",
      ));
      head.add(HeadingWidget(
        text: "Payment Mode",
        isvisible: false,
      ));
    }
  }

  final String text;

  @override
  Widget build(BuildContext context) {
    flag = (text.toLowerCase() == "staff")
        ? 1
        : (text.toLowerCase() == "student")
            ? 2
            : 3;

    return
        //
        // BatchSchedule();
        Expanded(
      flex: 6,
      child: Padding(
        padding: pagePadding,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  searchWidget(text: text),
                  SizedBox(
                    width: 200.0,
                  ),
                  aCustomButtom(
                      text: "Upload new",
                      iconData: FontAwesomeIcons.plusCircle,
                      buttonClick: () {
                        displayDialog(
                            name: flag == 1
                                ? UpdateStaffDetails()
                                : flag == 2
                                    ? UpdateStudentDetails()
                                    : UpdatePayment(),
                            context: context);
                      }),
                ],
              ),
              Table(
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Color(0xFFDFDFDF), width: 1),
                      ),
                    ),
                    children: head,
                  ),
                ],
              ),
              TableWidget(
                title: heading,
              ),
            ],
          ),
        ),
      ),
    );

    BatchSyllebus();
  }
}

Container searchWidget({String text}) {
  if (!text.startsWith("c")) {
    text += " Details";
  }
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
    width: 907,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xFFF2F3F5),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Search ${text[0].toUpperCase() + text.substring(1).toLowerCase()}",
          style: TextStyle(
              color: Color(0xFF555454),
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ),
        Row(
          children: [
            DropDownWidget(),
            SizedBox(
              width: 25,
            ),
            Icon(FontAwesomeIcons.search),
          ],
        ),
      ],
    ),
  );
}

class DropDownWidget extends StatefulWidget {
  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String dropdownValue = 'Search By';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      width: 200,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: Icon(FontAwesomeIcons.angleDown),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(
            color: Color(0XFF555454),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: <String>['Search By', 'Course', 'Name', 'Date']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                width: 150,
                child: Text(
                  value,
                  style: TextStyle(
                      fontWeight: value == "Search By"
                          ? FontWeight.bold
                          : FontWeight.normal),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

Widget dynamicSizeButton({text, onPress}) {
  return SizedBox(
    child: RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: onPress,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          text,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      color: Color(0xFF0090E9),
    ),
  );
}

Widget button({text, onPress, fontSize = 20, paddingSize = 10, width = 130}) {
  return SizedBox(
    width: width,
    child: RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: onPress,
      child: Padding(
        padding: EdgeInsets.all(paddingSize),
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize, color: Colors.white),
        ),
      ),
      color: Color(0xFF0090E9),
    ),
  );
}

Widget outlinebutton(
    {text, onPress, fontSize = 20, paddingSize = 10, width = 130}) {
  return SizedBox(
    width: width,
    child: RaisedButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.blue, width: 4),
      ),
      onPressed: onPress,
      child: Padding(
        padding: EdgeInsets.all(paddingSize),
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize),
        ),
      ),
    ),
  );
}

class DeleteDetails extends StatefulWidget {
  DeleteDetails(
      {this.trainername,
      this.email,
      this.address,
      this.dateofbirth,
      this.dateofjoining,
      this.mobilenumber,
      this.qualification,
      this.mode,
      this.trainerImage,
      this.studentImage,
      this.studentname,
      this.coursename});
  String trainername;
  String address;
  String mobilenumber;
  String email;
  String qualification;
  String dateofbirth;
  String dateofjoining;
  String trainerImage;
  String studentImage;
  String studentname;
  String coursename;
  String mode;
  @override
  _DeleteDetailsState createState() => _DeleteDetailsState();
}

class _DeleteDetailsState extends State<DeleteDetails> {
  String deleteStaff;
  String deleteStudent;

  String deleteSubpay;
  void deleteStaffMethod() async {
    await for (var snapshot in _firestore
        .collection('staff')
        .where("trainerimage", isEqualTo: widget.trainerImage)
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        //print(message.documentID);
        print("${deleteStaff}deletestaff");
      }
    }
  }

  void studentId() async {
    await for (var snapshot in _firestore
        .collection('new users')
        .where("E Mail", isEqualTo: widget.email)
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        deleteStudent = message.documentID;
        print("${deleteStudent}deleteStudent");
      }
    }
  }

  String deletePayment;
  void payId() async {
    await for (var snapshot in _firestore
        .collection('new users')
        .where("studentname", isEqualTo: widget.studentname)
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        //print(message.documentID);
        deletePayment = message.documentID;
        print("${deletePayment}ppppppppppppppp");
        print("${widget.studentname}nnnnnnnnnnnnn");

        await for (var variable in _firestore
            .collection('new users')
            .doc(deletePayment)
            .collection("payment")
            .snapshots(includeMetadataChanges: true)) {
          for (var message in variable.docs) {
            print(message.documentID);
            deleteSubpay = message.documentID;
            print("${deleteSubpay}deleteeee");
            print("jaya");
          }
        }
      }
    }
  }

  // void subcourseId() async {
  //   await for (var snapshot in _firestore
  //       .collection('student')
  //       .doc(deletePayment)
  //       .collection("payment")
  //       .snapshots(includeMetadataChanges: true)) {
  //     for (var message in snapshot.docs) {
  //       print(message.documentID);
  //       deleteSubpay = message.documentID;
  //       print("${deleteSubpay}deleteeee");
  //       print("${deleteCourse}deleteeee");
  //     }
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    deleteStaffMethod();
    studentId();
    payId();

    // courseId();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Icon(
            FontAwesomeIcons.trashAlt,
            size: 90,
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            "Are you Sure want to delete this ?",
            style: TextStyle(fontSize: 30, color: Color(0xFF464646)),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button(
                  text: "No",
                  onPress: () {
                    print("deleted");
                    print("deleted${ViewCourse.deleteCourse}");

                    Navigator.pop(context);
                  }),
              SizedBox(
                width: 10,
              ),
              outlinebutton(
                  text: "Yes",
                  onPress: () {
                    studentId();

                    flag == 1
                        ? setState(() {
                            Navigator.pop(this.context);
                            setState(() {
                              ScaffoldMessenger.of(this.context).showSnackBar(
                                  SnackBar(content: Text('Staff Deleted')));
                            });
                            _firestore
                                .collection("staff")
                                .doc(deleteStaff)
                                .delete();
                          })
                        : flag == 2
                            ? setState(() {
                                Navigator.pop(this.context);
                                setState(() {
                                  ScaffoldMessenger.of(this.context)
                                      .showSnackBar(SnackBar(
                                          content: Text('student  Deleted')));
                                  print(deleteStaff);
                                });
                                _firestore
                                    .collection("new users")
                                    .doc(deleteStudent)
                                    .delete();
                              })
                            : flag == 3
                                ? setState(() {
                                    Navigator.pop(this.context);
                                    setState(() {
                                      print("Profile Picture uploaded");
                                      ScaffoldMessenger.of(this.context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text('payment Deleted')));
                                    });
                                    _firestore
                                        .collection("new users")
                                        .doc(deletePayment)
                                        .collection("payment")
                                        .doc(deleteSubpay)
                                        .delete();
                                  })
                                : widget.mode == "Online"
                                    ? setState(() {
                                        Navigator.pop(this.context);
                                        setState(() {
                                          ScaffoldMessenger.of(this.context)
                                              .showSnackBar(SnackBar(
                                                  content:
                                                      Text('course Deleted')));
                                        });
                                        _firestore
                                            .collection("course")
                                            .doc(ViewCourse.deleteCourse)
                                            .delete();
                                        _firestore
                                            .collection("course")
                                            .doc(ViewCourse.deleteCourse)
                                            .collection("syllabus")
                                            .doc(ViewCourse.deleteSyllabus)
                                            .delete();
                                      })
                                    : setState(() {
                                        Navigator.pop(this.context);
                                        setState(() {
                                          ScaffoldMessenger.of(this.context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'course offline Deleted')));
                                        });
                                        _firestore
                                            .collection("offline_course")
                                            .doc(ViewCourse.offlineId)
                                            .delete();
                                      });

                    print(" course Deleted");
                    print(ViewCourse.deleteCourse);
                    print("${deleteSubpay}deleteeee");
                    print("${deletePayment}deleteeee");
                  })
            ],
          ),
        ],
      ),
    );
  }
}

Visibility toggleError(isVisible) {
  return Visibility(
    visible: isVisible,
    child: Text(
      "Value Can't Be Empty ",
      style: TextStyle(color: Colors.red),
    ),
  );
}

InkWell closeIcon(BuildContext context) {
  return InkWell(
    customBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    onTap: () {
      Navigator.of(context).pop();
    },
    child: Icon(
      FontAwesomeIcons.times,
      color: Color(0xFFFF0000),
      size: 30,
    ),
  );
}

class TableWidget extends StatefulWidget {
  final List<String> title;
  String text;
  TableWidget({this.title, this.text});
  static List<Widget> heading = [];
  @override
  _TableWidgetState createState() => _TableWidgetState();
}

Future<void> displayDialog({name, context}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return Container(
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: SingleChildScrollView(child: name),
          actions: <Widget>[],
        ),
      );
    },
  );
}

class _TableWidgetState extends State<TableWidget> {
  Widget staffDb() {
    var subject = StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('staff').snapshots(),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading........");
        } else {
          final messages = snapshot.data.docs;
          List<StaffDb> staff = [];
          for (var message in messages) {
            final trainerName = message.data()['trainername'];
            final trainerImage = message.data()['trainerimage'];
            final qualification = message.data()['qualification'];
            final dateofbirth = message.data()['dateofbirth'];
            final dateofjoining = message.data()['dateofjoin'];
            final email = message.data()['email'];
            final mobileNumber = message.data()['mobileNumber'];
            final address = message.data()['address'];
            final staffData = StaffDb(
              trainername: trainerName,
              qualification: qualification,
              dateofbirth: dateofbirth,
              dateofjoining: dateofjoining,
              email: email,
              mobilenumber: mobileNumber,
              trainerImage: trainerImage,
              address: address,
            );
            // Text('$messageText from $messageSender');
            staff.add(staffData);
          }
          return Column(
            //alignment: WrapAlignment.start,
            children: staff,
          );
        }
      },
    );
    return subject;
  }

  Widget studentDb() {
    var student = StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('new users').snapshots(),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading.....");
        } else {
          final messages = snapshot.data.docs;
          List<StudentDb> student = [];
          for (var message in messages) {
            final studentName = message.data()['First Name'];
            final lastName = message.data()['Last Name'];
            final studentImage = message.data()['Profile Picture'];
            final qualification = message.data()['Degree'];
            final dateofbirth = message.data()['Date of Birth'];
            List courseEnrool = message.data()['Courses'];
            final email = message.data()['E Mail'];
            final mobileNumber = message.data()['Phone Number'];
            final gender = message.data()['Gender'];
            final country = message.data()['Country'];
            final state = message.data()['State'];
            final company = message.data()['Company or School'];
            final studentData = StudentDb(
              studentName: studentName,
              qualification: qualification,
              dateofbirth: dateofbirth,
              courseEnrool: courseEnrool,
              email: email,
              mobilenumber: mobileNumber,
              studentImage: studentImage,
              gender: gender,
              state: state,
              company_school: company,
              country: country,
              lastName: lastName,
            );
            // Text('$messageText from $messageSender');
            student.add(studentData);
          }
          return Column(
            //alignment: WrapAlignment.start,
            children: student,
          );
        }
      },
    );
    return student;
  }

  Widget paymentDb() {
    StreamBuilder paymentList;
    print("${Course.studentid}");
    print("${"docid"} inner");
    List collection = ["+91 1234567890", "+91 8015122373", "+91 9789252402"];
    for (var i in collection) {
      paymentList = StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('new users')
            .doc(i)
            .collection("payment")
            .snapshots(),
        // ignore: missing_return

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading.....");
          } else {
            print("${"docid"} thhhhhhhhhhhhhhhhh");
            final messages = snapshot.data.docs;
            List<PaymentDb> payment = [];

            for (var message in messages) {
              print(
                  '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ${message.data()}');
              final name = message.data()['name'];
              final totalAmount = message.data()['amount'];
              final amountPaid = message.data()['amountpaid'];
              final dueAmount = message.data()['dueamount'];
              final paidDate = message.data()['date'];
              print("${paidDate}paidDate");
              final nextPayment = message.data()['nextpaymentdate'];
              print("${nextPayment}nextPayment");
              final paymentMode = message.data()['paid_via'];

              final paymentData = PaymentDb(
                student: '$name',
                totalAmount: '$totalAmount',
                amountPaid: '$amountPaid',
                dueAmount: '$dueAmount',
                paidDate: '$paidDate',
                nextDate: '$nextPayment',
                payMode: '$paymentMode',
              );
              // Text('$messageText from $messageSender');
              payment.add(paymentData);
            }
            return Column(
              children: payment,
            );
          }
        },
      );
      return paymentList;
    }
  }

  String users;
  pay1() async {
    print("-------------pay1-----------------------");
    await for (var snapshot in _firestore
        .collection('new users')
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        //print(message.documentID);
        users = message.documentID;
        pay2(users);
      }
      print("-------------pay1-----------------------");
    }
  }

  pay2(String userId) async {
    print("jaya");
    await for (var snapshot in _firestore
        .collection('new users')
        .doc(userId)
        .collection("payment")
        .snapshots(includeMetadataChanges: true)) {
      List<PaymentDb> paymentlist = [];
      for (var message in snapshot.docs) {
        String payment = message.data()['amount'];
        print("${payment}payment");
        final name = message.data()['name'];
        print("${name}name");
        final coursename = message.data()['coursename'];
        print("${coursename}coursename");
        final paidDate = message.data()['date'];
        print("${paidDate}paidDate");
        final status = message.data()['status'];
        print("${status}nextPayment");
        final paymentMode = message.data()['paid_via'];
        print("${paymentMode}paymentMode");
        print("-------------pay2-----------------------");
        print("${userId}  ${payment}");
        print("-------------pay2-----------------------");
        final paymentData = PaymentDb(
          student: name,
          totalAmount: payment,
          dueAmount: status,
          paidDate: paidDate,
          nextDate: coursename,
          payMode: paymentMode,
        );
        paymentlist.add(paymentData);
      }
      return Column(
        children: paymentlist,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //subjectNotify();
    //pay1();
  }

  String document;

  @override
  Widget build(BuildContext context) {
    TableWidget.heading.clear();
    for (String i in widget.title) {
      TableWidget.heading.add(HeadingWidget(
        text: i,
      ));
    }
    TableWidget.heading.add(Visibility(
      child: CellWidget(
        text: "sample",
        isBold: true,
      ),
      visible: false,
    ));
    return Padding(
      padding: const EdgeInsets.all(0.0),
      // child: Table(
      //   border: TableBorder(
      //     bottom: BorderSide(color: Color(0xFFDFDFDF), width: 1),
      //   ),
      //   children: [
      //     TableRow(
      //       children: [
      //         StreamBuilder<QuerySnapshot>(
      //           stream: _firestore.collection('new users').snapshots(),
      //           // ignore: missing_return
      //           builder: (context, snapshot) {
      //             if (!snapshot.hasData) {
      //               return Text("Loading.....");
      //             } else {
      //               final messages = snapshot.data.docs;
      //               List<StudentDb> student = [];
      //               for (var message in messages) {
      //                 final studentName = message.data()['First Name'];
      //                 final lastName = message.data()['Last Name'];
      //                 final studentImage = message.data()['Profile Picture'];
      //                 final qualification = message.data()['Degree'];
      //                 final dateofbirth = message.data()['Date of Birth'];
      //                 List courseEnrool = message.data()['Courses'];
      //                 final email = message.data()['E Mail'];
      //                 final mobileNumber = message.data()['Phone Number'];
      //                 final gender = message.data()['Gender'];
      //                 final country = message.data()['Country'];
      //                 final state = message.data()['State'];
      //                 final company = message.data()['Company or School'];
      //                 final studentData = StudentDb(
      //                   studentName: studentName,
      //                   qualification: qualification,
      //                   dateofbirth: dateofbirth,
      //                   courseEnrool: courseEnrool,
      //                   email: email,
      //                   mobilenumber: mobileNumber,
      //                   studentImage: studentImage,
      //                   gender: gender,
      //                   state: state,
      //                   company_school: company,
      //                   country: country,
      //                   lastName: lastName,
      //                 );
      //                 // Text('$messageText from $messageSender');
      //                 student.add(studentData);
      //               }
      //               return Column(
      //                 //alignment: WrapAlignment.start,
      //                 children: student,
      //               );
      //             }
      //           },
      //         )
      //         // studentDb(),
      //         // flag == 1
      //         //
      //         //     ///todo remove the commented lines
      //         //     // StreamBuilder<QuerySnapshot>(
      //         //     //   stream: _firestore.collection('staff').snapshots(),
      //         //     //   builder: (context, snapshot) {
      //         //     //     if (!snapshot.hasData) {
      //         //     //       return Container(
      //         //     //         height: 400,
      //         //     //         width: 400,
      //         //     //         color: Colors.black,
      //         //     //       );
      //         //     //     } else {
      //         //     //       final messages = snapshot.data.docs;
      //         //     //       List<StaffDb> staff = [];
      //         //     //       for (var message in messages) {
      //         //     //         final trainerName = message.data()['trainername'];
      //         //     //         final trainerImage = message.data()['trainerimage'];
      //         //     //         final qualification =
      //         //     //         message.data()['qualification'];
      //         //     //         final dateofbirth = message.data()['dateofbirth'];
      //         //     //         final dateofjoining = message.data()['dateofjoin'];
      //         //     //         final email = message.data()['email'];
      //         //     //         final mobileNumber = message.data()['mobileNumber'];
      //         //     //         final address = message.data()['address'];
      //         //     //         final staffData = StaffDb(
      //         //     //           trainername: trainerName,
      //         //     //           qualification: qualification,
      //         //     //           dateofbirth: dateofbirth,
      //         //     //           dateofjoining: dateofjoining,
      //         //     //           email: email,
      //         //     //           mobilenumber: mobileNumber,
      //         //     //           trainerImage: trainerImage,
      //         //     //           address: address,
      //         //     //         );
      //         //     //         staff.add(staffData);
      //         //     //       }
      //         //     //       print(staff);
      //         //     //       return Column(
      //         //     //         children: staff,
      //         //     //       );
      //         //     //     }
      //         //     //   },
      //         //     // ) ///
      //         //
      //         //     ? Container(
      //         //         height: 500,
      //         //         width: 500,
      //         //         color: Colors.pink,
      //         //       )
      //         //
      //         //     ///todo student Db
      //         //     : flag == 2
      //         //         ? studentDb()
      //         //
      //         //         ///todo pay1
      //         //         : Container(
      //         //             color: Colors.yellowAccent,
      //         //             height: 500,
      //         //             width: 500,
      //         //           )
      //       ],
      //     ),
      //   ],
      // ),
      child: Column(
        children: [
          flag == 1
              ? staffDb()
              : flag == 2
                  ? studentDb()
                  : paymentDb(),
        ],
      ),
    );
  }
}

class HeadingWidget extends StatelessWidget {
  final String text;
  final bool isvisible;
  HeadingWidget({this.text, this.isvisible = true});
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isvisible,
      child: TableCell(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}

class CellWidget extends StatelessWidget {
  final String text;
  final bool isBold;

  CellWidget({this.text, this.isBold = true});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontWeight: isBold ? FontWeight.w500 : FontWeight.w400,
              color: Color(0xff555454),
              fontSize: 16),
        ),
      ),
    );
  }
}

class TileView extends StatelessWidget {
  String text;
  TileView({this.text});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 300.0,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5.0)),
          child: ListTile(
            title: Text("List item index"),
            onTap: () {
              print("student");
            },
          ),
        ),
      ],
    );
  }
}
