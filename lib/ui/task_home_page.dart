import 'package:flutter/material.dart';
import 'package:my_todo_app/DB/task_database.dart';
import 'package:my_todo_app/model/task_model.dart';

class TaskHomePage extends StatefulWidget {
  const TaskHomePage({super.key});

  @override
  State<TaskHomePage> createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
  List<TaskModel> tasks = [];
  TextEditingController taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    refreshTask();
  }

  Future<void> refreshTask() async {
    // Implementation for refreshing tasks
    tasks = await TaskDatabase.getTask();
    setState(() {});
  }

  Future<void> addTask() async {
    if (taskController.text.isNotEmpty) {
      await TaskDatabase.insertTask(
        TaskModel(title: taskController.text, isCompleted: false),
      );
      taskController.clear();
      refreshTask();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a task')));
    }
  }

  Future<void> deleteTask(int id) async {
    // Implementation for deleting a task
    await TaskDatabase.deleteTask(id);
    refreshTask();
  }

  Future<void> toggleTask(TaskModel task) async {
    await TaskDatabase.updateTask(
      TaskModel(id: task.id, title: task.title, isCompleted: !task.isCompleted),
    );
    refreshTask();
  }

  Future<void> editTask(TaskModel task) async {
    // Implementation for editing a task
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController editController = TextEditingController(
          text: task.title,
        );
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(hintText: 'Enter new task title'),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (editController.text.isNotEmpty) {
                  await TaskDatabase.updateTask(
                    TaskModel(
                      id: task.id,
                      title: editController.text,
                      isCompleted: task.isCompleted,
                    ),
                  );
                  Navigator.of(context).pop();
                  refreshTask();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

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
                    controller: taskController,
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
                  onPressed: () {
                    addTask();
                  },
                  icon: const Icon(Icons.add),
                  color: Colors.blue,
                ),
              ],
            ),

            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) => ListTile(
                  leading: Checkbox(
                    value: tasks[index].isCompleted,
                    onChanged: (value) {
                      toggleTask(tasks[index]);
                    },
                  ),
                  title: Text(tasks[index].title),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          editTask(tasks[index]);
                        },
                        icon: const Icon(Icons.edit),
                        color: Colors.green,
                      ),
                      IconButton(
                        onPressed: () {
                          deleteTask(tasks[index].id!);
                        },
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
