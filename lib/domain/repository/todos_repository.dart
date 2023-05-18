import 'package:to_do_app/domain/model/model.dart';

abstract class TodosRepository {
  Future<TodoList> getTodoList();

  Future<Todo> createTodo(
    final String title,
    final String description,
    final bool isCompleted,
    final DateTime dueDate,
  );

  Future<void> updateTodo(
    final TodoId id,
    final String title,
    final String description,
    final bool isCompleted,
    final DateTime dueDate,
  );

  Future<void> deleteTodo(final TodoId id);
}
