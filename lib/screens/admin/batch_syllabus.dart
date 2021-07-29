import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class BatchSyllebus extends StatefulWidget {
  BatchSyllebus({this.trinerID});
  final trinerID;
  Color activeColor = Colors.blue;
  Color successColor = Colors.green;
  Color disableColor = Colors.grey;

  @override
  _BatchSyllebusState createState() => _BatchSyllebusState();
}

class _BatchSyllebusState extends State<BatchSyllebus> {
  bool isTrue = false;
  Map boolContent = {};

  TextEditingController _duration = TextEditingController();
  TextEditingController _disctription = TextEditingController();
  TextEditingController _zoomLink = TextEditingController();
  TextEditingController _zoopPassword = TextEditingController();

  List<String> timeAndDate = [];

  String time;

  /// ttime module
  String _hour, _minute, _time;

  String dateTime;
  num year;
  num day;
  num month;
  num hour;
  num minute;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  DateTime timing;
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
        var a = '$selectedDate $tpicked';
        timing = DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, tpicked.hour, tpicked.minute);
        print(DateTime);
        print('=====================');
        print(timing);
        print("jaya");
        print(timing.runtimeType);
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
    year = int.parse(DateFormat('y').format(selectedDate));
    month = int.parse(DateFormat('MM').format(selectedDate));
    day = int.parse(DateFormat('d').format(selectedDate));
    print(year);
    print(month);
    print(day);
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(selectedDate.year, selectedDate.month, selectedDate.day,
                selectedTime.hour, selectedTime.minute),
            [hh, ':', nn]).toString();
      });
    print(_hour);
    print(_minute);
    hour = int.parse(_hour);
    minute = int.parse(_minute);
    var a = ("${_timeController.text} ${_dateController.text}");
    print(a);
  }

  ///end of time module

  @override
  void initState() {
    // TODO: implement initState
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  /// time module

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 6,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('course')
                      .doc(widget.trinerID)
                      .collection("syllabus")
                      .snapshots(),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text("Loading.....");
                    } else {
                      final messages = snapshot.data.docs;

                      for (var message in messages) {
                        final topics = message.data()['section'];
                        final isCheckValue = message.data()['flag'];
                        final dbTimeAndDate = message.data()['time'];
                        boolContent[topics] = isCheckValue;
                        timeAndDate.add(dbTimeAndDate);
                      }
                      return TopicWidget(
                        content: boolContent,
                        dateAndTime: timeAndDate,
                        trainer: widget.trinerID,
                      );
                      // return Text("welcome");
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FlatButton(
                    minWidth: 300,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    height: 50,
                    color: Colors.blue,
                    child: Text(
                      'SCHEDULE',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 23),
                    ),
                    onPressed: () async {
                      print('${boolContent} checkListttttttttttttttttttttt');
                      print('${TopicWidget.id} 11111111111111111111111');
                      for (var scheduleUpdate in boolContent.entries) {
                        bool done = scheduleUpdate.value;
                        String doneTopic = scheduleUpdate.key;
                        print(done);
                        print("done1 ${done}");
                        print("doneTopic1 ${doneTopic}");
                        _firestore
                            .collection('course')
                            .doc(widget.trinerID)
                            .collection("syllabus")
                            .doc(TopicWidget.id)
                            .update({'flag': true});
                      }
                      _showDialog();
                      scheduleId();
                    },
                  ),
                ),
              ],
            )),
          ),
        ));
  }

  List horizondal = [];
  void scheduleId() async {
    print("+++++++++++++++++");
    print(widget.trinerID);
    await for (var snapshot in _firestore
        .collection('course')
        .doc(widget.trinerID)
        .collection("schedule")
        .snapshots(includeMetadataChanges: true)) {
      print("checking");
      for (var message in snapshot.docs) {
        print("check1");
        String id = message.id;
        horizondal.add(id);
        print("${horizondal}zoom_link");
      }
    }
    // _saveSchedule();
  }

  void _saveSchedule() async {
    print('${boolContent} checkListttttttttttttttttttttt');
    for (var scheduleUpdate in boolContent.entries) {
      bool done = scheduleUpdate.value;
      String doneTopic = scheduleUpdate.key;
      print("done ${done}");
      print("doneTopic ${doneTopic}");
      print("horizondal list ${horizondal}");
      if (done && !horizondal.contains(doneTopic)) {
        print(done);
        print("checking the process of schedule");
        print(doneTopic);
        _firestore
            .collection('course')
            .doc(widget.trinerID)
            .collection("schedule")
            .doc(doneTopic)
            .set({
          'date': timing,
          'duration': int.parse(_duration.text),
          'description': _disctription.text,
          'zoom_link': _zoomLink.text,
          'zoom_password': _zoopPassword.text,
          'vedio_link':
              'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/live%20video%2Fvideo%20soon-01.png?alt=media&token=e17dc78d-fe7d-4728-961a-314f9bdfc4b5'
        });
      }
      // else {
      //   // _firestore
      //   //     .collection('course')
      //   //     .doc(widget.trinerID)
      //   //     .collection("schedule")
      //   //     .doc(doneTopic)
      //   //     .update({'time': null});
      //   //   // _firestore
      //   //   //     .collection('course')
      //   //   //     .doc(widget.trinerID)
      //   //   //     .collection("schedule")
      //   //   //     .doc(doneTopic)
      //   //   //     .delete();
      // }
    }
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Container(
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.white,
            content: Container(
              height: 550,
              width: 450,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScheduleAlertTextField(
                    hintText: 'Select Date',
                    icon: Icon(FontAwesomeIcons.calendarAlt),
                    controller: _dateController,
                    readOnly: true,
                    onPressed: () async {
                      _selectDate(context);
                    },
                  ),
                  ScheduleAlertTextField(
                    hintText: "duration",
                    icon: Icon(Icons.timer),
                    controller: _duration,
                  ),
                  ScheduleAlertTextField(
                    hintText: "Description",
                    icon: Icon(Icons.notes_sharp),
                    controller: _disctription,
                  ),
                  ScheduleAlertTextField(
                    hintText: "Zoom Link",
                    icon: Icon(FontAwesomeIcons.video),
                    controller: _zoomLink,
                  ),
                  ScheduleAlertTextField(
                    hintText: "Zoom Password",
                    icon: Icon(Icons.vpn_key),
                    controller: _zoopPassword,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: FlatButton(
                          height: 60,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.blue,
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 23),
                          ),
                          onPressed: () {
                            _saveSchedule();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: FlatButton(
                          height: 60,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Color(0xffFC5656),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 23),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // var selectedTime;
  // Future<Null> _selectTime(BuildContext context) async {
  //   final TimeOfDay picked = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );
  //   MaterialLocalizations localizations = MaterialLocalizations.of(context);
  //   String formattedTime =
  //       localizations.formatTimeOfDay(picked, alwaysUse24HourFormat: false);
  //   if (formattedTime != null) {
  //     selectedTime = formattedTime;
  //   }
  // }

  Future<DateTime> _selectDateTime(BuildContext context) async {
    await showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(seconds: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1));
    _selectTime(context);
  }
}

class ScheduleAlertTextField extends StatelessWidget {
  ScheduleAlertTextField(
      {this.hintText,
      this.icon,
      this.onPressed,
      this.controller,
      this.readOnly = false});
  String hintText;
  Function onPressed;
  Icon icon;
  bool readOnly;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey[400],
            ),
            borderRadius: BorderRadius.circular(10)),
        child: TextField(
          controller: controller,
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(borderSide: BorderSide.none),
            suffixIcon: IconButton(
              icon: icon,
              color: Colors.grey[400],
              onPressed: onPressed,
            ),
          ),
        ));
  }
}

