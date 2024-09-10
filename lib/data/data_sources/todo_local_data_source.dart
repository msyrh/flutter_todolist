import 'package:hive/hive.dart';
import '../models/todo_model.dart';

class TodoLocalDataSource {
  final Box<TodoModel> box;

  TodoLocalDataSource(this.box);

  Future<List<TodoModel>> getTodos() async {
    return box.values.toList();
  }

  Future<void> addTodo(TodoModel todo) async {
    await box.put(todo.id, todo);
  }
}
