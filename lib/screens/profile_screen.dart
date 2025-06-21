import 'package:flutter/material.dart';
import '../helpers/jwt_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userId;

  @override
  void initState() {
    super.initState();
    getUserIdFromToken().then((id) {
      setState(() => userId = id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Center(
        child: userId == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.account_circle, size: 100),
                  const SizedBox(height: 16),
                  Text("User ID:", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(userId!),
                ],
              ),
      ),
    );
  }
}
