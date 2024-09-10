import 'package:flutter/material.dart';
import 'package:flutter_todolist/presentation/controllers/todo_controller.dart';
import 'package:get/get.dart';

import '../widgets/todo_tile.dart';

class TodoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoController controller = Get.put(
      TodoController(getTodosUseCase: Get.find(), addTodoUseCase: Get.find()),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.todos.length,
          itemBuilder: (context, index) {
            final todo = controller.todos[index];
            return TodoTile(todo: todo);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement adding a new todo
          Get.defaultDialog(
            title: 'Add Todo',
            content: TextField(
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  controller.addTodo(value);
                  Get.back();
                }
              },
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
