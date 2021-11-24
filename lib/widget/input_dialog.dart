import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/main.dart';

class InputDialog extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String title = '';
    String content = '';

    return AlertDialog(
      title: Text('タスクの追加'),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(28.0))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'タイトル',
            ),
            onChanged: (value) {
              title = value;
            },
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: '内容',
            ),
            onChanged: (value) {
              content = value;
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('キャンセル'),
        ),
        TextButton(
          onPressed: () {
            if (title.isEmpty) {
              title = '無題のタスク';
            }
            ref.read(todoListProvider.notifier).add(title, content);
            Navigator.pop(context);
          },
          child: Text('追加'),
        ),
      ],
    );
  }
}
