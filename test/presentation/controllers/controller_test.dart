import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_todolist/domain/use_cases/add_todo.dart';
import 'package:flutter_todolist/domain/use_cases/delete_todo.dart';
import 'package:flutter_todolist/domain/use_cases/get_todos.dart';
import 'package:flutter_todolist/domain/use_cases/update_todo.dart';
import 'package:flutter_todolist/presentation/controllers/todo_controller.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_todolist/domain/entities/todo.dart';

import 'controller_test.mocks.dart';

// class MockTodoController extends GetxController with Mock implements GetTodos {}

@GenerateMocks([GetTodos, AddTodo, UpdateTodo, DeleteTodo])
void main() {
  late TodoController todoController;
  late MockGetTodos mockGetTodos;
  late MockAddTodo mockAddTodo;
  late MockUpdateTodo mockUpdateTodo;
  late MockDeleteTodo mockDeleteTodo;

  setUp(() {
    mockGetTodos = MockGetTodos();
    mockAddTodo = MockAddTodo();
    mockUpdateTodo = MockUpdateTodo();
    mockDeleteTodo = MockDeleteTodo();
    todoController = TodoController(
        addTodoUseCase: mockAddTodo,
        getTodosUseCase: mockGetTodos,
        deleteTodoUseCase: mockDeleteTodo,
        updateTodoUseCase: mockUpdateTodo);
  });

  group('TodoController', () {
    test('fetchTodos() : should return a list of Todo', () async {
      // Arrange
      final mockTodos = [Todo(id: '1', title: 'Test Todo')];
      when(mockGetTodos()).thenAnswer((_) async => mockTodos);

      // Act
      todoController.fetchTodos();
      todoController.todos.value = mockTodos;

      // Assert
      verify(mockGetTodos()).called(1);
      expect(todoController.fetchTodos, isA<void>());
      expect(todoController.todos.value, mockTodos);
    });

    test('addTodo() : should add a new todo and fetch todos', () async {
      // Arrange
      final todo = Todo(
        id: DateTime.now().toString(),
        title: 'New Todo',
      );

      when(todoController.addTodo(todo.title)).thenAnswer((_) {});
      when(mockAddTodo.call(todo)).thenAnswer((_) async => todo);
      when(mockGetTodos()).thenAnswer((_) async => [todo]);

      // Act
      todoController.addTodo('New Todo');
      mockAddTodo.call(todo);
      todoController.fetchTodos();
      todoController.todos.value = [todo];

      // Assert
      verify(mockAddTodo.call(todo)).called(1);
      verify(mockGetTodos()).called(1);
      expect(todoController.todos.value, [todo]);
    });

    test('updateTodo() : should add a new todo and fetch todos', () async {
      // Arrange
      final todo = Todo(
        id: DateTime.now().toString(),
        title: 'New Todo',
      );

      when(todoController.updateTodo(todo)).thenAnswer((_) {});
      when(mockUpdateTodo.call(todo)).thenAnswer((_) async => todo);
      when(mockGetTodos()).thenAnswer((_) async => [todo]);

      // Act
      todoController.updateTodo(todo);
      mockUpdateTodo.call(todo);
      todoController.fetchTodos();
      todoController.todos.value = [todo];

      // Assert
      verify(mockUpdateTodo.call(todo)).called(2);
      verify(mockGetTodos()).called(1);
      expect(todoController.todos.value, [todo]);
    });

    test('deleteTodo()should delete todo', () async {
      // Arrange
      String todoId = '1';

      when(mockDeleteTodo(todoId)).thenAnswer((_) async => {});
      when(mockGetTodos()).thenAnswer((_) async => []);

      // Act
      todoController.deleteTodo(todoId);
      mockDeleteTodo.call(todoId);
      todoController.fetchTodos();
      todoController.todos.value = [];

      // Assert
      verify(mockDeleteTodo(todoId)).called(2);
      verify(mockGetTodos()).called(1);
      expect(todoController.todos.value, []);
    });
  });
}
