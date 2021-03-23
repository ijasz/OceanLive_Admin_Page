import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ocean_live/screens/admin/notification/send_notification.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ocean_live/screens/admin/Details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _firestore = FirebaseFirestore.instance;

class EditStudent extends StatefulWidget {
  EditStudent(
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
  _EditStudentState createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  bool isName = false, isMobile = false, isEmail = false;
  var id = 0;
  var studentLink;
  String filename;
  Uint8List uploadfile;
  String editStudent;
  TextEditingController _dateOfBirth;
  TextEditingController _firstName;
  TextEditingController _lastName;
  TextEditingController _eMail;
  TextEditingController _companyOrSchool;
  TextEditingController _dgree;
  TextEditingController _country;
  TextEditingController _phoneNumber;
  TextEditingController _state;
  TextEditingController courseEnrool;
  TextEditingController _gender;
  @override
  void editstudent() async {
    await for (var snapshot in _firestore
        .collection('new users')
        .where("E Mail", isEqualTo: _eMail.text)
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        //print(message.documentID);
        editStudent = message.documentID;
        print("${editStudent}latha");
      }
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    print("=======================");
    print(widget.lastName);

    studentLink = widget.studentImage;
    _dateOfBirth = TextEditingController(text: widget.dateofbirth);
    _firstName = TextEditingController(text: widget.studentName);
    _lastName = TextEditingController(text: widget.lastName);
    _eMail = TextEditingController(text: widget.email);
    _companyOrSchool = TextEditingController(text: widget.company_school);
    _dgree = TextEditingController(text: widget.qualification);
    _country = TextEditingController(text: widget.country);
    _state = TextEditingController(text: widget.state);
    _phoneNumber = TextEditingController(text: widget.mobilenumber);
    _gender = TextEditingController(text: widget.gender);
    courseEnrool = TextEditingController(text: "${widget.courseEnrool}");

    editstudent();
    print("${_phoneNumber.text}PHONE");
    print("${widget.studentImage}ttttttttttttt");
  }

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
                  "Edit Student Details",
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
                        "${widget.studentImage}",
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

                          // setState(() {
                          //   isComplete = true;
                          // });

                          setState(() {
                            uploadPic(context);
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
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
                child: _heading(text: "Mobile Number"),
              ),
              Expanded(
                child: _heading(text: "Email Id"),
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
                  decoration: customDecor(),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: _dateOfBirth,
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
                child: _heading(text: "Country"),
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
                controller: _country,
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
                child: _heading(text: "Courses Enrolled"),
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
                controller: courseEnrool,
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
                child: _heading(text: "College/Institution"),
              ),
              Expanded(
                child: _heading(text: "Qualification"),
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
                  controller: _companyOrSchool,
                  decoration: customDecor(),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: _dgree,
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
                child: _heading(text: "Last Name"),
              ),
              Expanded(
                child: _heading(text: "Gender"),
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
                  controller: _gender,
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
                    _firestore.collection('new users').doc(editStudent).set({
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
                      'Phone Number': "${_phoneNumber.text}",
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

  Future uploadPic(BuildContext context) async {
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("Student").child(filename);
    UploadTask uploadTask = firebaseStorageRef.putData(uploadfile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {
      setState(() {
        print("Profile Picture uploaded");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('student Picture Uploaded')));
        uploadTask.snapshot.ref.getDownloadURL().then((value) {
          setState(() {
            studentLink = value;
          });
          setState(() {
            widget.studentImage = studentLink;
          });

          print(studentLink);
        });
      });
    });
  }
}

Text _heading({text}) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 18, color: Color(0xFF555454), fontWeight: FontWeight.w600),
  );
}
