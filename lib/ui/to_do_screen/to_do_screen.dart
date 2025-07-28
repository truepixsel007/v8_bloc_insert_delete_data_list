import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v8_bloc_insert_delete_data_list/bloc/todo/to_do_bloc.dart';
import 'package:v8_bloc_insert_delete_data_list/bloc/todo/to_do_event.dart';
import 'package:v8_bloc_insert_delete_data_list/bloc/todo/to_do_state.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  void _showAddTaskDialog() {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Add New Task'),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(hintText: 'Enter task name'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // Cancel
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final task = controller.text.trim();
                  if (task.isNotEmpty) {
                    context.read<ToDoBloc>().add(AddTodoEvent(task: task));
                  }
                  Navigator.pop(context);
                },
                child: Text('Add'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo App')),
      body: BlocBuilder<ToDoBloc, ToDoState>(
        builder: (context, state) {
          if (state.todosList.isEmpty) {
            return Center(child: Text('No todo found'));
          } else if (state.todosList.isNotEmpty) {
            return ListView.builder(
              itemCount: state.todosList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.todosList[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<ToDoBloc>().add(
                            RemoveToDoEvent(task: state.todosList[index]),
                          );
                        },
                        icon: Icon(Icons.delete),
                      ),
                      IconButton(
                        onPressed: _showAddTaskDialog,
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          for (int i = 0; i < 3; i++) {
            context.read<ToDoBloc>().add(
              AddTodoEvent(task: 'Task:' + i.toString()),
            );
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
