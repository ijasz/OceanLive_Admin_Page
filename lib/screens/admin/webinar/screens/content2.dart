import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_live/screens/admin/webinar/edit_alert/ContentEdit.dart';
import 'package:ocean_live/screens/admin/webinar/screens/content1.dart';
import 'package:ocean_live/screens/admin/webinar/upload%20alert/Content1_UploadAlert.dart';
import 'package:ocean_live/screens/admin/webinar/upload%20alert/Content2_UploadAlert.dart';
import 'package:universal_html/html.dart';
import '../../course.dart';
import '../webinar.dart';
import 'package:path/path.dart';

/// < Content 2 > ///

final _firestore = FirebaseFirestore.instance;

class Content2 extends StatefulWidget {
  @override
  _Content2State createState() => _Content2State();
}

class _Content2State extends State<Content2> {
  Uint8List uploadfile;
  bool isComplete = false, isOnline = false, isOffline = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {
                  displayDialog(name: Content2UploadAlert(), context: context);
                },
                color: Colors.blue,
                child: Row(
                  children: [
                    Icon(
                      Icons.download_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Upload',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 20),
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
                            style: TextStyle(fontSize: 15, color: Colors.white),
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
                        Reference firebaseStorageRef = FirebaseStorage.instance
                            .ref()
                            .child("Webinar")
                            .child(ContentEdit.filename);
                        UploadTask uploadTask =
                            firebaseStorageRef.putData(uploadfile);
                        TaskSnapshot taskSnapshot =
                            await uploadTask.whenComplete(() {
                          setState(() {
                            print("Video uploaded");
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Please wait for few seconds')));
                            uploadTask.snapshot.ref
                                .getDownloadURL()
                                .then((value) {
                              setState(() {
                                ContentEdit.getLink = value;
                              });

                              print(ContentEdit.getLink);
                              _firestore
                                  .collection('Webinar')
                                  .doc(
                                      Content1UploadAlert.courseController.text)
                                  .update(
                                      {"webinar video": ContentEdit.getLink});
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Video Uploaded')));
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
            ],
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
