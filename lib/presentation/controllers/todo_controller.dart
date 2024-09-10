import 'dart:ffi';

import 'package:flutter_todolist/domain/use_cases/delete_todo.dart';
import 'package:get/get.dart';
import '../../domain/entities/todo.dart';
import '../../domain/use_cases/add_todo.dart';
import '../../domain/use_cases/get_todos.dart';
import '../../domain/use_cases/delete_todo.dart';
import '../../domain/use_cases/update_todo.dart';

class TodoController extends GetxController {
  final GetTodos getTodosUseCase;
  final AddTodo addTodoUseCase;
  final UpdateTodo updateTodoUseCase;
  final DeleteTodo deleteTodoUseCase;

  TodoController({
    required this.getTodosUseCase,
    required this.addTodoUseCase,
    required this.updateTodoUseCase,
    required this.deleteTodoUseCase,
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

  void updateTodo(Todo todo) async {
    await updateTodoUseCase(todo);
    fetchTodos();
  }

  void deleteTodo(String id) async {
    await deleteTodoUseCase(id);
    fetchTodos();
  }
}
