import 'package:flutter/material.dart';
import 'package:flutter_todolist/domain/repositories/todo_repository.dart';
import 'package:flutter_todolist/presentation/controllers/todo_controller.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/data_sources/todo_local_data_source.dart';
import 'data/repositories/todo_repository_impl.dart';
import 'domain/use_cases/add_todo.dart';
import 'domain/use_cases/delete_todo.dart';
import 'domain/use_cases/get_todos.dart';
import 'domain/use_cases/update_todo.dart';
import 'presentation/screens/todo_list_screen.dart';
import 'data/models/todo_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentsDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentsDir.path);
  Hive.registerAdapter(TodoModelAdapter());

   // Open the box
  final box = await Hive.openBox<TodoModel>('todos');

  // Register the box and data source with GetX
  Get.put<Box<TodoModel>>(box);

  // Setup dependencies
  final todoLocalDataSource = TodoLocalDataSource(Get.find());
  Get.put<TodoLocalDataSource>(todoLocalDataSource);

  final todoRepository = TodoRepositoryImpl(todoLocalDataSource);

  // Register the repository
  Get.put<TodoRepository>(todoRepository);

  // Register use cases
  Get.put<GetTodos>(GetTodos(todoRepository));
  Get.put<AddTodo>(AddTodo(todoRepository));
  Get.put<UpdateTodo>(UpdateTodo(todoRepository));
  Get.put<DeleteTodo>(DeleteTodo(todoRepository));

  // Register controllers
  Get.put<TodoController>(TodoController(
    getTodosUseCase: Get.find(),
    addTodoUseCase: Get.find(), 
    updateTodoUseCase: Get.find(),
    deleteTodoUseCase: Get.find(),
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'To-Do List',
      home: TodoListScreen(),
    );
  }
}
