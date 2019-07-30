import 'package:flutter_note_app/db/todo/todo.moor.dart';
import 'package:mobx/mobx.dart';

part 'todos.service.g.dart';

class TodosService = _TodosService with _$TodosService;

abstract class _TodosService with Store {
  final todosDB = TodosDatabase();
  Stream<List<Todo>> get todos$ =>
      todosDB.watchAllTasks().map((List<Todo> todos) {
        todos.sort((a, b) => _getInt(b.isTop).compareTo(_getInt(a.isTop)));
        return todos;
      });

  int _getInt(bool b) => b ? 1 : 0;
}
