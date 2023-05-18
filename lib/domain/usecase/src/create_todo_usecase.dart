import 'package:to_do_app/domain/model/model.dart';

abstract class CreateTodoUseCase {
  Future<Todo> execute(
    final String title,
    final String description,
    final bool isCompleted,
    final DateTime dueDate,
  );
}
