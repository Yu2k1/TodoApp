import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/main.dart';

class Detail extends HookConsumerWidget {
  final String id;

  Detail({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(todoListProvider).firstWhere((e) => e.id == id);

    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "内容",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.favorite,
                      color: todo.isFavorite ? Colors.red : Colors.grey[350]),
                  iconSize: 30,
                  onPressed: () {
                    ref.read(todoListProvider.notifier).toggle(id);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(color: Colors.black),
            const SizedBox(height: 10),
            Text(
              todo.content,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
