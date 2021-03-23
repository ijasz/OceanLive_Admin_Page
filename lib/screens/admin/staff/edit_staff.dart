import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:ocean_live/screens/admin/notification/send_notification.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ocean_live/screens/admin/Details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _firestore = FirebaseFirestore.instance;

class EditStaffDetails extends StatefulWidget {
  EditStaffDetails(
      {this.trainername,
      this.email,
      this.address,
      this.dateofbirth,
      this.dateofjoining,
      this.mobilenumber,
      this.qualification,
      this.trainerImage});
  String trainername;
  String address;
  String mobilenumber;
  String email;
  String qualification;
  String dateofbirth;
  String dateofjoining;
  String trainerImage;
  @override
  _EditStaffDetailsState createState() => _EditStaffDetailsState();
}

class _EditStaffDetailsState extends State<EditStaffDetails> {
  String editStaff;

  void editstaff() async {
    await for (var snapshot in _firestore
        .collection('staff')
        .where("email", isEqualTo: widget.email)
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        //print(message.documentID);
        editStaff = message.documentID;
        print("${editStaff}latha");
      }
    }
  }

  TextEditingController name;

  TextEditingController mobile;
  TextEditingController email;
  TextEditingController qual;
  TextEditingController dob;
  TextEditingController doj;
  TextEditingController addr;

  bool isName = false, isMobile = false, isEmail = false;
  var id = 0;
  var staffLink;
  String filename;
  Uint8List uploadfile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mobile = TextEditingController(text: widget.mobilenumber);
    name = TextEditingController(text: widget.trainername);
    doj = TextEditingController(text: widget.dateofjoining);
    dob = TextEditingController(text: widget.dateofbirth);
    addr = TextEditingController(text: widget.address);
    email = TextEditingController(text: widget.email);
    qual = TextEditingController(text: widget.qualification);
    editstaff();

    print("${widget.trainerImage}tttttttttttttt");
    //specificArea();
  }

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
                        "${widget.trainerImage}",
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
                              uploadPic(context);
                            });
                            print(filename);
                          } else {
                            print('pick imafe');
                          }
                          ///////
                          setState(() {
                            uploadPic(context);
                          });

                          // setState(() {
                          //   isComplete = true;
                          // });
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
                    print("${staffLink},sssssssssssssssss");
                    print("${widget.trainerImage}mmmmmmmmmmmmmmmmm");
                    setState(() {
                      print("checking staff");
                      _firestore.collection("staff").doc(editStaff).set({
                        "trainername": name.text,
                        "address": addr.text,
                        "mobileNumber": mobile.text,
                        "email": email.text,
                        "qualification": qual.text,
                        "dateofbirth": dob.text,
                        "dateofjoin": doj.text,
                        "trainerimage": widget.trainerImage
                      });
                      print("__________________");
                      print("address,${addr.text}");
                    });
                    //editstaff();
                    print("${editStaff}lathaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");

                    // setState(() {
                    //   isName = name.text.isEmpty;
                    //   isMobile = mobile.text.isEmpty;
                    //   isEmail = email.text.isEmpty;
                    // });
                    Navigator.pop(context);
                  }),
            ],
          ),
        ],
      ),
    );
  }

  Future uploadPic(BuildContext context) async {
    // String fileName = basename(_image.path);

    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("Staff").child(filename);
    UploadTask uploadTask = firebaseStorageRef.putData(uploadfile);
    TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() => setState(() {
              print("Profile Picture uploaded");
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Staff Picture Uploaded')));
              uploadTask.snapshot.ref.getDownloadURL().then((value) {
                setState(() {
                  staffLink = value;
                });
                setState(() {
                  widget.trainerImage = staffLink;
                });
                //print(getCourseLink);
              });
            }));
  }
}

Text _heading({text}) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 18, color: Color(0xFF555454), fontWeight: FontWeight.w600),
  );
}
