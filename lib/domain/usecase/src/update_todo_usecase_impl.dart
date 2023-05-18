import 'package:to_do_app/domain/repository/todos_repository.dart';
import 'package:to_do_app/domain/model/model.dart';
import 'package:to_do_app/domain/usecase/usecase.dart';

class UpdateTodoUseCaseImpl implements UpdateTodoUseCase {
  final TodosRepository _repository;

  const UpdateTodoUseCaseImpl(this._repository);

  @override
  Future<void> execute(TodoId id, String title, String description,
      bool isCompleted, DateTime dueDate) {
    return _repository.updateTodo(id, title, description, isCompleted, dueDate);
  }
}
