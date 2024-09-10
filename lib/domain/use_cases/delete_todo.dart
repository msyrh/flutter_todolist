import 'package:flutter_todolist/domain/repositories/todo_repository.dart';

class DeleteTodo {
  final TodoRepository repository;

  DeleteTodo(this.repository);

  Future<void> call(String id) async {
    return repository.deleteTodo(id);
  }
}
