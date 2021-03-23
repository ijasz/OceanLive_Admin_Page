import 'package:flutter/material.dart';
import 'package:ocean_live/screens/admin/Details.dart';
class ViewStaffDetails extends StatelessWidget {
  ViewStaffDetails(
      {this.trainername,
        this.email,
        this.address,
        this.dateofbirth,
        this.courseenrool,
        this.mobilenumber,
        this.qualification,
        this.trainerImage});
  String trainername;
  String address;
  String mobilenumber;
  String email;
  String qualification;
  String dateofbirth;
  String courseenrool;
  String trainerImage;
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
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    "${trainerImage}",
                    width: 180,
                    height: 180,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Table(
                  defaultColumnWidth: IntrinsicColumnWidth(),
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
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
                        "${trainername}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
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
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          "DOJ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "${courseenrool}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
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
                        padding: const EdgeInsets.only(bottom: 20),
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
                        padding: const EdgeInsets.only(bottom: 20),
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
                          Text("${address}", style: TextStyle(fontSize: 20)),
                        ],
                      )
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
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
                        "${qualification}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}