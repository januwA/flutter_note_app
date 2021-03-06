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

  Stream<Todo> watchTodo(int id) => _todoDao.watchTodo(id);

  insertTodo(Insertable<Todo> todo) => _todoDao.insertTodo(todo);

  /// 删除单个
  deleteTodo(int id) => _todoDao.deleteTodo(id);

  /// 删除多个
  void deleteTodos(List<int> dtodoIds) => _todoDao.deleteTodos(dtodoIds);

  Future<bool> updateTodo(Insertable<Todo> todo) => _todoDao.updateTodo(todo);

  Future<int> removeTodo(int id) => _todoDao.removeTodo(id);

  Future<int> unremoveTodo(int id) => _todoDao.unremoveTodo(id);

  updateSort(Todo oldTodo, Todo newTodo, bool isLast) {
    // 顶置的只能和顶置的排序, 反之亦然
    if (oldTodo.isTop != newTodo.isTop) return null;
    return _todoDao.updateSort(oldTodo, newTodo, isLast);
  }
}
