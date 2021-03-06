import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:ocean_live/models/routing.dart';
import 'package:ocean_live/screens/admin/batch_syllabus.dart';
import 'package:ocean_live/screens/admin/home.dart';
import 'package:provider/provider.dart';
// import 'package:velocity_x/velocity_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ocean_live/screens/admin/batch_students.dart';

import '../../constants.dart';

class BatchSchedule extends StatefulWidget {
  String trainer;
  BatchSchedule({this.trainer});
  @override
  _BatchScheduleState createState() => _BatchScheduleState();
}

class _BatchScheduleState extends State<BatchSchedule> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, List> studentList = {};
  List<String> bacthIDs = [];
  List<Widget> cards = [];
  int num;

  final _count = ValueNotifier(0);

  getBatchID() async {
    await for (var batchIdAdd in _firestore
        .collection('course')

        ///brindha Karthik
        .where('trainername', isEqualTo: widget.trainer)
        .snapshots(includeMetadataChanges: true)) {
      for (var bId in batchIdAdd.docs) {
        await searchBachId(bId.data()['batchid']);
        print(studentList[bId.data()['batchid']].length);
        ValueListenableBuilder card = ValueListenableBuilder(
          valueListenable: _count,
          builder: (context, count, child) {
            List nameList = [];
            return BatchIDCard(
              batchId: bId.data()['batchid'].toUpperCase(),
              courseDuration: '${bId.data()['duration']} Hrs',
              courseImageLink: '${bId.data()['img']}',
              courseTitle: '${bId.data()['coursename']}',
              studentCount: studentList[bId.data()['batchid']].length,
              onPressed: () {
                print('---------------------');
                print('${bId.data()['coursename']}');
                nameList.addAll([studentList['${bId.data()['batchid']}']]);
                Provider.of<Routing>(context, listen: false).updateRouting(
                    widget: BatchSudents(
                  studentList: nameList,
                  trinerBatchId: bId.data()['batchid'],
                ));
                print('---------------------');
              },
            );
          },
        );
        cards.add(card);
      }
    }
  }

  searchBachId(String bactchid) async {
    var students = await _firestore.collection('new users').get();
    List studentNameList = [];
    for (var i in students.docs) {
      var batchlist = i.data()['batchid'];

      for (var singleId in batchlist) {
        if (singleId == bactchid) {
          studentNameList.add([
            i.data()['First Name'],
            i.data()['Phone Number'],
            i.data()['Profile Picture'],
          ]);
        }
        studentList.addAll({bactchid: studentNameList});
        print(studentList);
        BatchSudents(studentList: studentNameList);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBatchID();
  }

  @override
  Widget build(BuildContext context) {
    print("syllabus${widget.trainer}");
    return Expanded(
      flex: 6,
      child: Padding(
        padding: pagePadding,
        child: Container(
          child: Wrap(
            runSpacing: 25,
            spacing: 25,
            alignment: WrapAlignment.center,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('course').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading........");
                  } else {
                    final messages = snapshot.data.docs;
                    List<BatchScheduleDb> staffSchedule = [];
                    for (var message in messages) {
                      final trainerName = message.data()['trainername'];
                      if (trainerName == widget.trainer) {
                        final id = message.data()["batchid"];
                        final trainer = trainerName;
                        final courseImage = message.data()["img"];
                        final duration = message.data()["duration"];
                        final courseName = message.data()["coursename"];
                        print("id${id}");

                        final staffData = BatchScheduleDb(
                          text: id,
                          course: courseName,
                          duration: duration,
                          trainerName: trainer,
                          image: courseImage,
                        );
                        staffSchedule.add(staffData);
                      }
                    }
                    return Wrap(
                      alignment: WrapAlignment.center,
                      children: staffSchedule,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BatchIDCard extends StatefulWidget {
  BatchIDCard(
      {this.batchId,
      this.courseDuration,
      this.courseImageLink,
      this.courseTitle,
      this.studentCount,
      this.onPressed});
  final String courseDuration;
  final String courseImageLink;
  final String courseTitle;
  final String batchId;
  final int studentCount;
  final Function onPressed;

  @override
  _BatchIDCardState createState() => _BatchIDCardState();
}

class _BatchIDCardState extends State<BatchIDCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      height: 400.0,
      width: 350,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              offset: Offset(3, 3),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                widget.courseDuration,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 20.0,
              )
            ],
          ),
          Container(
              height: 100.0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Divider(
                    thickness: 2,
                    color: Colors.grey[300],
                  ),
                  Positioned(
                    left: 20.0,
                    child: Row(
                      children: [
                        Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey[300], width: 2),
                              borderRadius: BorderRadius.circular(200),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(3, 3),
                                    blurRadius: 3),
                              ]),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(120),
                                child: Image.network(
                                  widget.courseImageLink,
                                  alignment: Alignment.centerLeft,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(bottom: 5, left: 3, right: 3),
                          color: Colors.white,
                          child: Text(
                            widget.courseTitle,
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
          Row(
            children: [
              Spacer(flex: 2),
              Text(
                'Batch ID',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[400]),
              ),
              Spacer(flex: 1),
              Text(
                widget.batchId,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[500]),
              ),
              Spacer(flex: 2),
            ],
          ),
          GestureDetector(
            onTap: widget.onPressed,
            child: Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 5,
                          offset: Offset(1, 2)),
                    ]),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 25,
                      child: Text(
                        '${widget.studentCount}',
                        style: TextStyle(
                            fontSize: 60,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Positioned(
                      bottom: 25,
                      child: Text(
                        'Student',
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class BatchScheduleDb extends StatefulWidget {
  String text;
  String course;
  String image;
  String duration;
  String trainerName;
  BatchScheduleDb(
      {this.text, this.course, this.trainerName, this.image, this.duration});
  @override
  _BatchScheduleDbState createState() => _BatchScheduleDbState();
}

class _BatchScheduleDbState extends State<BatchScheduleDb> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 6,
                offset: Offset(0, 3))
          ]),
      margin: EdgeInsets.all(30),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "${widget.text}",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff002C47),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Ubuntu"),
                  ),
                  Text(
                    "${widget.course}",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff002C47),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Ubuntu"),
                  ),
                  Text(
                    "${widget.duration}",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff002C47),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Ubuntu"),
                  ),
                  Text(
                    "${widget.trainerName}",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff002C47),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Ubuntu"),
                  ),
                ],
              ),
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(110),
                    child: Image.network(
                      widget.image,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonTheme(
                minWidth: 200,
                height: 30,
                child: RaisedButton(
                    child: Text(
                      "SCHEDULE",
                      style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Gilroy"),
                    ),
                    color: Color(0xFF36BAFF),
                    onPressed: () {
                      Provider.of<Routing>(context, listen: false)
                          .updateRouting(
                              widget: BatchSyllebus(
                        trinerID: widget.text,
                      ));
                    }),
              ),
            ],
          )
        ],
      ),
    );
  }
}
