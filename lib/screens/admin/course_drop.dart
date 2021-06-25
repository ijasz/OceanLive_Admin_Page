import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_live/screens/admin/notification/send_notification.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class CourseDrop extends StatefulWidget {
  static String dropdownValue = "Select Course Name";
  static String studentid;
  @override
  _CourseDropState createState() => _CourseDropState();
}

class _CourseDropState extends State<CourseDrop> {
  List<DropdownMenuItem<String>> userNotifyList = [
    DropdownMenuItem(
      child: Text(
        'Select Course Name',
        style: TextStyle(color: Colors.black),
      ),
      value: 'Select Course Name',
    )
  ];

  userNotify() async {
    var users = await _firestore.collection('course').get();
    print(users.docs);
    for (var courses in users.docs) {
      print(courses.data()['coursename']);

      DropdownMenuItem<String> dropList = DropdownMenuItem(
        child: Text(
          '${courses.data()['coursename']} ',
          style: TextStyle(color: Colors.black),
        ),
        value: '${courses.data()['coursename']} ',
      );
      userNotifyList.add(dropList);
    }
  }

  bool isVisible = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userNotify();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.black, width: 1.0)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: CourseDrop.dropdownValue,
          icon: Icon(FontAwesomeIcons.angleDown),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.black),
          onChanged: (newValue) {
            setState(() {
              CourseDrop.dropdownValue = newValue;
              // userNotify();
            });
          },
          items: userNotifyList,
        ),
      ),
    );
  }
}