class TopicWidget extends StatefulWidget {
  static String id;
  Map content;
  List dateAndTime;
  String trainer;

  TopicWidget({
    this.content,
    this.dateAndTime,
    this.trainer,
  });
  @override
  _TopicWidgetState createState() => _TopicWidgetState();
}

class _TopicWidgetState extends State<TopicWidget> {
  @override
  Widget build(BuildContext context) {
    print(widget.content);
    List topics = widget.content.keys.toList();
    List isScheduled = widget.content.values.toList();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: topics.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRow(
                section: topics[index],
                isIcon: isScheduled[index],
                dateAndTime: widget.dateAndTime[index],
                trainer: widget.trainer),
          ],
        );
      },
    );
    // return Text("welcome");
  }

  void syllabusId(String trainer, String section) async {
    await for (var snapshot in _firestore
        .collection('course')
        .doc(trainer)
        .collection("syllabus")
        .where("section", isEqualTo: section)
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        TopicWidget.id = message.id;
        print(TopicWidget.id);
        print(trainer);
        print(section);
      }
    }
  }

  Container buildRow({section, isIcon, dateAndTime, trainer}) {
    return Container(
      width: 600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              IconButton(
                  splashRadius: 20,
                  iconSize: 35,
                  color: Colors.blue,
                  icon: Icon(
                    isIcon != true
                        ? FontAwesomeIcons.circle
                        : FontAwesomeIcons.checkCircle,
                  ),
                  onPressed: () {
                    syllabusId(trainer, section);
                    setState(() {
                      widget.content[section] = !isIcon;
                      print("${isIcon}isIcon");
                      print(
                          "${widget.content[section]}widget.content[section]");
                    });
                  }),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                width: 500,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 2.0,
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  '${section}',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.blue,
                      fontSize: 22.0),
                ),
              ),
              IconButton(
                  tooltip: "Reschedule",
                  icon: Icon(
                    FontAwesomeIcons.times,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    syllabusId(trainer, section);
                    // _firestore
                    //     .collection('course')
                    //     .doc(trainer)
                    //     .collection("syllabus")
                    //     .doc(section)
                    //     .update({'flag': false});
                  }),
            ],
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: isIcon
                  ? dateAndTime != null
                      ? Text('${dateAndTime}')
                      : Text('Schedule time')
                  : Text(''))
        ],
      ),
    );
  }
}
