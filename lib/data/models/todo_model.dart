import 'package:hive/hive.dart';
import 'package:flutter_todolist/domain/entities/todo.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final bool completed;

  TodoModel({
    required this.id,
    required this.title,
    this.completed = false,
  });

  Todo toEntity() {
    return Todo(
      id: id,
      title: title,
      completed: completed,
    );
  }

  static TodoModel fromEntity(Todo todo) {
    return TodoModel(id: todo.id, title: todo.title, completed: todo.completed);
  }
}
