import 'package:to_do_app/domain/model/model.dart';

abstract class GetTodoListUseCase {
  Future<TodoList> execute();
}
