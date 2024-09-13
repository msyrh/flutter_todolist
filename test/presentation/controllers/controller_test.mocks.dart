// Mocks generated by Mockito 5.2.0 from annotations
// in flutter_todolist/test/presentation/controllers/controller_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:flutter_todolist/domain/entities/todo.dart' as _i5;
import 'package:flutter_todolist/domain/repositories/todo_repository.dart'
    as _i2;
import 'package:flutter_todolist/domain/use_cases/add_todo.dart' as _i6;
import 'package:flutter_todolist/domain/use_cases/delete_todo.dart' as _i8;
import 'package:flutter_todolist/domain/use_cases/get_todos.dart' as _i3;
import 'package:flutter_todolist/domain/use_cases/update_todo.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeTodoRepository_0 extends _i1.Fake implements _i2.TodoRepository {}

/// A class which mocks [GetTodos].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTodos extends _i1.Mock implements _i3.GetTodos {
  MockGetTodos() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TodoRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTodoRepository_0()) as _i2.TodoRepository);
  @override
  _i4.Future<List<_i5.Todo>> call() =>
      (super.noSuchMethod(Invocation.method(#call, []),
              returnValue: Future<List<_i5.Todo>>.value(<_i5.Todo>[]))
          as _i4.Future<List<_i5.Todo>>);
}

/// A class which mocks [AddTodo].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddTodo extends _i1.Mock implements _i6.AddTodo {
  MockAddTodo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TodoRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTodoRepository_0()) as _i2.TodoRepository);
  @override
  _i4.Future<void> call(_i5.Todo? todo) =>
      (super.noSuchMethod(Invocation.method(#call, [todo]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
}

/// A class which mocks [UpdateTodo].
///
/// See the documentation for Mockito's code generation for more information.
class MockUpdateTodo extends _i1.Mock implements _i7.UpdateTodo {
  MockUpdateTodo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TodoRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTodoRepository_0()) as _i2.TodoRepository);
  @override
  _i4.Future<void> call(_i5.Todo? todo) =>
      (super.noSuchMethod(Invocation.method(#call, [todo]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
}

/// A class which mocks [DeleteTodo].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeleteTodo extends _i1.Mock implements _i8.DeleteTodo {
  MockDeleteTodo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TodoRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTodoRepository_0()) as _i2.TodoRepository);
  @override
  _i4.Future<void> call(String? id) =>
      (super.noSuchMethod(Invocation.method(#call, [id]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
}