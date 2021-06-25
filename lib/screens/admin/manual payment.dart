import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:ocean_live/screens/admin/Details.dart';
import 'package:ocean_live/screens/admin/batch_dropdown.dart';
import 'package:ocean_live/screens/admin/course.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:ocean_live/screens/admin/notification/send_notification.dart';
import 'package:path/path.dart';
import 'course_drop.dart';

final _firestore = FirebaseFirestore.instance;

class ManualPay extends StatefulWidget {
  @override
  _ManualPayState createState() => _ManualPayState();
}

class _ManualPayState extends State<ManualPay> {
  String getLink;
  Uint8List uploadfile;
  String filename;
  TextEditingController name = TextEditingController();
  TextEditingController total = TextEditingController();
  TextEditingController paidDate = TextEditingController();
  TextEditingController mode = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController course = TextEditingController();
  TextEditingController batchid = TextEditingController();
  TextEditingController status = TextEditingController();

  ///time start

  String dateTime;
  num year;
  num day;
  num month;
  num hour;
  num minute;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  DateTime timing;
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025));

    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  ///time end

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50, right: 550),
      margin: EdgeInsets.all(50),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 200,
                          child: Text(
                            "Phone Number",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 250,
                          child: TextField(
                            controller: number,
                            decoration: customDecor(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 200,
                          child: Text(
                            "Courses",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ),
                        Container(width: 250, child: CourseDrop()),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 200,
                          child: Text(
                            "Batch Id",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ),
                        Container(width: 250, child: BatchDrop()),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 200,
                          child: Text(
                            "Amount",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 250,
                          child: TextField(
                            controller: total,
                            decoration: customDecor(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          width: 200,
                          child: Text(
                            "Paid_via",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 200,
                          child: TextField(
                            controller: mode,
                            decoration: customDecor(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          width: 200,
                          child: Text(
                            "Date",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 200,
                          child: TextField(
                            controller: _dateController,
                            decoration: InputDecoration(
                              isDense: true,
                              suffixIcon: IconButton(
                                icon: Icon(FontAwesomeIcons.calendar),
                                onPressed: () => _selectDate(context),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black54)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.blueAccent),
                              ),
                              labelStyle: TextStyle(
                                color: Colors.black,
                                //color: Color(0xff7E7E7E), fontSize: 19, fontWeight: FontWeight.w600
                              ),
                            ),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          width: 200,
                          child: Text(
                            "Name",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 200,
                          child: TextField(
                            controller: name,
                            decoration: customDecor(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          width: 200,
                          child: Text(
                            "Status",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 200,
                          child: TextField(
                            controller: status,
                            decoration: customDecor(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              aCustomButtom(
                  text: "upload Course Image",
                  iconData: FontAwesomeIcons.plus,
                  buttonClick: () async {
                    FilePickerResult result =
                        await FilePicker.platform.pickFiles();
                    if (result != null) {
                      uploadfile = result.files.single.bytes;
                      setState(() {
                        filename = basename(result.files.single.name);
                      });
                      print(filename);
                      setState(() {
                        uploadPic(context);
                      });
                    } else {
                      print('pick Course Image');
                    }
                  },
                  fontSize: 23,
                  iconSize: 32),
              SizedBox(
                width: 30,
              ),
              button(
                  text: "Save",
                  onPress: () {
                    _firestore.collection("new users").doc(number.text).update({
                      "Courses": FieldValue.arrayUnion(
                          [CourseDrop.dropdownValue.trim()]),
                      "batchid": FieldValue.arrayUnion(
                          [BatchDrop.dropdownValue.trim()]),
                    });
                    print(getLink);
                    print("${status.text}");
                    print("${mode.text}");

                    _firestore
                        .collection("new users")
                        .doc(number.text)
                        .collection("payment")
                        .doc(CourseDrop.dropdownValue)
                        .set({
                      "coursename": CourseDrop.dropdownValue,
                      "amount": total.text,
                      "date": _dateController.text,
                      "image": getLink,
                      "paid_via": mode.text,
                      "status": status.text,
                    });
                  },
                  fontSize: 25,
                  paddingSize: 15,
                  width: 200),
            ],
          )
        ],
      ),
    );
  }

  Future uploadPic(BuildContext context) async {
    // String fileName = basename(_image.path);

    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("course").child(filename);
    UploadTask uploadTask = firebaseStorageRef.putData(uploadfile);
    TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() => setState(() {
              print("Profile Picture uploaded");
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Profile Picture Uploaded')));
              uploadTask.snapshot.ref.getDownloadURL().then((value) {
                setState(() {
                  getLink = value;
                });
                print(getLink);
              });
            }));
  }
}
