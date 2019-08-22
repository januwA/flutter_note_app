import 'package:flutter_note_app/db/todo/todo.moor.dart';
import 'package:mobx/mobx.dart';
import 'package:moor/moor.dart';

part 'todos.service.g.dart';

class TodosService = _TodosService with _$TodosService;

abstract class _TodosService with Store {
  final _todosDB = TodosDatabase();
  TodoDao get _todoDao => _todosDB.todoDao;

  Stream<List<Todo>> get todos$ => _todoDao.watchNotDeleteTodos();
  Stream<List<Todo>> get deleteTodos$ => _todoDao.watchDeleteTodos();

  Stream<Todo> watchTodo(Todo todo) => _todoDao.watchTodo(todo);

  insertTodo(Insertable<Todo> todo) {
    return _todoDao.insertTodo(todo);
  }

  deleteTodo(Insertable<Todo> todo) {
    _todoDao.deleteTodo(todo);
  }

  Future<bool> updateTodo(Insertable<Todo> todo) {
    return _todoDao.updateTodo(todo);
  }

  Future<int> removeTodo(Insertable<Todo> todo) {
    return _todoDao.removeTodo(todo);
  }

  Future<int> unremoveTodo(Insertable<Todo> todo) {
    return _todoDao.unremoveTodo(todo);
  }

  updateSort(Todo oldTodo, Todo newTodo, bool isLast) {
    // 顶置的只能和顶置的排序, 反之亦然
    if (oldTodo.isTop != newTodo.isTop) return null;
    return _todoDao.updateSort(oldTodo, newTodo, isLast);
  }
}
