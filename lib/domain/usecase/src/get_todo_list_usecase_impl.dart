import 'package:to_do_app/domain/repository/todos_repository.dart';
import 'package:to_do_app/domain/model/model.dart';
import 'package:to_do_app/domain/usecase/usecase.dart';

class GetTodoListUseCaseImpl implements GetTodoListUseCase {
  final TodosRepository _repository;

  const GetTodoListUseCaseImpl(this._repository);

  @override
  Future<TodoList> execute() => _repository.getTodoList();
}
