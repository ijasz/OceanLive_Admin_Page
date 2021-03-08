import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocean_live/screens/admin/webinar/screens/content1.dart';
import 'package:ocean_live/screens/admin/webinar/upload%20alert/Content1_UploadAlert.dart';

/// < Content 2 Upload Alert > ///

final _firestore = FirebaseFirestore.instance;

class Content2UploadAlert extends StatefulWidget {
  @override
  _Content2UploadAlertState createState() => _Content2UploadAlertState();
}

class _Content2UploadAlertState extends State<Content2UploadAlert> {
  String title;
  String subtitle;

  final titleController = TextEditingController();
  final subtitleController = TextEditingController();

  Widget _heading1() {
    return TextFormField(
      maxLines: null,
      minLines: 10,
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
      controller: titleController,
      onChanged: (value) {
        title = value;
      },
    );
  }

  Widget _heading2() {
    return TextFormField(
      maxLines: null,
      minLines: 10,
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
      controller: subtitleController,
      onChanged: (value) {
        subtitle = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      width: 460,
      color: Colors.white,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                color: Colors.blue,
                height: 100,
                width: 500,
                child: Center(
                  child: Text(
                    'Content 1',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.title_outlined,
                    color: Colors.blue,
                  ),
                  Container(
                    height: 120,
                    width: 330,
                    child: _heading1(),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.subtitles_outlined,
                    color: Colors.blue,
                  ),
                  Container(
                    height: 120,
                    width: 330,
                    child: _heading2(),
                  ),
                ],
              ),
              SizedBox(height: 25),
              RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  _firestore
                      .collection(Content1.paymentController == null ||
                              Content1.paymentController.text.isEmpty
                          ? 'free_webinar'
                          : 'paid_webinar')
                      .doc(Content1UploadAlert.courseController.text)
                      .update({
                    'topic title': FieldValue.arrayUnion([title]),
                    'topic subtitle': FieldValue.arrayUnion([subtitle]),
                    'course': Content1UploadAlert.courseController.text,
                    'payment': Content1.paymentController.text.isEmpty
                        ? 'free'
                        : Content1.paymentController.text,
                  });
                  titleController.clear();
                  subtitleController.clear();
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
          Positioned(
            width: 35,
            top: 30,
            right: 13,
            child: RaisedButton(
              elevation: 0,
              hoverColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              padding: EdgeInsets.zero,
              color: Colors.blue,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.cancel_outlined,
                color: Colors.black,
                size: 35,
              ),
            ),
          )
        ],
      ),
    );
  }
}
