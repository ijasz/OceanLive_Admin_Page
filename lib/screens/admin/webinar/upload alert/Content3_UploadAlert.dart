import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocean_live/screens/admin/webinar/screens/content1.dart';
import 'package:ocean_live/screens/admin/webinar/upload%20alert/Content1_UploadAlert.dart';

/// < Content 3 Upload Alert > ///

final _firestore = FirebaseFirestore.instance;

class Content3UploadAlert extends StatefulWidget {
  @override
  _Content3UploadAlertState createState() => _Content3UploadAlertState();
}

class _Content3UploadAlertState extends State<Content3UploadAlert> {
  String aboutMentor;
  String designation;
  var mentorImage;
  String filename;
  Uint8List uploadfile;
  TextEditingController aboutMentorController = TextEditingController();
  TextEditingController designationController = TextEditingController();

  Widget _buildAboutMentor() {
    return TextFormField(
      maxLines: null,
      minLines: 2,
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
        labelText: 'Mentor Description',
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
      ),
      onChanged: (value) {
        aboutMentor = value;
      },
    );
  }

  Widget _designation() {
    return TextFormField(
      maxLines: null,
      minLines: 2,
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
      onChanged: (value) {
        designation = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 520,
      width: 450,
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
                    'Content 3',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "About Mentor",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 40, left: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 38,
                      width: 100,
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
                            SizedBox(width: 3),
                            Padding(
                              padding: EdgeInsets.all(1),
                              child: Text(
                                'Upload Image',
                                style: TextStyle(
                                  fontSize: 10,
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
                            UploadTask uploadTask =
                                firebaseStorageRef.putData(uploadfile);
                            TaskSnapshot taskSnapshot =
                                await uploadTask.whenComplete(() {
                              setState(() {
                                print("Profile Picture uploaded");
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Staff Picture Uploaded')));
                                uploadTask.snapshot.ref
                                    .getDownloadURL()
                                    .then((value) {
                                  setState(() {
                                    mentorImage = value;
                                  });
                                  print({mentorImage});
                                });
                              });
                            });
                          }

                          print('$mentorImage');
                          uploadPic(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                height: 80,
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: _buildAboutMentor(),
              ),
              SizedBox(height: 30),
              Container(
                height: 80,
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: _designation(),
              ),
              SizedBox(height: 25),
              RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  _firestore
                      .collection("Webinar")
                      .doc(Content1UploadAlert.courseController.text)
                      .update({
                    'mentor image': mentorImage,
                    'about mentor': aboutMentor,
                    'course': Content1UploadAlert.courseController.text,
                    'payment': Content1.paymentController.text.isEmpty
                        ? 'free'
                        : Content1.paymentController.text,
                    'designation': designation
                  });
                  aboutMentorController.clear();
                  Content1.paymentController.clear();
                  Content1UploadAlert.courseController.clear();
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
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
            left: 15,
            top: 60,
            child: CircleAvatar(
              backgroundImage: NetworkImage("$mentorImage"),
              backgroundColor: Colors.grey[200],
              maxRadius: 45,
            ),
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
