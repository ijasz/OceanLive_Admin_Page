import 'package:intl/intl.dart';
import 'package:ocean_live/screens/admin/webinar/edit_alert/ContentEdit.dart';
import 'package:ocean_live/screens/admin/webinar/screens/content1.dart';
import 'package:ocean_live/screens/admin/webinar/screens/content2.dart';
import 'package:ocean_live/screens/admin/webinar/screens/content3.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_live/constants.dart';
import 'package:ocean_live/models/routing.dart';
import 'package:ocean_live/screens/admin/Details.dart';
import 'package:provider/provider.dart';
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
  TextEditingController _heading1Controller = TextEditingController();
  TextEditingController heading2Controller = TextEditingController();
  TextEditingController heading3Controller = TextEditingController();
  TextEditingController trainerNameController = TextEditingController();
  TextEditingController webinarDurationController = TextEditingController();
  bool _content1 = true;
  bool _content2 = false;
  bool _content3 = false;
  String dateTime;
  List listgetField = [];

  getData() async {
    var get = await _firestore.collection('free_webinar').get();

    for (var o in get.docs) {
      print('${o.id} //////48');
    }
    print('${get}  46///   free_webinar length ');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

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
  //
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
                  stream: _firestore.collection('Webinar').snapshots(),
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

                        print(
                            '${dbTrainerName}           ////////////////923contoller');
                        final Db = Dbcontent(
                          trainerImage: dbTrainerImage,
                          trainerName: dbTrainerName,
                          courses: dbCourse,
                          payment: dbPayment,
                          timestamp: Date,
                          onpressEdit: () async {
                            var webinarData = await _firestore
                                .collection('Webinar')
                                .doc(message.data()['course'])
                                .get();
                            print(webinarData.data());
                            Provider.of<Routing>(context, listen: false)
                                .updateRouting(
                                    widget: ContentEdit(
                                        webinarData: webinarData.data()));
                            print('${Date}   DAte/////////////////////////429');
                          },
                          onpress: () {
                            _firestore
                                .collection('Webinar')
                                .doc(message.data()['course'])
                                .delete();
                          },
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
  Function onpress;
  Function onpressEdit;

  Dbcontent(
      {this.trainerImage,
      this.trainerName,
      this.courses,
      this.payment,
      this.timestamp,
      this.onpress,
      this.onpressEdit});

  @override
  _DbcontentState createState() => _DbcontentState();
}

class _DbcontentState extends State<Dbcontent> {
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
                        onPressed: widget.onpressEdit,
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
                        onPressed: widget.onpress,
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

///////////////////////////////////////////////////////////////////////////////////

class UpcomingCourseImage extends StatefulWidget {
  @override
  _UpcomingCourseImageState createState() => _UpcomingCourseImageState();
}

class _UpcomingCourseImageState extends State<UpcomingCourseImage> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      '${ContentEdit.video}',
    );
    print('${ContentEdit.video}');

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

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 600,
          height: 400,
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
                        return Center(
                            child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ));
                      }
                    },
                  ),
                ),
                Positioned(
                  top: 120,
                  left: 250,
                  child: Center(
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
                        size: 80.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
