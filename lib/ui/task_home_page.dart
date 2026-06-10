import 'package:flutter/material.dart';

class TaskHomePage extends StatelessWidget {
  const TaskHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, titleSpacing: 20, title: const Text('Todo')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your task',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),

                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  color: Colors.blue,
                ),
              ],
            ),

            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => ListTile(
                  leading: Checkbox(value: false, onChanged: (_) {}),
                  title: Text('Task ${index + 1}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                        color: Colors.green,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
