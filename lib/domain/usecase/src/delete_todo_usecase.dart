import 'package:to_do_app/domain/model/model.dart';

abstract class DeleteTodoUseCase {
  Future<void> execute(final TodoId id);
}
