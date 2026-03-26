import 'package:flutter/material.dart';

void main() {
  runApp(const Question2());
}

class Question2 extends StatelessWidget {
  const Question2({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Profile',
      home: const Profile(),
    );
  }
}

class Profile extends StatelessWidget{
  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Student Profile")),

        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // AssetImage("images/profile.jpg"),
                Image(
                  image: AssetImage("images/profile.png"),
                  width: 100,
                  height: 100,
                ),
                Text("Asset Image"),
                //NetworkImage
                Image(
                  image: NetworkImage(
                    "https://cdn-icons-png.flaticon.com/512/3135/3135823.png",
                  ),
                  width: 100,
                  height: 100,
                ),
                Text("Network Image"),
                Text("Name: Ra Vattra"),
                Text("ID: 000045637"),
              ],
            ),
          ),
        ),
      );
  }
}
