import 'package:flutter/material.dart';
import 'package:ocean_live/login.dart';
import 'package:ocean_live/models/routing.dart';
import 'package:ocean_live/screens/admin/home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(OceanLive());
}

class OceanLive extends StatefulWidget {
  static String username;
  @override
  _OceanLiveState createState() => _OceanLiveState();
}

class _OceanLiveState extends State<OceanLive> {
  SharedPreferences logindata;
  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      OceanLive.username = logindata.getString('username');
      OceanLive.username != null ? Admin() : LoginPage();
      print("session${OceanLive.username}");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Routing(),
      child: MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.grey[100],
            body: OceanLive.username != null ? Admin() : LoginPage()),
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(primaryColor: Colors.white),
      ),
    );
  }
}
