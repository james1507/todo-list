import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:to_do_app/data/data.dart';
import 'package:to_do_app/domain/domain.dart';

final todosDatabaseProvider =
    Provider<TodosDatabase>((_) => TodosDatabaseImpl());

final todosRepositoryProvider = Provider<TodosRepository>(
    (ref) => TodosRepositoryImpl(ref.watch(todosDatabaseProvider)));
