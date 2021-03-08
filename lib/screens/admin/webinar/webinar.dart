import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import 'package:ocean_live/screens/admin/webinar/edit_alert/Content1_EditAlert.dart';
import 'package:ocean_live/screens/admin/webinar/screens/content1.dart';
import 'package:ocean_live/screens/admin/webinar/screens/content2.dart';
import 'package:ocean_live/screens/admin/webinar/screens/content3.dart';
import 'package:ocean_live/screens/admin/webinar/upload%20alert/Content1_UploadAlert.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_live/constants.dart';
import 'package:ocean_live/models/routing.dart';
import 'package:ocean_live/screens/admin/Details.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart';
import 'package:video_player/video_player.dart';

final _firestore = FirebaseFirestore.instance;

/// < Webinar Main Design > ///

class Webinar extends StatefulWidget {
  var getFields;
  Webinar({this.getFields});

  @override
  _WebinarState createState() => _WebinarState();
}

class _WebinarState extends State<Webinar> {
  bool _content1 = true;
  bool _content2 = false;
  bool _content3 = false;
  String dateTime;
  List listgetField = [];

  // getWebinarfields() async {
  //   var webinarCollection = await _firestore.collection('Webinar');
  //   var webinar = await webinarCollection.get();
  //
  //   for (var getWebinarfield in webinar.docs) {
  //     var getdata = getWebinarfield.data();
  //     print('${getdata} ////////47 getdata');
  //     for (var field in getdata.entries) {
  //       var subCollection = await webinarCollection
  //           .doc(getWebinarfield.id)
  //           .collection(field.value)
  //           .get();
  //
  //       var getFields = field.value;
  //
  //       listgetField.add('${getFields}');
  //
  //       print('${subCollection.docs} ///////////////');
  //       print('${getFields} ///////////50');
  //       print('${listgetField}  //////57 list of webinars');
  //     }
  //   }
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   getWebinarfields();
  //   print('hughgjhgkgkghjghkj///////////////////////////////////');
  // }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 100),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 70,
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 120),
                          Icon(
                            Icons.live_tv_outlined,
                            size: 40,
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Webinar',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _content1 = true;
                          _content2 = false;
                          _content3 = false;
                          Provider.of<Routing>(context, listen: false)
                              .updateRouting(widget: Webinar());
                        });
                        print('Content 1');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              _content1 ? Colors.blue[100] : Colors.grey[100],
                          border: Border(
                            top: BorderSide(
                              color: _content1
                                  ? Colors.blue[300]
                                  : Colors.grey[200],
                              width: _content1 ? 3 : 0,
                            ),
                            bottom: BorderSide(
                              color: _content1
                                  ? Colors.blue[300]
                                  : Colors.grey[200],
                              width: _content1 ? 3 : 0,
                            ),
                            right: BorderSide(
                              color: _content1
                                  ? Colors.blue[300]
                                  : Colors.grey[200],
                              width: _content1 ? 3 : 0,
                            ),
                            left: BorderSide(
                              color: _content1
                                  ? Colors.blue[300]
                                  : Colors.grey[200],
                              width: _content1 ? 3 : 0,
                            ),
                          ),
                        ),
                        height: 50,
                        width: 150,
                        child: Center(
                          child: Text(
                            'Content 1',
                            style: TextStyle(
                              color: _content1 ? Colors.blue : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _content1 = false;
                          _content2 = true;
                          _content3 = false;
                        });
                        print('Content 3');
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color:
                              _content2 ? Colors.blue[100] : Colors.grey[100],
                          border: Border(
                            top: BorderSide(
                              color: _content2
                                  ? Colors.blue[300]
                                  : Colors.grey[200],
                              width: _content2 ? 3 : 0,
                            ),
                            bottom: BorderSide(
                              color: _content2
                                  ? Colors.blue[300]
                                  : Colors.grey[200],
                              width: _content2 ? 3 : 0,
                            ),
                            right: BorderSide(
                              color: _content2
                                  ? Colors.blue[300]
                                  : Colors.grey[200],
                              width: _content2 ? 3 : 0,
                            ),
                            left: BorderSide(
                              color: _content2
                                  ? Colors.blue[300]
                                  : Colors.grey[200],
                              width: _content2 ? 3 : 0,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Content 2',
                            style: TextStyle(
                              color: _content2 ? Colors.blue : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _content1 = false;
                          _content2 = false;
                          _content3 = true;
                        });
                        print('Content 3');
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color:
                              _content3 ? Colors.blue[100] : Colors.grey[100],
                          border: Border(
                            top: BorderSide(
                              color: _content3
                                  ? Colors.blue[300]
                                  : Colors.grey[200],
                              width: _content3 ? 3 : 0,
                            ),
                            bottom: BorderSide(
                              color: _content3
                                  ? Colors.blue[300]
                                  : Colors.grey[200],
                              width: _content3 ? 3 : 0,
                            ),
                            right: BorderSide(
                              color: _content3
                                  ? Colors.blue[300]
                                  : Colors.grey[200],
                              width: _content3 ? 3 : 0,
                            ),
                            left: BorderSide(
                              color: _content3
                                  ? Colors.blue[300]
                                  : Colors.grey[200],
                              width: _content3 ? 3 : 0,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Content 3',
                            style: TextStyle(
                              color: _content3 ? Colors.blue : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60),
                _content1
                    ? Content1()
                    : _content2
                        ? Content2()
                        : Content3(),
                SizedBox(height: 70),
                // Column(
                //   children: [
                //     Row(
                //       children: [
                //         Expanded(
                //           child: Container(
                //             decoration: BoxDecoration(
                //               color: Colors.blue[50],
                //             ),
                //             height: 50,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 120,
                //                   child: Text(
                //                     'Text',
                //                     style:
                //                         TextStyle(fontWeight: FontWeight.bold),
                //                   ),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 150,
                //                   child: Text(
                //                     'Text',
                //                     style:
                //                         TextStyle(fontWeight: FontWeight.bold),
                //                   ),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 150,
                //                   child: Text(
                //                     'Text',
                //                     style:
                //                         TextStyle(fontWeight: FontWeight.bold),
                //                   ),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 130,
                //                   child: Text(
                //                     'Text',
                //                     style:
                //                         TextStyle(fontWeight: FontWeight.bold),
                //                   ),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 180,
                //                   child: Text(
                //                     'Text',
                //                     style:
                //                         TextStyle(fontWeight: FontWeight.bold),
                //                   ),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 50,
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 50,
                //                 ),
                //               ],
                //             ),
                //           ),
                //         )
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Expanded(
                //           child: Container(
                //             decoration: BoxDecoration(
                //                 color: Colors.white60,
                //                 border: Border(
                //                   bottom: BorderSide(
                //                       color: Colors.grey[300], width: 1),
                //                 )),
                //             height: 100,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Container(
                //                   padding: EdgeInsets.all(20),
                //                   alignment: Alignment.center,
                //                   width: 120,
                //                   child: Image.asset(
                //                     'images/steve jobs.jpg',
                //                     fit: BoxFit.cover,
                //                   ),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 150,
                //                   child: Text(
                //                     'Mohamed Ijass Ijass',
                //                     maxLines: 2,
                //                   ),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 150,
                //                   child: Text('Course'),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 130,
                //                   child: Text('Payment'),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 180,
                //                   child: Text('Date and Time'),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 50,
                //                   child: RaisedButton(
                //                     hoverColor: Colors.grey[100],
                //                     hoverElevation: 0,
                //                     color: Colors.white60,
                //                     onPressed: () {},
                //                     child: Icon(Icons.edit_outlined),
                //                   ),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 50,
                //                   child: RaisedButton(
                //                     shape: RoundedRectangleBorder(
                //                       borderRadius: BorderRadius.circular(5),
                //                     ),
                //                     padding: EdgeInsets.zero,
                //                     hoverColor: Colors.grey[200],
                //                     hoverElevation: 0,
                //                     color: Colors.white60,
                //                     onPressed: () {},
                //                     child: Icon(Icons.delete_outline_outlined),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         )
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Expanded(
                //           child: Container(
                //             decoration: BoxDecoration(
                //                 color: Colors.white60,
                //                 border: Border(
                //                   bottom: BorderSide(
                //                       color: Colors.grey[300], width: 1),
                //                 )),
                //             height: 100,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Container(
                //                   padding: EdgeInsets.all(20),
                //                   alignment: Alignment.center,
                //                   width: 120,
                //                   child: Image.asset(
                //                     'images/pichai.jpg',
                //                     fit: BoxFit.cover,
                //                   ),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 150,
                //                   child: Text(
                //                     'Mohamed Ijass Ijass',
                //                     maxLines: 2,
                //                   ),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 150,
                //                   child: Text('Course'),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 130,
                //                   child: Text('Payment'),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 180,
                //                   child: Text('Date and Time'),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 50,
                //                   child: Icon(Icons.edit_outlined),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 50,
                //                   child: Icon(Icons.delete_outline_outlined),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         )
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Expanded(
                //           child: Container(
                //             decoration: BoxDecoration(
                //                 color: Colors.white60,
                //                 border: Border(
                //                   bottom: BorderSide(
                //                       color: Colors.grey[300], width: 1),
                //                 )),
                //             height: 100,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Container(
                //                   padding: EdgeInsets.all(10),
                //                   alignment: Alignment.center,
                //                   width: 120,
                //                   child: Image.asset(
                //                     'images/girl.jpg',
                //                     fit: BoxFit.cover,
                //                   ),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 150,
                //                   child: Text(
                //                     'Mohamed Ijass Ijass',
                //                     maxLines: 2,
                //                   ),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 150,
                //                   child: Text('Course'),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 130,
                //                   child: Text('Payment'),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 180,
                //                   child: Text('Date and Time'),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 50,
                //                   child: Icon(Icons.edit_outlined),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 50,
                //                   child: Icon(Icons.delete_outline_outlined),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         )
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Expanded(
                //           child: Container(
                //             decoration: BoxDecoration(
                //                 color: Colors.white60,
                //                 border: Border(
                //                   bottom: BorderSide(
                //                       color: Colors.grey[300], width: 1),
                //                 )),
                //             height: 100,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Container(
                //                   padding: EdgeInsets.all(10),
                //                   alignment: Alignment.center,
                //                   width: 120,
                //                   child: Image.asset('images/girl.jpg'),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 150,
                //                   child: Text(
                //                     'Mohamed Ijass Ijass',
                //                     maxLines: 2,
                //                   ),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 150,
                //                   child: Text('Course'),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 130,
                //                   child: Text('Payment'),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 180,
                //                   child: Text('Date and Time'),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 50,
                //                   child: Icon(Icons.edit_outlined),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 50,
                //                   child: Icon(Icons.delete_outline_outlined),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         )
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Expanded(
                //           child: Container(
                //             decoration: BoxDecoration(
                //                 color: Colors.white60,
                //                 border: Border(
                //                   bottom: BorderSide(
                //                       color: Colors.grey[300], width: 1),
                //                 )),
                //             height: 100,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Container(
                //                   padding: EdgeInsets.all(10),
                //                   alignment: Alignment.center,
                //                   width: 120,
                //                   child: Image.asset('images/girl.jpg'),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 150,
                //                   child: Text(
                //                     'Mohamed Ijass Ijass',
                //                     maxLines: 2,
                //                   ),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 150,
                //                   child: Text('Course'),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 130,
                //                   child: Text('Payment'),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 180,
                //                   child: Text('Date and Time'),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 50,
                //                   child: Icon(Icons.edit_outlined),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 50,
                //                   child: Icon(Icons.delete_outline_outlined),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         )
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Expanded(
                //           child: Container(
                //             decoration: BoxDecoration(
                //                 color: Colors.white60,
                //                 border: Border(
                //                   bottom: BorderSide(
                //                       color: Colors.grey[300], width: 1),
                //                 )),
                //             height: 100,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Container(
                //                   padding: EdgeInsets.all(10),
                //                   alignment: Alignment.center,
                //                   width: 120,
                //                   child: Image.asset('images/girl.jpg'),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 150,
                //                   child: Text(
                //                     'Mohamed Ijass Ijass',
                //                     maxLines: 2,
                //                   ),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 150,
                //                   child: Text('Course'),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 130,
                //                   child: Text('Payment'),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 180,
                //                   child: Text('Date and Time'),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 50,
                //                   child: Icon(Icons.edit_outlined),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 50,
                //                   child: Icon(Icons.delete_outline_outlined),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         )
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Expanded(
                //           child: Container(
                //             decoration: BoxDecoration(
                //                 color: Colors.white60,
                //                 border: Border(
                //                   bottom: BorderSide(
                //                       color: Colors.grey[300], width: 1),
                //                 )),
                //             height: 100,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Container(
                //                   padding: EdgeInsets.all(10),
                //                   alignment: Alignment.center,
                //                   width: 120,
                //                   child: Image.asset('images/girl.jpg'),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 150,
                //                   child: Text(
                //                     'Mohamed Ijass Ijass',
                //                     maxLines: 2,
                //                   ),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 150,
                //                   child: Text('Course'),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 130,
                //                   child: Text('Payment'),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 180,
                //                   child: Text('Date and Time'),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 50,
                //                   child: Icon(Icons.edit_outlined),
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   width: 50,
                //                   child: Icon(Icons.delete_outline_outlined),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         )
                //       ],
                //     ),
                //   ],
                // ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                        ),
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 120,
                              child: Text(
                                'Trainer Image',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 150,
                              child: Text(
                                'Trainer Name',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 150,
                              child: Text(
                                'Content',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 130,
                              child: Text(
                                'Payment',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 180,
                              child: Text(
                                'Date & Time',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 50,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 50,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('free_webinar').snapshots(),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text("Loading.....");
                    } else {
                      final messages = snapshot.data.docs;
                      print('${messages}  ////862 Webinar documents');
                      List<Dbcontent> upcoming = [];
                      for (var message in messages) {
                        final dbTrainerImage = message.data()['trainer image'];
                        final dbTrainerName = message.data()['trainer name'];
                        final dbCourse = message.data()['course'];
                        final dbPayment = message.data()['payment'];
                        final dbTimeStamp = message.data()['timestamp'];
                        int yearFormat;
                        int monthFormat;
                        int dayFormat;
                        int hourFormat;
                        int minuteFormat;

                        print('=============');
                        var year = DateFormat('y');
                        var month = DateFormat('MM');
                        var day = DateFormat('d');
                        var hour = DateFormat('hh');
                        var minute = DateFormat('mm');

                        yearFormat =
                            int.parse(year.format(dbTimeStamp.toDate()));
                        monthFormat =
                            int.parse(month.format(dbTimeStamp.toDate()));
                        dayFormat = int.parse(day.format(dbTimeStamp.toDate()));
                        hourFormat =
                            int.parse(hour.format(dbTimeStamp.toDate()));
                        minuteFormat =
                            int.parse(minute.format(dbTimeStamp.toDate()));

                        var Date =
                            '${dayFormat} - ${monthFormat} - ${yearFormat}  ${hourFormat} : ${minuteFormat}';
                        // var sDate = DateTime(yearFormat, monthFormat, dayFormat,
                        //     hourFormat, minuteFormat)
                        //     .difference(DateTime.now())
                        //     .inSeconds;

                        final Db = Dbcontent(
                          trainerImage: dbTrainerImage,
                          trainerName: dbTrainerName,
                          courses: dbCourse,
                          payment: dbPayment,
                          timestamp: Date,
                        );
                        upcoming.add(Db);
                      }
                      return Column(
                        children: upcoming,
                      );
                    }
                  },
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('paid_webinar').snapshots(),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text("Loading.....");
                    } else {
                      final messages = snapshot.data.docs;
                      print('${messages}  ////259 Webinar documents');
                      List<Dbcontent> upcoming = [];
                      for (var message in messages) {
                        final dbTrainerImage = message.data()['trainer image'];
                        final dbTrainerName = message.data()['trainer name'];
                        final dbCourse = message.data()['course'];
                        final dbPayment = message.data()['payment'];
                        final dbTimeStamp = message.data()['timestamp'];
                        int yearFormat;
                        int monthFormat;
                        int dayFormat;
                        int hourFormat;
                        int minuteFormat;

                        print('=============');
                        var year = DateFormat('y');
                        var month = DateFormat('MM');
                        var day = DateFormat('d');
                        var hour = DateFormat('hh');
                        var minute = DateFormat('mm');

                        yearFormat =
                            int.parse(year.format(dbTimeStamp.toDate()));
                        monthFormat =
                            int.parse(month.format(dbTimeStamp.toDate()));
                        dayFormat = int.parse(day.format(dbTimeStamp.toDate()));
                        hourFormat =
                            int.parse(hour.format(dbTimeStamp.toDate()));
                        minuteFormat =
                            int.parse(minute.format(dbTimeStamp.toDate()));

                        var Date =
                            '${dayFormat} - ${monthFormat} - ${yearFormat}  ${hourFormat} : ${minuteFormat}';
                        final Db = Dbcontent(
                          trainerImage: dbTrainerImage,
                          trainerName: dbTrainerName,
                          courses: dbCourse,
                          payment: dbPayment,
                          timestamp: Date,
                        );
                        upcoming.add(Db);
                      }
                      return Column(
                        children: upcoming,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Dbcontent extends StatefulWidget {
  String trainerImage;
  String trainerName;
  String courses;
  String payment;
  var timestamp;

  Dbcontent(
      {this.trainerImage,
      this.trainerName,
      this.courses,
      this.payment,
      this.timestamp});

  @override
  _DbcontentState createState() => _DbcontentState();
}

class _DbcontentState extends State<Dbcontent> {
  delete() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white60,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[300], width: 1),
                    )),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      width: 120,
                      child: Image.network(
                        '${widget.trainerImage}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 150,
                      child: Text(
                        '${widget.trainerName}',
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 150,
                      child: Text('${widget.courses}'),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 130,
                      child: Text('${widget.payment}'),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 180,
                      child: Text('${widget.timestamp}'),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 50,
                      child: RaisedButton(
                        hoverColor: Colors.grey[100],
                        hoverElevation: 0,
                        color: Colors.white60,
                        onPressed: () {
                          displayDialog(
                              context: context, name: Content1EditAlert());
                        },
                        child: Icon(Icons.edit_outlined),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 50,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.zero,
                        hoverColor: Colors.grey[200],
                        hoverElevation: 0,
                        color: Colors.white60,
                        onPressed: () {
                          StreamBuilder<QuerySnapshot>(
                              stream: _firestore
                                  .collection('free_webinar')
                                  .where(widget.courses)
                                  .snapshots(),
                              // ignore: missing_return
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Text("Loading.....");
                                } else {
                                  final messages = snapshot.data.docs;
                                  print(
                                      '${messages}  ////1100 Webinar documents');
                                  List<Dbcontent> upcoming = [];
                                  for (var message in messages) {
                                    final dbTrainerImage =
                                        message.data()['trainer image'];
                                    final dbTrainerName =
                                        message.data()['trainer name'];
                                    final dbCourse = message.data()['course'];
                                    final dbPayment = message.data()['payment'];
                                    final dbTimeStamp =
                                        message.data()['timestamp'];
                                  }
                                }
                              });
                          // StreamBuilder<QuerySnapshot>(
                          //     stream: _firestore
                          //         .collection('paid_webinar')
                          //         .snapshots(),
                          //     // ignore: missing_return
                          //     builder: (context, snapshot) {
                          //       if (!snapshot.hasData) {
                          //         return Text("Loading.....");
                          //       } else {
                          //         final messages = snapshot.data.docs;
                          //         print(
                          //             '${messages}  ////259 Webinar documents');
                          //         List<Dbcontent> upcoming = [];
                          //         for (var message in messages) {
                          //           final dbTrainerImage =
                          //               message.data()['trainer image'];
                          //           final dbTrainerName =
                          //               message.data()['trainer name'];
                          //           final dbCourse = message.data()['course'];
                          //           final dbPayment = message.data()['payment'];
                          //           final dbTimeStamp =
                          //               message.data()['timestamp'];
                          //         }
                          //       }
                          //     });
                        },
                        child: Icon(Icons.delete_outline_outlined),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

// /// < StremBuilder Content 1 > ///
//
// class DbContent1 extends StatefulWidget {
//   String trainerName;
//   String trainerImage;
//   String superTitle;
//   String mainTitle;
//   String mainSubtitle;
//
//   DbContent1(
//       {this.trainerImage,
//       this.superTitle,
//       this.mainTitle,
//       this.mainSubtitle,
//       this.trainerName});
//   @override
//   _DbContent1State createState() => _DbContent1State();
// }
//
// class _DbContent1State extends State<DbContent1> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(50),
//           color: Colors.grey[100],
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Container(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Heading 1',
//                             style: TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.w600),
//                           ),
//                           SizedBox(height: 20),
//                           Container(
//                             child: Padding(
//                               padding: EdgeInsets.all(25),
//                               child: Text(
//                                 "${widget.superTitle}",
//                                 style: TextStyle(fontSize: 16),
//                                 softWrap: true,
//                                 maxLines: 6,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           Container(
//                             child: Text(
//                               'Heading 2',
//                               style: TextStyle(
//                                   fontSize: 20, fontWeight: FontWeight.w600),
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           Container(
//                             child: Padding(
//                               padding: EdgeInsets.all(25),
//                               child: Text(
//                                 "${widget.mainTitle}",
//                                 style: TextStyle(fontSize: 16),
//                                 softWrap: true,
//                                 maxLines: 6,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           Container(
//                             child: Text(
//                               'Heading 3',
//                               style: TextStyle(
//                                   fontSize: 20, fontWeight: FontWeight.w600),
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           Container(
//                             child: Padding(
//                               padding: EdgeInsets.all(25),
//                               child: Text(
//                                 "${widget.mainSubtitle}",
//                                 style: TextStyle(fontSize: 16),
//                                 softWrap: true,
//                                 maxLines: 6,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 20),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             height: 350,
//                             width: 500,
//                             child: Image.network(
//                               "${widget.trainerImage}",
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           Container(
//                             alignment: Alignment.bottomCenter,
//                             width: 500,
//                             child: Text(
//                               '${widget.trainerName}',
//                               style: TextStyle(
//                                   fontSize: 20, fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// /// < content 3 Strembuilder > ///
//
// class Dbcontent3 extends StatefulWidget {
//   String mentorImage;
//   String mentorDescription;
//
//   Dbcontent3({this.mentorImage, this.mentorDescription});
//
//   @override
//   _Dbcontent3State createState() => _Dbcontent3State();
// }
//
// class _Dbcontent3State extends State<Dbcontent3> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(50),
//           color: Colors.grey[100],
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Container(
//                   width: 800,
//                   child: Padding(
//                     padding: EdgeInsets.all(20),
//                     child: Text(
//                       '${widget.mentorDescription}',
//                       style: TextStyle(height: 2, letterSpacing: 0.2),
//                       maxLines: 20,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   height: 300,
//                   width: 300,
//                   child: Image.network(
//                     '${widget.mentorImage}',
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

///< Alert Dialog >///

Future<void> displayDialog({name, context}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return Container(
        color: Colors.black54,
        child: AlertDialog(
          // buttonPadding: EdgeInsets.zero,
          // insetPadding: EdgeInsets.zero,
          // titlePadding: EdgeInsets.zero,
          // actionsPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          content: SingleChildScrollView(child: name),
          actions: <Widget>[],
        ),
      );
    },
  );
}

/////////////////////////////////////////////////////////////////////////////////////

class MentorVideos extends StatefulWidget {
  static String filename;
  static var getLink;
  String imageLink;
  @override
  _MentorVideosState createState() => _MentorVideosState();
}

class _MentorVideosState extends State<MentorVideos> {
  Uint8List uploadfile;
  bool isComplete = false, isOnline = false, isOffline = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: SingleChildScrollView(
        child: Container(
          padding: pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('webinarvideo').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading.....");
                  } else {
                    final messages = snapshot.data.docs;
                    List<UpcomingCourseImage> upcoming = [];
                    for (var message in messages) {
                      final messageImage = message.data()['webinarvideo'];
                      final upcomingImage = UpcomingCourseImage(
                        imagePath: messageImage,
                      );
                      upcoming.add(upcomingImage);
                    }
                    return Wrap(
                      //alignment: WrapAlignment.start,
                      spacing: 20.0,
                      runSpacing: 20.0,
                      children: upcoming,
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

class UpcomingCourseImage extends StatefulWidget {
  UpcomingCourseImage({this.imagePath});
  final String imagePath;

  @override
  _UpcomingCourseImageState createState() => _UpcomingCourseImageState();
}

class _UpcomingCourseImageState extends State<UpcomingCourseImage> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      '${widget.imagePath}',
    );
    print('${widget.imagePath}');

    // Initielize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  String docid;
  bool isVisible = false;
  String horizondal;

  void messageStream() async {
    await for (var snapshot in _firestore
        .collection('Video')
        .where("Video", isEqualTo: widget.imagePath)
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        //print(message.documentID);
        horizondal = message.documentID;
        print(horizondal);
      }
      docid = horizondal;
    }
  }

  @override
  Widget build(BuildContext context) {
    Padding deleteDetails({newLink, document}) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(
              FontAwesomeIcons.trashAlt,
              size: 90,
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Are you Sure want to delete this ?",
              style: TextStyle(fontSize: 30, color: Color(0xFF464646)),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                button(
                    text: "No",
                    onPress: () {
                      Navigator.pop(this.context);
                    }),
                SizedBox(
                  width: 10,
                ),
                outlinebutton(
                    text: "Yes",
                    onPress: () {
                      messageStream();
                      print("${docid}hhhhhhh");
                      print("${horizondal}jayaa");
                      setState(() async {
                        var removeImage =
                            FirebaseStorage.instance.ref().child(newLink);

                        try {
                          await removeImage.delete();
                        } catch (e) {
                          print(e);
                        }
                        Navigator.pop(this.context);

                        setState(() {
                          print("Video Deleted");
                          ScaffoldMessenger.of(this.context).showSnackBar(
                              SnackBar(content: Text('Video Deleted')));
                        });

                        _firestore.collection("Video").doc(horizondal).delete();
                      });
                    })
              ],
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 400,
          height: 220,
          child: InkWell(
            onTap: () {},
            onHover: (isHovering) {
              if (isHovering) {
                print("Mouse over");
                setState(() {
                  isVisible = true;
                });
              } else {
                print("mouse out");
                setState(() {
                  isVisible = false;
                });
              }
            },
            child: Stack(
              children: [
                Container(
                  width: 400,
                  height: 400,
                  child: FutureBuilder(
                    future: _initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // If the VideoPlayerController has finished initialization, use
                        // the data it provides to limit the aspect ratio of the video.
                        return AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          // Use the VideoPlayer widget to display the video.
                          child: ClipRRect(
                            child: ClipRRect(
                              child: VideoPlayer(_controller),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        );
                      } else {
                        // If the VideoPlayerController is still initializing, show a
                        // loading spinner.
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                Positioned(
                  left: 120,
                  bottom: 50,
                  child: ButtonTheme(
                      height: 10.0,
                      minWidth: 20.0,
                      child: RaisedButton(
                        color: Colors.transparent,
                        textColor: Colors.white,
                        onPressed: () {
                          // Wrap the play or pause in a call to `setState`. This ensures the
                          // correct icon is shown.
                          setState(() {
                            // If the video is playing, pause it.
                            if (_controller.value.isPlaying) {
                              _controller.pause();
                            } else {
                              // If the video is paused, play it.
                              _controller.play();
                            }
                          });
                        },
                        child: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 120.0,
                        ),
                      )),
                ),
                Visibility(
                  visible: isVisible,
                  child: Positioned(
                    top: 13,
                    right: 15,
                    child: CircleAvatar(
                      backgroundColor: Color(0xFF504E4E),
                      radius: 15,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(FontAwesomeIcons.times),
                          color: Colors.white,
                          onPressed: () {
                            displayDialog(
                                name: deleteDetails(
                                    newLink: widget.imagePath,
                                    document: horizondal),
                                context: context);
                          }),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
