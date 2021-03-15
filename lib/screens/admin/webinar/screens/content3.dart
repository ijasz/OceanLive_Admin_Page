import 'package:flutter/material.dart';
import 'package:ocean_live/screens/admin/webinar/upload%20alert/Content3_UploadAlert.dart';
import '../webinar.dart';

/// < Content 3 > ///

class Content3 extends StatefulWidget {
  @override
  _Content3State createState() => _Content3State();
}

class _Content3State extends State<Content3> {
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
                  displayDialog(name: Content3UploadAlert(), context: context);
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
              RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color(0xff0090E9),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_outlined,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 5),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 17,
                          color: Color(0xff0090E9),
                        ),
                      ),
                    ),
                  ],
                ),
                textColor: Colors.white,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 50),
          // StreamBuilder<QuerySnapshot>(
          //   stream: _firestore.collection('Webinar').snapshots(),
          //   // ignore: missing_return
          //   builder: (context, snapshot) {
          //     if (!snapshot.hasData) {
          //       return Text("Loading.....");
          //     } else {
          //       final messages = snapshot.data.docs;
          //       List<Dbcontent3> upcoming = [];
          //       for (var message in messages) {
          //         final dbmessageImage = message.data()['aboutmentorimage'];
          //         final dbmentorDescription =
          //             message.data()['mentorDescription'];
          //         if (dbmessageImage != null && dbmentorDescription != null) {
          //           final content1 = Dbcontent3(
          //             mentorImage: dbmessageImage,
          //             mentorDescription: dbmentorDescription,
          //           );
          //           upcoming.add(content1);
          //         }
          //         return Column(
          //           children: upcoming,
          //         );
          //       }
          //     }
          //   },
          // ),
          // SizedBox(height: 100),
        ],
      ),
    );
  }
}
