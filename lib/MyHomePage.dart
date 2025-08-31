import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week6_dev/taskProvider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6D5BFF), Color(0xFF43CEA2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Input box
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 8,
                  color: Colors.white.withOpacity(0.90),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller,
                            decoration: const InputDecoration(
                              labelText: 'Add a task',
                              labelStyle: TextStyle(color: Color(0xFF6D5BFF)),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: IconButton(
                            key: ValueKey(controller.text),
                            icon: const Icon(Icons.add_circle,
                                color: Color(0xFF43CEA2), size: 32),
                            onPressed: () {
                              taskProvider.addTask(controller.text);
                              controller.clear();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Task List
              Expanded(
                child: taskProvider.tasks.isEmpty
                    ? Center(
                        child: Text(
                          'No tasks yet!',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: taskProvider.tasks.length,
                        itemBuilder: (context, index) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: Card(
                              elevation: 4,
                              color: Colors.white.withOpacity(0.95),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: ListTile(
                                title: Text(
                                  taskProvider.tasks[index],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF185A9D)),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.orange),
                                      onPressed: () {
                                        final editController =
                                            TextEditingController(
                                                text:
                                                    taskProvider.tasks[index]);
                                        showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: const Text("Edit Task"),
                                            content: TextField(
                                              controller: editController,
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  taskProvider.updateTask(index,
                                                      editController.text);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Save"),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Color(0xFFB71C1C)),
                                      onPressed: () =>
                                          taskProvider.removeTask(index),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
