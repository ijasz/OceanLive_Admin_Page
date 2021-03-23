import 'package:flutter/material.dart';
import 'package:ocean_live/screens/admin/Details.dart';

class ViewStudentDetails extends StatelessWidget {
  ViewStudentDetails(
      {this.studentName,
      this.email,
      this.gender,
      this.dateofbirth,
      this.courseEnrool,
      this.mobilenumber,
      this.degree,
      this.studentImage,
      this.designation,
      this.state,
      this.country,
      this.company_school});
  String studentName;
  String gender;
  String mobilenumber;
  String email;
  String degree;
  String dateofbirth;
  List courseEnrool;
  String studentImage;
  String country;
  String state;
  String company_school;
  String designation;

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Table(
                  defaultColumnWidth: IntrinsicColumnWidth(),
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, left: 50),
                        child: Text(
                          "Name",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "${studentName}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, left: 50),
                        child: Text(
                          "DOB",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "${dateofbirth}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, left: 50),
                        child: Text(
                          "Mobile Number",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "${mobilenumber}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, left: 50),
                        child: Text(
                          "Email Id",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "${email}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, left: 50),
                        child: Text(
                          "Address",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${gender}", style: TextStyle(fontSize: 20)),
                        ],
                      )
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, left: 50),
                        child: Text(
                          "Courses Enrolled",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "${courseEnrool}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, left: 50),
                        child: Text(
                          "State",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "${state}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, left: 50),
                        child: Text(
                          "Country",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "${country}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, left: 50),
                        child: Text(
                          "Qualification",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "${degree}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, left: 50),
                        child: Text(
                          "Company/School",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "${company_school}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                  ],
                ),
              ),
              SizedBox(
                width: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    studentImage,
                    width: 180,
                    height: 180,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
