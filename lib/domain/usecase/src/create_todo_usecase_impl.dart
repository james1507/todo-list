import 'package:to_do_app/domain/repository/todos_repository.dart';
import 'package:to_do_app/domain/model/model.dart';
import 'package:to_do_app/domain/usecase/usecase.dart';

class CreateTodoUseCaseImpl implements CreateTodoUseCase {
  final TodosRepository _repository;

  const CreateTodoUseCaseImpl(this._repository);

  @override
  Future<Todo> execute(
      String title, String description, bool isCompleted, DateTime dueDate) {
    return _repository.createTodo(title, description, isCompleted, dueDate);
  }
}
