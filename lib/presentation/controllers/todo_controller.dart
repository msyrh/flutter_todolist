import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/todo.dart';
import '../../domain/use_cases/add_todo.dart';
import '../../domain/use_cases/get_todos.dart';

class TodoController extends GetxController {
  final GetTodos getTodosUseCase;
  final AddTodo addTodoUseCase;

  TodoController({
    required this.getTodosUseCase,
    required this.addTodoUseCase,
  });

  var todos = <Todo>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTodos();
  }

  void fetchTodos() async {
    todos.value = await getTodosUseCase();
  }

  void addTodo(String title) async {
    final todo = Todo(
      id: DateTime.now().toString(),
      title: title,
    );
    await addTodoUseCase(todo);
    fetchTodos();
  }
}
