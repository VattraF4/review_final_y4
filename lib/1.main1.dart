import 'package:flutter/material.dart';
// import 'package:review_final_y4/main.dart';

void main() {
  runApp(const Question1());
}

class Question1 extends StatelessWidget {
  const Question1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Question 1',
      home: Scaffold(
        body: Center(
          child: Text("Hello World"),
        ),
      ),
    );
  }
}
