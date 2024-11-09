import 'package:flutter/material.dart';
import 'package:testone/taskdetaildialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<String, List<Task>> tasks = {
    "Monday": <Task>[],
    "Tuesday": <Task>[],
    "Wednesday": <Task>[],
    "Thursday": <Task>[],
    "Friday": <Task>[],
    "Saturday": <Task>[],
    "Sunday": <Task>[]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Adjust as needed
            childAspectRatio: 1,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: tasks.keys.length,
          itemBuilder: (context, index) {
            String day = tasks.keys.elementAt(index);
            return GestureDetector(
              onTap: () => showDialog(
                context: context,
                builder: (context) => TaskDetailDialog(
                  day: day,
                  tasks: tasks[day]!,
                  onTaskAdded: (task) =>
                      setState(() => tasks[day]!.add(Task(task.name, false))),
                  onTaskRemoved: (task) =>
                      setState(() => tasks[day]!.remove(task)),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      day,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tasks[day]!.isNotEmpty
                          ? tasks[day]!
                                  .take(2)
                                  .map((task) => task.name)
                                  .join(", ") +
                              (tasks[day]!.length > 2 ? "..." : "")
                          : "No tasks",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
