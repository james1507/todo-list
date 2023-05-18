import 'package:to_do_app/domain/model/model.dart';

abstract class UpdateTodoUseCase {
  Future<void> execute(
    final TodoId id,
    final String title,
    final String description,
    final bool isCompleted,
    final DateTime dueDate,
  );
}
