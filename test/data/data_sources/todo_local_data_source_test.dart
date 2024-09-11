import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todolist/data/models/todo_model.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_todolist/data/data_sources/todo_local_data_source.dart';
import 'package:mockito/mockito.dart';
import './../models/todo_model_test.mocks.dart';
import './todo_local_data_source_test.mocks.dart';

@GenerateMocks([TodoLocalDataSource])
void main() {
  group('todoLocalDataSource', () {
    late MockBox<TodoModel> mockBox;
    late MockTodoLocalDataSource mockTodoLocalDataSource;

    setUp(() {
      mockBox = MockBox<TodoModel>();
      mockTodoLocalDataSource = MockTodoLocalDataSource(mockBox);
    });

    test('getTodos() : should return a list of todos from mockBox', () async {
      // Arrange
      final todoModels = [
        TodoModel(id: '1', title: 'Todo 1'),
        TodoModel(id: '2', title: 'Todo 2'),
      ];
      when(mockBox.values).thenReturn(todoModels.toList());
      when(mockTodoLocalDataSource.getTodos())
          .thenAnswer((_) async => mockBox.values.toList());

      // Act
      final result = await mockTodoLocalDataSource.getTodos();

      // Assert
      expect(result.length, 2);
      expect(result[0].title, 'Todo 1');
      expect(result[1].title, 'Todo 2');
    });

    test('addTodo() : should add a todo to the mockBox', () async {
      // Arrange
      final newTodo = TodoModel(id: '3', title: 'New Todo');

      when(mockTodoLocalDataSource.addTodo(newTodo))
          .thenAnswer((_) async => mockBox.put(newTodo.id, newTodo));
          
      // Act
      await mockTodoLocalDataSource.addTodo(newTodo);

      // Verify
      verify(mockTodoLocalDataSource.addTodo(newTodo)).called(1);
      verify(mockBox.put(newTodo.id, newTodo)).called(1);
    });

    test('updateTodo() : should update a todo in mockBox', () async {
      // Arrange
      final newTodo = TodoModel(id: '3', title: 'New Todo updated');

      when(mockTodoLocalDataSource.updateTodo(newTodo))
          .thenAnswer((_) async => mockBox.put(newTodo.id, newTodo));
      // Act
      await mockTodoLocalDataSource.updateTodo(newTodo);

      // Verify
      verify(mockTodoLocalDataSource.updateTodo(newTodo)).called(1);
      verify(mockBox.put(newTodo.id, newTodo)).called(1);
    });

    test('deleteTodo() : should delete a todo from the mockBox', () async {
      // Arrange
      const todoId = "1";

      when(mockTodoLocalDataSource.deleteTodo(todoId))
          .thenAnswer((_) async => mockBox.delete(todoId));

      // Act
      await mockTodoLocalDataSource.deleteTodo(todoId);

      // Verify
      verify(mockTodoLocalDataSource.deleteTodo(todoId)).called(1);
      verify(mockBox.delete(todoId)).called(1);
    });
  });
}
