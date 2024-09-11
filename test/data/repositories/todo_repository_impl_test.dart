import 'package:flutter_todolist/data/repositories/todo_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_todolist/domain/entities/todo.dart';
import 'package:flutter_todolist/data/models/todo_model.dart';

import './../models/todo_model_test.mocks.dart';
import './../data_sources/todo_local_data_source_test.mocks.dart';
import './../repositories/todo_repository_impl_test.mocks.dart';

@GenerateMocks([TodoRepositoryImpl])
void main() {
  group('todoRepositoryImpl', () {
    late MockBox<TodoModel> mockBox;
    late MockTodoLocalDataSource mockTodoLocalDataSource;
    late MockTodoRepositoryImpl mockTodoRepositoryImpl;

    setUp(() {
      mockBox = MockBox<TodoModel>();
      mockTodoLocalDataSource = MockTodoLocalDataSource(mockBox);
      mockTodoRepositoryImpl = MockTodoRepositoryImpl(mockTodoLocalDataSource);
    });

    test('getTodos() : should return a list of Todo from localDataSource',
        () async {
      // Arrange
      final todo = Todo(
        id: "1",
        title: "Test Todo",
        completed: false,
      );

      final todoModel = TodoModel.fromEntity(todo);

      when(mockBox.values).thenReturn([todoModel].toList());

      when(mockTodoLocalDataSource.getTodos())
          .thenAnswer((_) async => mockBox.values.toList());

      final todoModels = await mockTodoLocalDataSource.getTodos();

      when(mockTodoRepositoryImpl.getTodos()).thenAnswer(
          (_) async => todoModels.map((e) => e.toEntity()).toList());

      // Act
      final todos = await mockTodoRepositoryImpl.getTodos();

      // Assert that the list contains two specific instances
      expect(todos, isA<List<Todo>>());
      expect(todos.length, 1);

      // Verify instance
      expect(todos[0].id, "1");
      expect(todos[0].title, 'Test Todo');

      // Verify that function called
      verify(mockTodoRepositoryImpl.getTodos()).called(1);
    });

    test('getTodos() : should return empty list of Todo from localDataSource',
        () async {
      // Arrange
      when(mockBox.values).thenReturn([]);

      when(mockTodoLocalDataSource.getTodos())
          .thenAnswer((_) async => mockBox.values.toList());

      final todoModels = await mockTodoLocalDataSource.getTodos();

      when(mockTodoRepositoryImpl.getTodos()).thenAnswer(
          (_) async => todoModels.map((e) => e.toEntity()).toList());
      // Act
      final todos = await mockTodoRepositoryImpl.getTodos();

      // Assert that the list contains two specific instances
      expect(todos, isA<List<Todo>>());
      expect(todos.length, 0);

      // Verify that function called
      verify(mockTodoRepositoryImpl.getTodos()).called(1);
    });

    test('addTodo(): should add todoModel to box ', () async {
      // Arrange
      final newTodo = Todo(id: '1', title: 'Todo 1', completed: false);

      final newTodoModel = TodoModel.fromEntity(newTodo);

      when(mockTodoRepositoryImpl.addTodo(newTodo)).thenAnswer((_) async =>
          Future.value(mockTodoLocalDataSource.addTodo(newTodoModel)));

      when(mockTodoLocalDataSource.addTodo(newTodoModel)).thenAnswer(
          (_) async => Future.value(mockBox.put(newTodo.id, newTodoModel)));

      // Act
      await mockTodoRepositoryImpl.addTodo(newTodo);

      // Verify
      verify(mockTodoRepositoryImpl.addTodo(newTodo)).called(1);
      verify(mockTodoLocalDataSource.addTodo(newTodoModel)).called(1);
      verify(mockBox.put(newTodo.id, newTodoModel)).called(1);
    });

    test('updateTodo(): should update data todoModel in box ', () async {
      // Arrange
      final newTodo = Todo(id: '1', title: 'Todo 1 updated', completed: false);

      final newTodoModel = TodoModel.fromEntity(newTodo);

      when(mockTodoRepositoryImpl.updateTodo(newTodo)).thenAnswer((_) async =>
          Future.value(mockTodoLocalDataSource.updateTodo(newTodoModel)));

      when(mockTodoLocalDataSource.updateTodo(newTodoModel)).thenAnswer(
          (_) async => Future.value(mockBox.put(newTodo.id, newTodoModel)));

      // Act
      await mockTodoRepositoryImpl.updateTodo(newTodo);

      // Verify
      verify(mockTodoRepositoryImpl.updateTodo(newTodo)).called(1);
      verify(mockTodoLocalDataSource.updateTodo(newTodoModel)).called(1);
      verify(mockBox.put(newTodo.id, newTodoModel)).called(1);
    });

    test('deleteTodo(): should delete data todoModel from box ', () async {
      // Arrange
      const todoId = "1";

      when(mockTodoRepositoryImpl.deleteTodo(todoId)).thenAnswer((_) async =>
          Future.value(mockTodoLocalDataSource.deleteTodo(todoId)));

      when(mockTodoLocalDataSource.deleteTodo(todoId))
          .thenAnswer((_) async => Future.value(mockBox.delete(todoId)));

      // Act
      await mockTodoRepositoryImpl.deleteTodo(todoId);

      // Verify
      verify(mockTodoRepositoryImpl.deleteTodo(todoId)).called(1);
      verify(mockTodoLocalDataSource.deleteTodo(todoId)).called(1);
      verify(mockBox.delete(todoId)).called(1);
    });
  });
}
