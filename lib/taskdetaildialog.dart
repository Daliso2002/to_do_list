import 'package:flutter/material.dart';

class Task {
  String name;
  bool isCompleted;

  Task(this.name, this.isCompleted);
}

class TaskDetailDialog extends StatelessWidget {
  final String day;
  final List<Task> tasks;
  final ValueChanged<Task> onTaskAdded;
  final ValueChanged<Task> onTaskRemoved;

  TaskDetailDialog({
    super.key,
    required this.day,
    required this.tasks,
    required this.onTaskAdded,
    required this.onTaskRemoved,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController taskController = TextEditingController();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: 400,
          maxWidth: 300,
        ), // Set max height and width
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$day Tasks',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: taskController,
              decoration: InputDecoration(hintText: 'New Task'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    if (taskController.text.isNotEmpty) {
                      onTaskAdded(Task(taskController.text, false));
                      taskController.clear();
                    }
                  },
                  child: Text('Add Task'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    title: Text(
                      task.name,
                      style: TextStyle(
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (bool? value) {
                        // Toggle task completion status
                        task.isCompleted = value ?? false;
                        (context as Element)
                            .markNeedsBuild(); // Rebuild the widget
                      },
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => onTaskRemoved(task),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
