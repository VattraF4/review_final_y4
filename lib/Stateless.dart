import 'package:flutter/material.dart';

// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Scaffold(body: Center(child: Text("Hello World"))),
//     );
//   }
// }
void main() {
  runApp(
    MaterialApp(
      title: 'Stateless Widget',
      home: Scaffold(
        appBar: AppBar(title: Text("Stateless Widget")),
        body: Center(child: Text("Hello World")),
      ),
    ),
  );
}
