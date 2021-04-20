import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_live/models/routing.dart';
import 'package:ocean_live/screens/admin/Details.dart';
import 'package:ocean_live/screens/admin/batch_schedule.dart';
import 'package:ocean_live/screens/admin/batch_students.dart';
import 'package:ocean_live/screens/admin/payment/edit_payment.dart';
import 'package:ocean_live/screens/admin/payment/view_payment.dart';
import 'package:ocean_live/screens/admin/staff/edit_staff.dart';
import 'package:ocean_live/screens/admin/staff/view_staff.dart';
import 'package:ocean_live/screens/admin/student/update_student.dart';
import 'package:ocean_live/screens/admin/student/view_student.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StaffDb extends StatefulWidget {
  StaffDb(
      {this.trainername,
      this.email,
      this.address,
      this.dateofbirth,
      this.dateofjoining,
      this.mobilenumber,
      this.qualification,
      this.trainerImage});
  String trainername;
  String address;
  String mobilenumber;
  String email;
  String qualification;
  String dateofbirth;
  String dateofjoining;
  String trainerImage;
  @override
  _StaffDbState createState() => _StaffDbState();
}

class _StaffDbState extends State<StaffDb> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, List> studentList = {};
  List<Widget> cards = [];
  final _count = ValueNotifier(0);

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
              padding: EdgeInsets.all(7),
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image(
                  image: NetworkImage("${widget.trainerImage}"),
                  width: 46,
                  fit: BoxFit.fill,
                  height: 40,
                ),
              ),
            ),
            CellWidget(
              text: "${widget.trainername}",
            ),
            CellWidget(text: "${widget.mobilenumber}"),
            CellWidget(text: "${widget.email}"),
            CellWidget(text: "${widget.dateofbirth}"),
            CellWidget(text: "${widget.dateofjoining}"),
            CellWidget(text: "${widget.address}"),
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
                              ? ViewStaffDetails(
                                  trainerImage: widget.trainerImage,
                                  trainername: widget.trainername,
                                  qualification: widget.qualification,
                                  mobilenumber: widget.mobilenumber,
                                  email: widget.email,
                                  address: widget.address,
                                  dateofbirth: widget.dateofbirth,
                                  courseenrool: widget.dateofjoining,
                                )
                              : flag == 2
                                  ? ViewStudentDetails()
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
                                ? EditStaffDetails(
                                    trainerImage: widget.trainerImage,
                                    trainername: widget.trainername,
                                    qualification: widget.qualification,
                                    mobilenumber: widget.mobilenumber,
                                    email: widget.email,
                                    address: widget.address,
                                    dateofbirth: widget.dateofbirth,
                                    dateofjoining: widget.dateofjoining,
                                  )
                                : flag == 2
                                    ? UpdateStudentDetails()
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
                            trainerImage: widget.trainerImage,
                            trainername: widget.trainername,
                            qualification: widget.qualification,
                            mobilenumber: widget.mobilenumber,
                            email: widget.email,
                            address: widget.address,
                            dateofbirth: widget.dateofbirth,
                            dateofjoining: widget.dateofjoining,
                          ),
                          context: context);
                    },
                    child: Icon(FontAwesomeIcons.trashAlt, size: 15),
                  ),
                  Container(
                    padding: EdgeInsets.zero,
                    width: 50,
                    child: RaisedButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Provider.of<Routing>(context, listen: false)
                            .updateRouting(widget: BatchSchedule());
                      },
                    ),
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
