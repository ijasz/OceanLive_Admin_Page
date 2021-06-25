import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_live/screens/admin/notification/send_notification.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class BatchDrop extends StatefulWidget {
  static String dropdownValue = "Enter Batch Id";
  static String studentid;
  @override
  _BatchDropState createState() => _BatchDropState();
}

class _BatchDropState extends State<BatchDrop> {
  List<DropdownMenuItem<String>> userNotifyList = [
    DropdownMenuItem(
      child: Text(
        'Enter Batch Id',
        style: TextStyle(color: Colors.black),
      ),
      value: 'Enter Batch Id',
    )
  ];

  userNotify() async {
    var users = await _firestore.collection('course').get();
    print(users.docs);
    for (var courses in users.docs) {
      print(courses.id);

      DropdownMenuItem<String> dropList = DropdownMenuItem(
        child: Text(
          '${courses.id} ',
          style: TextStyle(color: Colors.black),
        ),
        value: '${courses.id} ',
      );
      userNotifyList.add(dropList);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userNotify();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 60,
      width: 250,
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.black, width: 1.0)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: BatchDrop.dropdownValue,
          icon: Icon(FontAwesomeIcons.angleDown),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.black),
          onChanged: (newValue) {
            setState(() {
              BatchDrop.dropdownValue = newValue;
              // userNotify();
            });
          },
          items: userNotifyList,
        ),
      ),
    );
  }
}
