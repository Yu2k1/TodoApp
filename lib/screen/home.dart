import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/screen/detail.dart';
import 'package:todo_app/data/todo.dart';
import 'package:todo_app/widget/input_dialog.dart';

import '../main.dart';

final _currentTodo = Provider<Todo>((ref) => throw UnimplementedError());

class Home extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('TODOリスト'),
      ),
      body: ListView(
        children: [
          for (var i = 0; i < todos.length; i++) ...[
            ProviderScope(
              overrides: [
                _currentTodo.overrideWithValue(todos[i]),
              ],
              child: const TodoItem(),
            ),
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<void>(
            context: context,
            builder: (_) {
              return InputDialog();
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TodoItem extends HookConsumerWidget {
  const TodoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(_currentTodo);

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(
              todo.title,
              style: TextStyle(fontSize: 20),
            ),
            trailing: IconButton(
              icon: Icon(Icons.favorite,
                  color: todo.isFavorite ? Colors.red : Colors.grey[350]),
              onPressed: () {
                ref.read(todoListProvider.notifier).toggle(todo.id);
              },
            ),
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Detail(
                    id: todo.id,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
