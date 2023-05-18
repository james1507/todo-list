import 'package:to_do_app/domain/domain.dart';
import 'package:to_do_app/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TodoListPage extends ConsumerWidget {
  final _filteredTodoListProvider = filteredTodoListProvider;
  final _todoListProvider = todoListViewModelStateNotifierProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo App'),
      ),
      body: Column(
        children: [
          ChipsBarWidget(),
          const Divider(height: 2, color: Colors.grey),
          _listCard(ref),
        ],
      ),
      floatingActionButton: _floatingActionButton(context),
    );
  }

  Widget _listCard(WidgetRef ref) {
    return ref.watch(_filteredTodoListProvider).maybeWhen(
          success: (content) => _todoListContainerWidget(ref, content),
          error: (_) => _errorWidget(),
          orElse: () =>
              const Expanded(child: Center(child: CircularProgressIndicator())),
        );
  }

  Widget _todoListContainerWidget(WidgetRef ref, final TodoList todoList) {
    return Expanded(child: _todoListWidget(ref, todoList));
  }

  Widget _todoListWidget(final WidgetRef ref, final TodoList todoList) {
    if (todoList.length == 0) {
      return const Center(child: Text('No ToDo'));
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: todoList.length,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (final BuildContext context, final int index) {
          return _todoItemCardWidget(context, ref, todoList[index]);
        },
      );
    }
  }

  Widget _todoItemCardWidget(
      final BuildContext context, final WidgetRef ref, final Todo todo) {
    return InkWell(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: Theme.of(context).textTheme.headlineLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      DateFormat('yyyy/MM/dd').format(todo.dueDate),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      todo.description.isEmpty
                          ? 'No Description'
                          : todo.description,
                      style: Theme.of(context).textTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              todo.isCompleted
                  ? _checkedIcon(ref, todo)
                  : _uncheckedIcon(ref, todo),
            ],
          ),
        ),
      ),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TodoFormPage(todo),
          )),
    );
  }

  Widget _checkedIcon(final WidgetRef ref, final Todo todo) {
    return InkResponse(
      onTap: () => ref.watch(_todoListProvider.notifier).undoTodo(todo),
      splashColor: Colors.transparent,
      child: const Icon(Icons.done, size: 24, color: Colors.lightGreen),
    );
  }

  Widget _uncheckedIcon(final WidgetRef ref, final Todo todo) {
    return InkResponse(
      onTap: () => ref.watch(_todoListProvider.notifier).completeTodo(todo),
      splashColor: Colors.transparent,
      child: const Icon(
        Icons.radio_button_off_rounded,
        size: 24,
        color: Colors.grey,
      ),
    );
  }

  Widget _floatingActionButton(final BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const TodoFormPage(null),
        ),
      ),
      child: const Icon(Icons.add),
    );
  }

  Widget _errorWidget() {
    return const Center(child: Text('An error has occurred!'));
  }
}

class ChipsBarWidget extends StatelessWidget {
  final _provider = filterKindViewModelStateNotifierProvider;

  @override
  Widget build(final BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final viewModel = ref.watch(_provider.notifier);
        ref.watch(_provider);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              children: [
                InputChip(
                  label: const Text('All'),
                  selected: viewModel.isFilteredByAll(),
                  onSelected: (_) => viewModel.filterByAll(),
                  selectedColor:
                      viewModel.isFilteredByAll() ? Colors.lightBlue : null,
                ),
                const SizedBox(width: 8),
                InputChip(
                  label: const Text('Completed'),
                  selected: viewModel.isFilteredByCompleted(),
                  onSelected: (_) => viewModel.filterByCompleted(),
                  selectedColor: viewModel.isFilteredByCompleted()
                      ? Colors.lightBlue
                      : null,
                ),
                const SizedBox(width: 8),
                InputChip(
                  label: const Text('Incomplete'),
                  selected: viewModel.isFilteredByIncomplete(),
                  onSelected: (_) => viewModel.filterByIncomplete(),
                  selectedColor: viewModel.isFilteredByIncomplete()
                      ? Colors.lightBlue
                      : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
