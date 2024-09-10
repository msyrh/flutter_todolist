import 'package:flutter/material.dart';
import 'package:flutter_todolist/presentation/screens/todo_list_screen.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'data/models/todo_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentsDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentsDir.path);
  Hive.registerAdapter(TodoModelAdapter());

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
