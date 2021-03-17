import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ocean_live/screens/admin/webinar/upload%20alert/Content1_UploadAlert.dart';
import 'package:ocean_live/screens/admin/webinar/webinar.dart';
import 'package:path/path.dart';

///< Content 1 Edit Alert >///

final _firestore = FirebaseFirestore.instance;

class ContentEdit extends StatefulWidget {
  static String filename;
  static List topicTitle;
  static List topicSubtitle;
  static var getLink;
  static var differenceTime;
  String imageLink;
  ContentEdit({this.webinarData});
  Map webinarData;
  static var video;

  @override
  _ContentEditState createState() => _ContentEditState();
}

String uploadCourse;
Map topics = {};
TextEditingController _titleController =
    TextEditingController(text: 'tttttttt');
TextEditingController _subtitleController = TextEditingController();

alert(context, {String topic, String subtitle, courseName}) {
  _titleController.text = topic;
  _subtitleController.text = subtitle;
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 400,
            width: 400,
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                ),
                TextField(
                  controller: _subtitleController,
                ),
                TextButton(
                  child: Text(
                    'Update',
                    style: TextStyle(fontSize: 30),
                  ),
                  onPressed: () {
                    print('${courseName}    edit course');
                    // _firestore.collection('Webinar').doc(courseName).update({
                    //   'topics subtitle' : FieldValue.arrayUnion([topic]),
                    //   'topic title' : FieldValue.arrayUnion([subtitle]),
                    // });
                    // topics
                    //     .addAll({_titleController.text: _titleController.text});
                    // print(topics);
                  },
                )
              ],
            ),
          ),
        );
      });
}

class _ContentEditState extends State<ContentEdit> {
  //TextEditingControllers

  TextEditingController trainerNameController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController superTitleController = TextEditingController();
  TextEditingController mainTitleController = TextEditingController();
  TextEditingController webinarDurationController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController mainSubtitleController = TextEditingController();
  TextEditingController aboutMentorController = TextEditingController();
  TextEditingController studentEnrolledController = TextEditingController();
  TextEditingController paymentController = TextEditingController();
  TextEditingController designationController = TextEditingController();

  num year;
  num day;
  num month;
  var mentorImage;
  var mentorImage2;
  var minutes;
  DateTime time;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  String trainerName;
  String mainSubtitle;
  String course;
  String mainTitle;
  String superTitle;
  String webinarDuration;
  var timestamp;
  String title;
  String subtitle;
  String aboutMentor;
  String designation;
  String payment;
  String studentEnrolled;
  String filename2;
  String filename;
  List topicTitle;
  List topicSubtitle;
  Uint8List uploadfile2;
  Uint8List uploadfile;
  bool isComplete = false, isOnline = false, isOffline = false;

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

  Widget _superTitleField() {
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
      controller: superTitleController,
      onChanged: (value) {
        superTitle = value;
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
      controller: mainTitleController,
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
      controller: mainSubtitleController,
      onChanged: (value) {
        mainSubtitle = value;
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
      controller: courseController,
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
        labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
      ),
      controller: webinarDurationController,
      onChanged: (value) {
        webinarDuration = value;
      },
    );
  }

