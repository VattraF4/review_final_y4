import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// HTTP Methods / វិធីសាស្ត្រ HTTP:
// GET    /posts        → Read list
// POST   /posts        → Create new
// PUT    /posts/{id}   → Update existing
// DELETE /posts/{id}   → Delete

class ApiService {
  final _base = Uri.parse('https://jsonplaceholder.typicode.com/posts');

  // ✅ READ — GET
  Future<List<Map<String, dynamic>>> fetchPosts() async {
    final resp = await http.get(_base).timeout(const Duration(seconds: 8));
    if (resp.statusCode != 200) throw Exception('Server error');
    final List data = jsonDecode(resp.body);
    return data.cast<Map<String, dynamic>>();
  }

  // ✅ CREATE — POST
  Future<void> createPost(String title) async {
    await http.post(
      _base,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title, 'body': 'body', 'userId': 1}),
    );
  }

  // ✅ UPDATE — PUT
  Future<void> updatePost(int id, String title) async {
    await http.put(
      Uri.parse('${_base.toString()}/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title, 'body': 'body', 'userId': 1}),
    );
  }

  // ✅ DELETE — DELETE
  Future<void> deletePost(int id) async {
    await http.delete(Uri.parse('${_base.toString()}/$id'));
  }
}


void main(){
  runApp(PostsPage());
}
// UI (simplified)
class PostsPage extends StatefulWidget {
  const PostsPage({super.key});
  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final _svc = ApiService();
  late Future<List<Map<String, dynamic>>> _future;

  @override
  void initState() {
    super.initState();
    _future = _svc.fetchPosts(); // ✅ Store future in initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _future,
        builder: (_, snap) {
          if (snap.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());
          if (snap.hasError) return Center(child: Text('Error: ${snap.error}'));
          final list = snap.data ?? [];
          if (list.isEmpty) return const Center(child: Text('No posts'));
          return ListView.separated(
            itemCount: list.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, i) => ListTile(
              title: Text(list[i]['title'] ?? ''),
              subtitle: Text('ID: ${list[i]['id']}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  await _svc.deletePost(list[i]['id']);
                  setState(() => _future = _svc.fetchPosts());
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
