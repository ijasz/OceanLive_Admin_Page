import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ocean_live/screens/admin/webinar/screens/content1.dart';

///< Content 1 Upload Alert >///

final _firestore = FirebaseFirestore.instance;

class Content1UploadAlert extends StatefulWidget {
  DateTime timestamp;
  var get;
  Content1UploadAlert({this.timestamp, this.get});

  static TextEditingController courseController = TextEditingController();

  @override
  _Content1UploadAlertState createState() => _Content1UploadAlertState();
}

class _Content1UploadAlertState extends State<Content1UploadAlert> {
  //variables
  var mentorImage;
  Uint8List uploadfile;
  String filename;
  String superTopic;
  String mainTitle;
  String mainSubtitle;
  String trainerName;
  String course;
  String webinarDuration;

  //TextEditingControllers
  final heading1Controller = TextEditingController();
  final heading2Controller = TextEditingController();
  final heading3Controller = TextEditingController();
  final trainerNameController = TextEditingController();
  final webinarDurationController = TextEditingController();

  num year;
  num day;
  num month;
  var timestamp;

  DateTime time;
  DateTime selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025));

    final TimeOfDay tpicked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null)
      setState(() {
        selectedDate = picked;
        print(tpicked);

        print(selectedDate.compareTo(DateTime.now()));
        // timestamp = '$selectedDate $tpicked';
        time = DateTime(selectedDate.year, selectedDate.month, selectedDate.day,
            tpicked.hour, tpicked.minute);
        print(DateTime);
        print('=====================');
        print(time);
        print(time.runtimeType);
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
    year = int.parse(DateFormat('y').format(selectedDate));
    month = int.parse(DateFormat('MM').format(selectedDate));
    day = int.parse(DateFormat('d').format(selectedDate));
    print(year);
    print(month);
    print(day);
  }

  //TextFields
  Widget _superTopicField() {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 40, left: 5),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1, color: Colors.black54)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 1, color: Colors.blueAccent),
        ),
        labelText: 'Super Topic',
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
      ),
      controller: heading1Controller,
      onChanged: (value) {
        superTopic = value;
      },
    );
  }

  Widget _mainTitleField() {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 40, left: 5),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1, color: Colors.black54)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 1, color: Colors.blueAccent),
        ),
        labelText: 'Main Title',
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
      ),
      controller: heading2Controller,
      onChanged: (value) {
        mainTitle = value;
      },
    );
  }

  Widget _mainSubtitleField() {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 40, left: 5),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1, color: Colors.black54)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 1, color: Colors.blueAccent),
        ),
        labelText: 'Main Subtitle',
        labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
      ),
      controller: heading3Controller,
      onChanged: (value) {
        mainSubtitle = value;
      },
    );
  }

  Widget _trainerNameField() {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 40, left: 5),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1, color: Colors.black54)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 1, color: Colors.blueAccent),
        ),
        labelText: 'Trainer Name',
        labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
      ),
      controller: trainerNameController,
      onChanged: (value) {
        trainerName = value;
      },
    );
  }

  Widget _courseField() {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 40, left: 5),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1, color: Colors.black54)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 1, color: Colors.blueAccent),
        ),
        labelText: 'Course',
        labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
      ),
      controller: Content1UploadAlert.courseController,
      onChanged: (value) {
        course = value;
      },
    );
  }

  Widget _webinarDurationField() {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 40, left: 5),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1, color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 1, color: Colors.blueAccent),
        ),
        labelText: 'Minutes',
        labelStyle: TextStyle(color: Colors.black, fontSize: 15),
      ),
      controller: webinarDurationController,
      onChanged: (value) {
        webinarDuration = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      width: 550,
      color: Colors.white,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                color: Colors.blue,
                height: 100,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Content 1',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10, right: 20),
                    child: RaisedButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0xff0090E9),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.date_range_outlined,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 5),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Date and Time',
                              style: TextStyle(
                                fontSize: 17,
                                color: Color(0xff0090E9),
                              ),
                            ),
                          ),
                        ],
                      ),
                      textColor: Colors.white,
                      onPressed: () {
                        // DateTimePicker();
                        _selectDate(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, right: 20),
                    child: RaisedButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0xff0090E9),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.upload_outlined,
                            color: Colors.blue,
                            size: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Upload',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff0090E9),
                              ),
                            ),
                          ),
                        ],
                      ),
                      textColor: Colors.white,
                      onPressed: () async {
                        FilePickerResult result =
                            await FilePicker.platform.pickFiles();
                        if (result != null) {
                          uploadfile = result.files.single.bytes;
                          setState(() {
                            filename = basename(result.files.single.name);
                          });
                          print(filename);
                        } else {
                          print('pick image');
                        }
                        ///////
                        Future uploadPic(BuildContext context) async {
                          Reference firebaseStorageRef = FirebaseStorage
                              .instance
                              .ref()
                              .child("Mentor")
                              .child(filename);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Please wait few soconds')));
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
                                  mentorImage = value;
                                });

                                print(
                                    "${mentorImage} ////////////353 mentor Image");
                              });
                            });
                          });
                        }

                        print('${mentorImage}  /////359 mentor Image');
                        uploadPic(context);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 70,
                        width: 400,
                        child: _trainerNameField(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 70,
                        width: 400,
                        child: _superTopicField(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 70,
                        width: 400,
                        child: _mainTitleField(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 70,
                        width: 400,
                        child: _mainSubtitleField(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 70,
                        width: 400,
                        child: _courseField(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 70,
                        width: 400,
                        child: _webinarDurationField(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      //adding first document fields to retrieve the collection
                      print(
                          '${Content1.paymentController.text} //////////////1308');
                      print(
                          '${widget.get} //////////////// 458///////////////////');
                      //adding collection
                      _firestore
                          .collection('Webinar')
                          .doc(Content1UploadAlert.courseController.text)
                          .set({
                        'trainer name': trainerName,
                        'trainer image': mentorImage,
                        'super title': superTopic,
                        'main title': mainTitle,
                        'main subtitle': mainSubtitle,
                        'timestamp': time,
                        'course': Content1UploadAlert.courseController.text,
                        'webinar duration': webinarDuration,
                        'payment': Content1.paymentController.text.isEmpty
                            ? 'free'
                            : Content1.paymentController.text,
                        'student enrolled': int.parse('100')
                      });
                      heading1Controller.clear();
                      heading2Controller.clear();
                      heading3Controller.clear();
                      Navigator.pop(context);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          Positioned(
            left: 15,
            top: 60,
            child: CircleAvatar(
              backgroundImage: NetworkImage('$mentorImage'),
              backgroundColor: Colors.grey[200],
              maxRadius: 45,
            ),
          ),
          Positioned(
            width: 35,
            top: 25,
            right: 13,
            child: RaisedButton(
              elevation: 0,
              hoverColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              padding: EdgeInsets.zero,
              color: Colors.blue,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.cancel,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
