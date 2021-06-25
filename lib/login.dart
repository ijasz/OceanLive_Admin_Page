import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocean_live/models/routing.dart';
import 'package:ocean_live/screens/admin/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static String phoneNumber;
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  _LoginPageState createState() => _LoginPageState();
}

final _firestore = FirebaseFirestore.instance;

class _LoginPageState extends State<LoginPage> {
  final phoneNumberController = TextEditingController();
  List adminList = [];

  void adminNumber() async {
    var admin = await _firestore.collection('admin').get();
    for (var i in admin.docs) {
      adminList.add(i.data()['number']);
    }
    print(adminList);
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context)
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adminNumber();
  }

  session() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', LoginPage.phoneNumber);
    print("${LoginPage.phoneNumber} ssssssssssssss");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // padding: EdgeInsets.all(50),
              width: 400,
              height: 300,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    child: Text(
                      "Admin Login",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(height: 30),
                  Form(
                    key: LoginPage._formKey,
                    child: Container(
                        width: 300,
                        height: 75,
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'phone_number is required';
                            } else if (value.length < 10) {
                              return 'invalid phone_number';
                            }
                            return null;
                          },
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                              RegExp(r"^\d+\.?\d{0,2}"),
                            ),
                            LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: InputDecoration(
                            hintText: "Enter Your Number",
                            hintStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          controller: phoneNumberController,
                          onChanged: (value) {
                            LoginPage.phoneNumber = value;
                          },
                        )),
                  ),
                  SizedBox(height: 25),
                  FlatButton(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w200),
                      ),
                      hoverColor: Colors.lightBlue[800],
                      height: 50,
                      minWidth: 250,
                      color: Colors.lightBlue[400],
                      onPressed: () {
                        if (LoginPage._formKey.currentState.validate()) {
                          if (LoginPage.phoneNumber != null &&
                              adminList.contains(LoginPage.phoneNumber)) {
                            session();
                            print("Login Successfully");
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Admin()),
                            );
                          } else {
                            showInSnackBar("U are not valid admin page user");
                          }
                        }
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
