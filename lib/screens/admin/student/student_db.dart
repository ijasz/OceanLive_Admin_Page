import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_live/screens/admin/Details.dart';
import 'package:ocean_live/screens/admin/payment/edit_payment.dart';
import 'package:ocean_live/screens/admin/payment/view_payment.dart';
import 'package:ocean_live/screens/admin/staff/edit_staff.dart';
import 'package:ocean_live/screens/admin/staff/view_staff.dart';
import 'package:ocean_live/screens/admin/student/edit_student.dart';
import 'package:ocean_live/screens/admin/student/view_student.dart';

class StudentDb extends StatefulWidget {
  static String paymentId;
  static String specificsub;
  StudentDb(
      {this.studentName,
      this.email,
      this.gender,
      this.dateofbirth,
      this.courseEnrool,
      this.mobilenumber,
      this.qualification,
      this.studentImage,
      this.lastName,
      this.state,
      this.country,
      this.company_school});
  String studentName;
  String gender;
  String mobilenumber;
  String email;
  String qualification;
  String dateofbirth;
  List courseEnrool;
  String studentImage;
  String country;
  String state;
  String company_school;
  String lastName;
  @override
  _StudentDbState createState() => _StudentDbState();
}

class _StudentDbState extends State<StudentDb> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //studentPayId();
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
            Container(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image(
                  image: NetworkImage("${widget.studentImage}"),
                  width: 46,
                  fit: BoxFit.fill,
                  height: 40,
                ),
              ),
            ),
            CellWidget(
              text: "${widget.studentName}",
            ),
            CellWidget(text: "${widget.mobilenumber}"),
            CellWidget(text: "${widget.email}"),
            CellWidget(text: "${widget.dateofbirth}"),
            CellWidget(text: "${widget.state}"),
            CellWidget(text: "${widget.gender}"),
            CellWidget(text: "${widget.qualification}"),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      displayDialog(
                          name: flag == 1
                              ? ViewStaffDetails()
                              : flag == 2
                                  ? ViewStudentDetails(
                                      studentImage: widget.studentImage,
                                      studentName: widget.studentName,
                                      degree: widget.qualification,
                                      mobilenumber: widget.mobilenumber,
                                      email: widget.email,
                                      gender: widget.gender,
                                      dateofbirth: widget.dateofbirth,
                                      courseEnrool: widget.courseEnrool,
                                      designation: widget.lastName,
                                      company_school: widget.company_school,
                                      country: widget.country,
                                      state: widget.state,
                                    )
                                  : ViewPayment(),
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
                                    ? EditStudent(
                                        studentName: widget.studentName,
                                        studentImage: widget.studentImage,
                                        qualification: widget.qualification,
                                        mobilenumber: widget.mobilenumber,
                                        email: widget.email,
                                        gender: widget.gender,
                                        dateofbirth: widget.dateofbirth,
                                        courseEnrool: widget.courseEnrool,
                                        state: widget.state,
                                        company_school: widget.company_school,
                                        lastName: widget.lastName,
                                        country: widget.country,
                                      )
                                    : EditPay(),
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
                            trainerImage: widget.studentImage,
                            trainername: widget.studentName,
                            qualification: widget.qualification,
                            mobilenumber: widget.mobilenumber,
                            email: widget.email,
                            address: widget.gender,
                            dateofbirth: widget.dateofbirth,
                            //dateofjoining: widget.courseEnrool,
                          ),
                          context: context);
                    },
                    child: Icon(FontAwesomeIcons.trashAlt, size: 15),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                    onPressed: () {
                      //studentPayId();
                      displayDialog(
                          name: ViewPayment(
                            email: widget.email,
                            studentname: widget.studentName,
                          ),
                          context: context);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
