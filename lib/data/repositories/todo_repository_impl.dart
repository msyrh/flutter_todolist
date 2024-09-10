import 'package:flutter_todolist/data/data_sources/todo_local_data_source.dart';
import '../../domain/repositories/todo_repository.dart';
import 'package:flutter_todolist/data/models/todo_model.dart';
import 'package:flutter_todolist/domain/entities/todo.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl(this.localDataSource);

  @override
  Future<List<Todo>> getTodos() async {
    final todoModels = await localDataSource.getTodos();
    return todoModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addTodo(Todo todo) async {
    final todoModel = TodoModel.fromEntity(todo);
    await localDataSource.addTodo(todoModel);
  }
}
