import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_live/screens/admin/Details.dart';
import 'package:ocean_live/screens/admin/notification/send_notification.dart';
final _firestore = FirebaseFirestore.instance;

class UpdateStaffDetails extends StatefulWidget {
  @override
  _UpdateStaffDetailsState createState() => _UpdateStaffDetailsState();
}

class _UpdateStaffDetailsState extends State<UpdateStaffDetails> {
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController qual = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController doj = TextEditingController();
  TextEditingController addr = TextEditingController();

  bool isName = false, isMobile = false, isEmail = false;
  var id = 0;
  var staffLink;
  String filename;
  Uint8List uploadfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Edit Staff Details",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 50,
                ),
                closeIcon(context),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Expanded(
                child: _heading(text: "Name"),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: _heading(text: "Mobile Number"),
              ),
              SizedBox(
                width: 50,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: name,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[A-Za-z ]{1,32}"))
                      ],
                      decoration: customDecor(),
                    ),
                    toggleError(isName),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      maxLength: 10,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]{1,10}'))
                      ],
                      controller: mobile,
                      decoration: customDecor(),
                    ),
                    toggleError(isMobile)
                  ],
                ),
              ),
              SizedBox(
                width: 50,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Expanded(
                child: _heading(text: "Email Id"),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: _heading(text: "Qualification"),
              ),
              SizedBox(
                width: 50,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: email,
                      decoration: customDecor(),
                    ),
                    toggleError(isEmail)
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextField(
                  controller: qual,
                  decoration: customDecor(),
                ),
              ),
              SizedBox(
                width: 50,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Expanded(
                child: _heading(text: "DOB"),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: _heading(text: "DOJ"),
              ),
              SizedBox(
                width: 50,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Expanded(
                child: TextField(
                  controller: dob,
                  decoration: customIconDecor(
                      icon: Icon(FontAwesomeIcons.calendarAlt),
                      context: context),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  child: TextField(
                    controller: doj,
                    decoration: customIconDecor(
                        icon: Icon(FontAwesomeIcons.calendarAlt),
                        context: context),
                  ),
                ),
              ),
              SizedBox(
                width: 50,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Expanded(
                flex: 2,
                child: _heading(text: "Address"),
              ),
              SizedBox(
                width: 50,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    child: TextField(
                      controller: addr,
                      decoration: customDecor(),
                    ),
                  )),
              SizedBox(
                width: 50,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        "${staffLink}",
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: GestureDetector(
                        child: UploadImage(
                          size: 12,
                        ),
                        onTap: () async {
                          FilePickerResult result =
                          await FilePicker.platform.pickFiles();
                          if (result != null) {
                            uploadfile = result.files.single.bytes;
                            setState(() {
                              filename = basename(result.files.single.name);
                            });
                            print(filename);
                          } else {
                            print('pick imafe');
                          }
                          ///////
                          Future uploadPic(BuildContext context) async {
                            Reference firebaseStorageRef = FirebaseStorage
                                .instance
                                .ref()
                                .child("Staff")
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
                                    staffLink = value;
                                  });

                                  print(staffLink);
                                });
                              });
                            });
                          }

                          uploadPic(context);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                flex: 1,
              ),
              Expanded(
                  child: Visibility(
                    child: Text("welcome"),
                    visible: false,
                  ),
                  flex: 2),
              SizedBox(
                width: 50,
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              dynamicSizeButton(
                  text: "Save Details",
                  onPress: () {
                    setState(() {});
                    _firestore.collection("staff").add({
                      "trainername": name.text,
                      "address": addr.text,
                      "mobileNumber": mobile.text,
                      "email": email.text,
                      "qualification": qual.text,
                      "dateofbirth": dob.text,
                      "dateofjoin": doj.text,
                      "trainerimage": staffLink,
                    });
                    setState(() {
                      isName = name.text.isEmpty;
                      isMobile = mobile.text.isEmpty;
                      isEmail = email.text.isEmpty;
                    });
                    Navigator.pop(context);
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
Text _heading({text}) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 18, color: Color(0xFF555454), fontWeight: FontWeight.w600),
  );
}