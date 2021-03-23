import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_live/screens/admin/Details.dart';
import 'package:ocean_live/screens/admin/notification/send_notification.dart';

final _firestore = FirebaseFirestore.instance;

class UpdateStudentDetails extends StatefulWidget {
  @override
  _UpdateStudentDetailsState createState() => _UpdateStudentDetailsState();
}

class _UpdateStudentDetailsState extends State<UpdateStudentDetails> {
  var studentId = 0;
  var studentLink;
  String filename;
  Uint8List uploadfile;

  ///
  final _dateOfBirth = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _eMail = TextEditingController();
  final _companyOrSchool = TextEditingController();
  final _dgree = TextEditingController();
  final _country = TextEditingController();
  final _state = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _gender = TextEditingController();
  TextEditingController courseEnrool = TextEditingController();

  ///

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Add Student Details",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                closeIcon(context),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 50,
              ),
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      "${studentLink}",
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: GestureDetector(
                      child: UploadImage(
                        size: 12,
                      ),
                      onTap: () async {
                        FilePickerResult result =
                            await FilePicker.platform.pickFiles();
                        if (result != null) {
                          uploadfile = result.files.single.bytes;
                          setState(() {
                            filename = basename(result.files.single.name);
                          });
                          print(filename);
                        } else {
                          print('pick imafe');
                        }
                        ///////
                        Future uploadPic(BuildContext context) async {
                          Reference firebaseStorageRef = FirebaseStorage
                              .instance
                              .ref()
                              .child("student")
                              .child(filename);
                          UploadTask uploadTask =
                              firebaseStorageRef.putData(uploadfile);
                          TaskSnapshot taskSnapshot =
                              await uploadTask.whenComplete(() {
                            setState(() {
                              print("Profile Picture uploaded");
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Staff Picture Uploaded')));
                              uploadTask.snapshot.ref
                                  .getDownloadURL()
                                  .then((value) {
                                setState(() {
                                  studentLink = value;
                                });

                                print(studentLink);
                              });
                            });
                          });
                        }

                        uploadPic(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              )),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _heading(text: "Name"),
                    TextField(
                      controller: _firstName,
                      decoration: customDecor(),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 50,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Expanded(
                child: _heading(text: "Last Name"),
              ),
              Expanded(
                child: _heading(text: "Mobile Number"),
              ),
              Expanded(
                child: _heading(text: "Email Id"),
              ),
              SizedBox(
                width: 50,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Expanded(
                child: TextField(
                  controller: _lastName,
                  decoration: customDecor(),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: _phoneNumber,
                  decoration: customDecor(),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: _eMail,
                  decoration: customIconDecor(
                      icon: Icon(FontAwesomeIcons.calendarAlt),
                      context: context),
                ),
              ),
              SizedBox(
                width: 50,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Expanded(
                child: _heading(text: "DOB"),
              ),
              SizedBox(
                width: 50,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Expanded(
                  child: TextField(
                controller: _dateOfBirth,
                decoration: customDecor(),
              )),
              SizedBox(
                width: 50,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Expanded(
                child: _heading(text: "gender"),
              ),
              SizedBox(
                width: 50,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Expanded(
                  child: TextField(
                controller: _gender,
                decoration: customDecor(),
              )),
              SizedBox(
                width: 50,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Expanded(
                child: _heading(text: "State"),
              ),
              Expanded(
                child: _heading(text: "Country"),
              ),
              Expanded(
                child: _heading(text: "College/Institution"),
              ),
              SizedBox(
                width: 50,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Expanded(
                child: TextField(
                  controller: _state,
                  decoration: customDecor(),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: _country,
                  decoration: customDecor(),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: _companyOrSchool,
                  decoration: customDecor(),
                ),
              ),
              SizedBox(
                width: 50,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Expanded(
                child: _heading(text: "degree"),
              ),
              Expanded(
                child: _heading(text: "CourseEnroll"),
              ),
              SizedBox(
                width: 50,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Expanded(
                child: TextField(
                  controller: _dgree,
                  decoration: customDecor(),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: courseEnrool,
                  decoration: customDecor(),
                ),
              ),
              SizedBox(
                width: 50,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              dynamicSizeButton(
                  text: "Save Details",
                  onPress: () {
                    _firestore
                        .collection('new users')
                        .doc("+91 ${_phoneNumber.text}")
                        .set({
                      'Profile Picture': studentLink,
                      'First Name': _firstName.text,
                      'Last Name': _lastName.text,
                      'Gender': _gender.text,
                      'Date of Birth': _dateOfBirth.text,
                      'E Mail': _eMail.text,
                      'Company or School': _companyOrSchool.text,
                      'Degree': _dgree.text,
                      'Country': _country.text,
                      'State': _state.text,
                      'Phone Number': "+91 ${_phoneNumber.text}",
                      'Courses': FieldValue.arrayUnion([courseEnrool.text]),
                      'batchid': [],
                    });
                    Navigator.pop(context);
                  }),
            ],
          ),
        ],
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
