// Create custom widget

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(home: const ProfilePage());
}

// ✅ Use ProfileStat 3 times
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // use for centering content vertically
          children: [
            const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
            const SizedBox(height: 12),
            const Text(
              'Alex Johnson',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Mobile Developer',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 16),
            // ✅ Used 3 times
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileStat(label: 'Posts', value: '120'),
                SizedBox(width: 16),
                ProfileStat(label: 'Followers', value: '2.1K'),
                SizedBox(width: 16),
                ProfileStat(label: 'Following', value: '180'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//Custom Reusable Widget — ProfileStat
class ProfileStat extends StatelessWidget {
  final String label;
  final String value;

  const ProfileStat({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      Text(label, style: const TextStyle(color: Colors.black54)),
    ],
  );
}
