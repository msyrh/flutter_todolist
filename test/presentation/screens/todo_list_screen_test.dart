import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todolist/domain/entities/todo.dart';
import 'package:flutter_todolist/domain/use_cases/add_todo.dart';
import 'package:flutter_todolist/domain/use_cases/delete_todo.dart';
import 'package:flutter_todolist/domain/use_cases/get_todos.dart';
import 'package:flutter_todolist/domain/use_cases/update_todo.dart';
import 'package:flutter_todolist/presentation/screens/todo_list_screen.dart';
import 'package:flutter_todolist/presentation/widgets/todo_tile.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_todolist/presentation/controllers/todo_controller.dart';
import 'todo_list_screen_test.mocks.dart';

mockControllerCallback() => InternalFinalCallback<void>(callback: () {});

const fallbackGenerators = {
  #onStart: mockControllerCallback,
  #onDelete: mockControllerCallback,
};

@GenerateMocks([
  TodoTile,
  GetTodos,
  AddTodo,
  UpdateTodo,
  DeleteTodo
], customMocks: [
  MockSpec<TodoController>(
      as: #MockTodoController, fallbackGenerators: fallbackGenerators),
])
void main() {
  late MockTodoController mockTodoController;
  late MockGetTodos mockGetTodos;
  late MockAddTodo mockAddTodo;
  late MockUpdateTodo mockUpdateTodo;
  late MockDeleteTodo mockDeleteTodo;

  setUp(() {
    // Initialize the mocks
    mockGetTodos = MockGetTodos();
    mockAddTodo = MockAddTodo();
    mockUpdateTodo = MockUpdateTodo();
    mockDeleteTodo = MockDeleteTodo();

    // Create a mock TodoController with mock use cases
    mockTodoController = MockTodoController();

    // Set up the mock controller
    when(mockTodoController.onStart())
        .thenAnswer((_) => mockControllerCallback());
    when(mockTodoController.addListener(any)).thenAnswer((_) => () {});

    // Use Get.put() to inject the mocks into GetX
    Get.put<MockGetTodos>(mockGetTodos);
    Get.put<MockAddTodo>(mockAddTodo);
    Get.put<MockUpdateTodo>(mockUpdateTodo);
    Get.put<MockDeleteTodo>(mockDeleteTodo);
    Get.put<MockTodoController>(mockTodoController);

    when(mockTodoController.addTodoUseCase).thenReturn(mockAddTodo);
    when(mockTodoController.getTodosUseCase).thenReturn(mockGetTodos);
    when(mockTodoController.deleteTodoUseCase).thenReturn(mockDeleteTodo);
    when(mockTodoController.updateTodoUseCase).thenReturn(mockUpdateTodo);
    when(mockTodoController.todos).thenReturn([
      Todo(id: '1', title: 'Test Todo 1'),
      Todo(id: '2', title: 'Test Todo 2'),
    ].obs);
  });

  tearDown(() {
    // Clean up GetX instances after each test
    Get.reset();
  });

  testWidgets('TodoListScreen displays todos and interacts with TodoTile',
      (WidgetTester tester) async {
    //  ══╡ EXCEPTION CAUGHT BY WIDGETS LIBRARY ╞═══════════════════════════════════════════════════════════
    // The following message was thrown building TodoListScreen(dirty):
    // "GetTodos" not found. You need to call "Get.put(GetTodos())" or "Get.lazyPut(()=>GetTodos())"

    // The relevant error-causing widget was:
    //   TodoListScreen
    //   TodoListScreen:file:///Volumes/hdd-storage/GitHub/flutter_todolist/test/presentation/screens/todo_list_screen_test.dart:83:28

    // Build the widget
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: TodoListScreen()),
    ));

    // Verify TodoTile widgets are displayed with correct content
    expect(find.text('Test Todo 1'), findsOneWidget);
    expect(find.text('Test Todo 2'), findsOneWidget);

    // Tap the FloatingActionButton to add a new todo
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(); // Rebuild the widget tree

    // Simulate entering text and submitting
    await tester.enterText(find.byType(TextField), 'New Todo');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump(); // Rebuild the widget tree

    // Verify that addTodo method on controller was called
    final mockTodoController = Get.find<TodoController>();
    verify(mockTodoController.addTodo('New Todo')).called(1);

    // Verify that the new todo is added to the list
    expect(find.text('New Todo'), findsOneWidget);
  });
}