  Widget _titleField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          print(value);
          return "query is required";
        } else if (value.length < 2) {
          return 'character should be more than 2';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 40, left: 5),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1, color: Colors.black54)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 1, color: Colors.blueAccent),
        ),
        labelText: 'Title',
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
      // controller: widget.titleController,
      onChanged: (value) {
        title = value;
      },
    );
  }

  Widget _subTitleField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          print(value);
          return "query is required";
        } else if (value.length < 2) {
          return 'character should be more than 2';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 40, left: 5),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1, color: Colors.black54)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 1, color: Colors.blueAccent),
        ),
        labelText: 'Sub Title',
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
      // controller: widget.mainSubtitleController,
      onChanged: (value) {
        subtitle = value;
      },
    );
  }

  Widget _aboutMentor() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          print(value);
          return "query is required";
        } else if (value.length < 2) {
          return 'character should be more than 2';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 40, left: 5),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1, color: Colors.black54)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 1, color: Colors.blueAccent),
        ),
        labelText: 'About Mentor',
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
      ),
      controller: aboutMentorController,
      onChanged: (value) {
        aboutMentor = value;
      },
    );
  }

  Widget _designation() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          print(value);
          return "query is required";
        } else if (value.length < 2) {
          return 'character should be more than 2';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 40, left: 5),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1, color: Colors.black54)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 1, color: Colors.blueAccent),
        ),
        labelText: 'Designation',
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
      ),
      controller: designationController,
      onChanged: (value) {
        designation = value;
      },
    );
  }

  Widget _payment() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          print(value);
          return "query is required";
        } else if (value.length < 2) {
          return 'character should be more than 2';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 40, left: 5),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1, color: Colors.black54)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 1, color: Colors.blueAccent),
        ),
        labelText: 'Payment',
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
      ),
      controller: paymentController,
      onChanged: (value) {
        payment = value;
      },
    );
  }

  Widget _studentEnrolledField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          print(value);
          return "query is required";
        } else if (value.length < 2) {
          return 'character should be more than 2';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 40, left: 5),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1, color: Colors.black54)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 1, color: Colors.blueAccent),
        ),
        labelText: 'Student Enrolled',
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
      ),
      controller: studentEnrolledController,
      onChanged: (value) {
        studentEnrolled = value;
      },
    );
  }

  Widget _timestampField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          print(value);
          return "query is required";
        } else if (value.length < 2) {
          return 'character should be more than 2';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 40, left: 5),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1, color: Colors.black54)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 1, color: Colors.blueAccent),
        ),
        labelText: 'Date & Time',
        suffixIcon: TextButton(
            onPressed: () {}, child: Icon(Icons.date_range_outlined)),
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
      ),
      controller: dateTimeController,
      onChanged: (value) {
        timestamp = value;
      },
    );
  }

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
        dateTimeController.text = DateFormat.yMd().format(selectedDate);
      });
    year = int.parse(DateFormat('y').format(selectedDate));
    month = int.parse(DateFormat('MM').format(selectedDate));
    day = int.parse(DateFormat('d').format(selectedDate));
    print(year);
    print(month);
    print(day);
  }

  List<Widget> allTopicWidget = [];

  String thisId;
  @override
  Widget build(BuildContext context) {
    ContentEdit.topicTitle = widget.webinarData['topic title'];
    ContentEdit.topicSubtitle = widget.webinarData['topic subtitle'];
    mentorImage = widget.webinarData['trainer image'];
    studentEnrolledController.text = widget.webinarData['student enrolled'];
    // studentEnrolled = widget.webinarData['student enrolled'];
    minutes = widget.webinarData['trainer image'];
    mentorImage2 = widget.webinarData['mentor image'];
    ContentEdit.video = widget.webinarData['webinar video'];
    trainerNameController.text = widget.webinarData['trainer name'];
    Timestamp timestamp = widget.webinarData['timestamp'];
    print(timestamp.toDate());
    print('*************************');
    var year = DateFormat('y');
    var month = DateFormat('MM');
    var date = DateFormat('d');
    var hour = DateFormat('hh');
    var min = DateFormat('m');
    var amPm = DateFormat('a');
    int yearFormat = int.parse(year.format(timestamp.toDate()));
    int monthFormat = int.parse(month.format(timestamp.toDate()));
    int dateFormat = int.parse(date.format(timestamp.toDate()));
    int hourFormat = int.parse(hour.format(timestamp.toDate()));
    int minFormat = int.parse(min.format(timestamp.toDate()));
    var timeFormat = amPm.format(timestamp.toDate());

    ContentEdit.differenceTime = DateTime(
      dateFormat,
      monthFormat,
      yearFormat,
      hourFormat,
      minFormat,
    );

    designationController.text = widget.webinarData['designation'];
    aboutMentorController.text = widget.webinarData['about mentor'];
    dateTimeController.text = '${ContentEdit.differenceTime} $timeFormat';
    print("${ContentEdit.differenceTime} ///////////////date and time format");
    paymentController.text = widget.webinarData['payment'];
    webinarDurationController.text = widget.webinarData['webinar duration'];
    print(
        '${webinarDurationController.text}   //////////////////////////webinar duration');
    courseController.text = widget.webinarData['course'];
    course = widget.webinarData['course'];
    thisId = widget.webinarData['course'];
    superTitleController.text = widget.webinarData['super title'];
    mainTitleController.text = widget.webinarData['main title'];
    mainSubtitleController.text = widget.webinarData['main subtitle'];
    // studentEnrolledController.text = widget.webinarData['student enrolled'];
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                color: Colors.blue[50],
                height: 60,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back),
                        ],
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(Icons.edit_location_outlined, size: 27),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'Edit Webinar',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    MaterialButton(
                      padding: EdgeInsets.only(right: 20),
                      onPressed: () {
                        _firestore.collection('Webinar').doc(course).update({
                          'trainer name': trainerNameController.text,
                          'designation': designationController.text,
                          'about mentor': aboutMentorController.text,
                          'webinar duration': webinarDurationController.text,
                          'payment': paymentController.text,
                          'course': courseController.text,
                          'super topic': superTitleController.text,
                          'main title': mainTitleController.text,
                          'main subtitle': mainSubtitleController.text,
                          'student enrolled': studentEnrolledController.text,
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_outline_outlined,
                            size: 40,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(100),
                    color: Colors.grey[50],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            RaisedButton(
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
                                    padding: EdgeInsets.all(15),
                                    child: Text(
                                      'Edit Upload',
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
                                    filename =
                                        basename(result.files.single.name);
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
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Please wait few soconds')));
                                  UploadTask uploadTask =
                                      firebaseStorageRef.putData(uploadfile);
                                  TaskSnapshot taskSnapshot =
                                      await uploadTask.whenComplete(() {
                                    setState(() {
                                      print("Profile Picture uploaded");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Staff Picture Uploaded')));
                                      uploadTask.snapshot.ref
                                          .getDownloadURL()
                                          .then((value) {
                                        setState(() {
                                          mentorImage = value;
                                        });
                                        _firestore
                                            .collection('Webinar')
                                            .doc(course)
                                            .update(
                                                {'trainer image': mentorImage});

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
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 420,
                              height: 520,
                              child: Image.network(
                                '${mentorImage}',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(45),
                                  color: Colors.grey[50],
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            width: 450,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              border: Border(
                                                top: BorderSide(
                                                    color: Colors.grey[200],
                                                    width: 1),
                                                bottom: BorderSide(
                                                    color: Colors.grey[200],
                                                    width: 1),
                                                left: BorderSide(
                                                    color: Colors.grey[200],
                                                    width: 1),
                                                right: BorderSide(
                                                    color: Colors.grey[200],
                                                    width: 1),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(50),
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 30),
                                                  _trainerNameField(),
                                                  SizedBox(height: 30),
                                                  _designation(),
                                                  SizedBox(height: 30),
                                                  _aboutMentor(),
                                                  SizedBox(height: 30),
                                                  _webinarDurationField(),
                                                  SizedBox(height: 30),
                                                  _payment(),
                                                  SizedBox(height: 30),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      RaisedButton(
                                                          color: Colors.white,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color: Color(
                                                                  0xff0090E9),
                                                              width: 3,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .date_range_outlined,
                                                                color:
                                                                    Colors.blue,
                                                              ),
                                                              SizedBox(
                                                                  width: 5),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                child: Text(
                                                                  'Date and Time',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    color: Color(
                                                                        0xff0090E9),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          textColor:
                                                              Colors.white,
                                                          onPressed: () async {
                                                            // DateTimePicker();
                                                            _selectDate(
                                                                context);
                                                          }),
                                                      RaisedButton(
                                                          child: Text('Send'),
                                                          onPressed: () {
                                                            _firestore
                                                                .collection(
                                                                    "Webinar")
                                                                .doc(course)
                                                                .update({
                                                              "timestamp": time
                                                            });
                                                          })
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(width: 100),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(100),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            RaisedButton(
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
                                    padding: EdgeInsets.all(15),
                                    child: Text(
                                      'Edit Upload',
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
                                    filename =
                                        basename(result.files.single.name);
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
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Please wait few soconds')));
                                  UploadTask uploadTask =
                                      firebaseStorageRef.putData(uploadfile);
                                  TaskSnapshot taskSnapshot =
                                      await uploadTask.whenComplete(() {
                                    setState(() {
                                      print("Profile Picture uploaded");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Staff Picture Uploaded')));
                                      uploadTask.snapshot.ref
                                          .getDownloadURL()
                                          .then((value) {
                                        setState(() {
                                          mentorImage2 = value;
                                        });

                                        _firestore
                                            .collection('Webinar')
                                            .doc(course)
                                            .update(
                                                {'mentor image': mentorImage2});

                                        print(
                                            "${mentorImage2} ////////////353 mentor Image");
                                      });
                                    });
                                  });
                                }

                                print('${mentorImage2}  /////359 mentor Image');
                                uploadPic(context);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 420,
                              height: 520,
                              child: Image.network(
                                '${mentorImage2}',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          width: 450,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[50],
                                            border: Border(
                                              top: BorderSide(
                                                  color: Colors.grey[200],
                                                  width: 1),
                                              bottom: BorderSide(
                                                  color: Colors.grey[200],
                                                  width: 1),
                                              left: BorderSide(
                                                  color: Colors.grey[200],
                                                  width: 1),
                                              right: BorderSide(
                                                  color: Colors.grey[200],
                                                  width: 1),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(50),
                                            child: Column(
                                              children: [
                                                SizedBox(height: 30),
                                                _courseField(),
                                                SizedBox(height: 30),
                                                _superTitleField(),
                                                SizedBox(height: 30),
                                                _mainTitleField(),
                                                SizedBox(height: 30),
                                                _mainSubtitleField(),
                                                SizedBox(height: 30),
                                                _studentEnrolledField(),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(width: 100),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 120),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(50),
                    color: Colors.grey[50],
                    child: Column(
                      children: [
                        Row(
                          children: [
                            RaisedButton(
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text(
                                      'Upload Video',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () async {
                                FilePickerResult result =
                                    await FilePicker.platform.pickFiles();

                                if (result != null) {
                                  uploadfile = result.files.single.bytes;
                                  setState(() {
                                    ContentEdit.filename =
                                        basename(result.files.single.name);
                                  });
                                  print(ContentEdit.filename);
                                } else {
                                  print('pick image');
                                }
                                ///////
                                Future uploadPic(BuildContext context) async {
                                  Reference firebaseStorageRef = FirebaseStorage
                                      .instance
                                      .ref()
                                      .child("Webinar")
                                      .child(ContentEdit.filename);
                                  UploadTask uploadTask =
                                      firebaseStorageRef.putData(uploadfile);
                                  TaskSnapshot taskSnapshot =
                                      await uploadTask.whenComplete(() {
                                    setState(() {
                                      print("Video uploaded");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Please wait for few seconds')));
                                      uploadTask.snapshot.ref
                                          .getDownloadURL()
                                          .then((value) {
                                        setState(() {
                                          ContentEdit.getLink = value;
                                        });

                                        print(ContentEdit.getLink);
                                        _firestore
                                            .collection('Webinar')
                                            .doc(course)
                                            .update({
                                          "webinar video": ContentEdit.getLink
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text('Video Uploaded')));
                                      });
                                    });
                                  });
                                }

                                setState(() {
                                  isComplete = true;
                                });
                                uploadPic(context);
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            UpcomingCourseImage(),
                          ],
                        ),
                        SizedBox(height: 120),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('Webinar').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading.....");
                  } else {
                    final messages = snapshot.data.docs;

                    List<Widget> content = [];
                    for (var message in messages) {
                      if (thisId == message.id) {
                        final topicTitle = message.data()['topic title'];
                        final topicSubtitle = message.data()['topic subtitle'];
                        final courseName = message.data()['course'];
                        print('==========================');
                        for (var i = 0;
                            i < ContentEdit.topicTitle.length;
                            i++) {
                          print(
                              '${ContentEdit.topicTitle[i]}   topictitle////////////////1003');
                          print(
                              "${topicSubtitle[i]}     topicSubtitle////////////1005");
                          Widget listile = ListTile(
                            title:
                                Center(child: Text(ContentEdit.topicTitle[i])),
                            subtitle: Center(
                                child: Text(ContentEdit.topicSubtitle[i])),
                            onTap: () {
                              alert(context,
                                  topic: topicTitle[i],
                                  subtitle: topicSubtitle[i],
                                  courseName: courseName);
                            },
                          );
                          content.add(listile);
                        }
                      }
                    }
                    return Column(
                      children: content,
                    );
                  }
                },
              ),
              TextButton(
                child: Text('upload'),
                onPressed: () {
                  print(topics);
                  _firestore.collection('Webinar').doc(course).update({
                    'topic title': FieldValue.arrayUnion(topics.keys.toList()),
                    'topic subtitle':
                        FieldValue.arrayUnion(topics.values.toList())
                  });
                  // _firestore
                  //     .collection('Webinar')
                  //     .doc(widget.webinarData['course'])
                  //     .update({
                  //   'topic title': FieldValue.arrayUnion(topics.keys.toList()),
                  //   'topic subtitle':
                  //       FieldValue.arrayUnion(topics.values.toList())
                  // });
                },
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class ListAlert extends StatefulWidget {
  Function onpress;
  String title;
  String subtitle;
  TextEditingController topicTitleController = TextEditingController();
  TextEditingController topicSubtitleController = TextEditingController();
  ListAlert(
      {this.onpress,
      this.topicTitleController,
      this.topicSubtitleController,
      this.title,
      this.subtitle});
  @override
  _ListAlertState createState() => _ListAlertState();
}

class _ListAlertState extends State<ListAlert> {
  Widget _titleField() {
    return TextFormField(
      enableSuggestions: true,
      style: TextStyle(
        fontSize: 16,
      ),
      maxLines: 10,
      validator: (value) {
        if (value.isEmpty) {
          print(value);
          return "query is required";
        } else if (value.length < 2) {
          return 'character should be more than 2';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 40, left: 5),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1, color: Colors.black54)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 1, color: Colors.blueAccent),
        ),
        labelText: 'Title',
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
      controller: widget.topicTitleController,
      onChanged: (value) {
        widget.title = value;
      },
    );
  }

  Widget _subTitleField() {
    return TextFormField(
      style: TextStyle(
        fontSize: 16,
      ),
      maxLines: 10,
      validator: (value) {
        if (value.isEmpty) {
          print(value);
          return "query is required";
        } else if (value.length < 2) {
          return 'character should be more than 2';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 40, left: 5),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1, color: Colors.black54)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 1, color: Colors.blueAccent),
        ),
        labelText: 'Sub Title',
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
      controller: widget.topicSubtitleController,
      onChanged: (value) {
        widget.subtitle = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    widget.topicTitleController.text = widget.title;
    widget.topicSubtitleController.text = widget.subtitle;
    return Container(
      height: 400,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(right: 15, top: 15),
                child: MaterialButton(
                  hoverColor: Colors.red[400],
                  height: 10,
                  minWidth: 20,
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 40),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 250,
                  child: _titleField(),
                ),
                SizedBox(height: 30),
                Container(
                  height: 100,
                  width: 250,
                  child: _subTitleField(),
                ),
                SizedBox(height: 30),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.green[500],
                  onPressed: widget.onpress,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('Add'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
