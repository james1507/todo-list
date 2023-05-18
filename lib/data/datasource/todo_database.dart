import 'package:to_do_app/data/data.dart';

abstract class TodosDatabase {
  Future<TodoListEntity> allTodos();
  Future<TodoEntity> insertTodo(final TodoEntity todoEntity);
  Future<void> updateTodo(final TodoEntity todoEntity);
  Future<void> deleteTodo(final int id);
}
