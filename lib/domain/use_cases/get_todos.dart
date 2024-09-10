import 'package:flutter_todolist/domain/repositories/todo_repository.dart';
import 'package:flutter_todolist/domain/entities/todo.dart';

class GetTodos {
  final TodoRepository repository;

  GetTodos(this.repository);

  Future<List<Todo>> call() async {
    return repository.getTodos();
  }
}
