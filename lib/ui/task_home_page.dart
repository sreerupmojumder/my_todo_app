import 'package:flutter/material.dart';

class TaskHomePage extends StatelessWidget {
  const TaskHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Home Page'),
      ),
      body: const Center(
        child: Text('Welcome to the Task Home Page!'),
      ),
    );
  }
}