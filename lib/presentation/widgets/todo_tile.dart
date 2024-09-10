import 'package:flutter/material.dart';
import 'package:flutter_todolist/presentation/controllers/todo_controller.dart';
import 'package:get/get.dart';

import '../../domain/entities/todo.dart';

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
        onChanged: (value) {
         
        },
      ),
      onLongPress: () {},
    );
  }
}
