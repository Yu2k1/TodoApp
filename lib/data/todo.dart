import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class Todo {
  Todo({
    required this.id,
    required this.title,
    required this.content,
    this.isFavorite = false,
  });

  final String id;
  final String title;
  final String content;
  final bool isFavorite;

  @override
  String toString() {
    return 'Todo(title: $title, content: $content, isFavorite: $isFavorite)';
  }
}

class TodoList extends StateNotifier<List<Todo>> {
  TodoList([List<Todo>? initialTodos]) : super(initialTodos ?? []);

  void add(String description, String content) {
    state = [
      ...state,
      Todo(
        id: _uuid.v4(),
        title: description,
        content: content,
      ),
    ];
  }

  void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            title: todo.title,
            content: todo.content,
            isFavorite: !todo.isFavorite,
          )
        else
          todo,
    ];
  }
}
