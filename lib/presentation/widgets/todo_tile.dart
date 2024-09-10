import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/todo.dart';
import '../controllers/todo_controller.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;

  TodoTile({required this.todo});

  @override
  Widget build(BuildContext context) {
    final TodoController controller = Get.find();

    return ListTile(
      title: Text(todo.title),
      trailing: Checkbox(
        value: todo.completed,
        onChanged: (value) {},
      ),
      onLongPress: () {
        controller.deleteTodo(todo.id);
      },
    );
  }
}
