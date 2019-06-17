import 'package:flutter_note_app/models/todo/todo.dart';
import 'package:mobx/mobx.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  _HomeStore() {
    sort();
  }
  @observable
  bool isSelectAll = false;

  @observable
  ObservableList<Todo> todos = ObservableList<Todo>()
    ..addAll([
      Todo(
          title: "acreateTime.monthcreateTime.monthcreateTime.month",
          content: "aaaa",
          isTop: true),
      Todo(
        title: "b",
        content: "bbbb",
        createTime: DateTime.parse('2012-02-27 13:27:00'),
      ),
      Todo(
        title: "c",
        content: "ccccc",
        createTime: DateTime.parse('2019-06-16 13:27:00'),
      ),
    ]);

  @action
  void setSelectAll(bool v) {
    isSelectAll = v;
  }

  @action
  void select(Todo todo, bool v) {
    todo.isSelect = v;
  }

  /// 添加一条待办事项
  @action
  void oneAdd(Todo item) {
    todos.add(item);
  }

  /// 对todos进行置顶排序
  @action
  void sort() {
    todos.sort((a, b) => b - a);
  }

  /// 更新置顶
  @action
  void updateTop(Todo todo) {
    todo.isTop = !todo.isTop;

    /// 设置置顶后在排序，才能触发Observer重新渲染
    sort();
  }

  /// 移除一条待办事项
  @action
  void remove(Todo todo) {
    // todos.remove(todo); // 会引发错误
    todos.removeWhere((x) => x == todo);
  }
}
