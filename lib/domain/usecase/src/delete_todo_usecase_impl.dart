import 'package:to_do_app/domain/repository/todos_repository.dart';
import 'package:to_do_app/domain/model/model.dart';
import 'package:to_do_app/domain/usecase/usecase.dart';

class DeleteTodoUseCaseImpl implements DeleteTodoUseCase {
  final TodosRepository _repository;

  const DeleteTodoUseCaseImpl(this._repository);

  @override
  Future<void> execute(TodoId id) {
    return _repository.deleteTodo(id);
  }
}
