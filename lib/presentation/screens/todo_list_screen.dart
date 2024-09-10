import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';
import '../widgets/todo_tile.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TodoController controller = Get.put(
      TodoController(
        getTodosUseCase: Get.find(),
        addTodoUseCase: Get.find(),
        deleteTodoUseCase: Get.find(),
      ),
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
