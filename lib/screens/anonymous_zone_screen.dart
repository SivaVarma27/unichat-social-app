import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AnonymousZoneScreen extends StatefulWidget {
  const AnonymousZoneScreen({super.key});

  @override
  State<AnonymousZoneScreen> createState() => _AnonymousZoneScreenState();
}

class _AnonymousZoneScreenState extends State<AnonymousZoneScreen> {
  final postCtrl = TextEditingController();
  List<dynamic> posts = [];
  bool isLoading = true;

  Future<void> fetchAnonPosts() async {
    final res = await http.get(Uri.parse("http://<your_backend_url>/api/anon/posts"));
    if (res.statusCode == 200) {
      setState(() {
        posts = jsonDecode(res.body);
        isLoading = false;
      });
    }
  }

  Future<void> createAnonPost() async {
    if (postCtrl.text.trim().isEmpty) return;

    final res = await http.post(
      Uri.parse("http://<your_backend_url>/api/anon/create"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "content": postCtrl.text.trim()
      }),
    );

    if (res.statusCode == 201) {
      postCtrl.clear();
      fetchAnonPosts(); // refresh
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAnonPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Anonymous Zone")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                TextField(
                  controller: postCtrl,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: "Share anonymously...",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: createAnonPost,
                  child: const Text("Post"),
                ),
              ],
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Text("Anonymous Feed", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: fetchAnonPosts,
                    child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (_, i) {
                        final post = posts[i];
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(post['content']),
                          ),
                        );
                      },
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
