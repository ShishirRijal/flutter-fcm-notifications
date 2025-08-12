import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to the Home Page!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.blueAccent, // Custom color for the button
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, '/friendRequests'),
                  child: const Text('Friend Requests'),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.green, // Custom color for the button
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => Navigator.pushNamed(
                    context,
                    '/chat',
                    arguments: {'chatId': 'demo123'},
                  ),
                  child: const Text('Chat'),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Custom color for the button
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => Navigator.pushNamed(
                    context,
                    '/profile',
                    arguments: {'userId': 'user456'},
                  ),
                  child: const Text('Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
