import 'package:flutter_note_app/models/todo/todo.dart';
import 'package:mobx/mobx.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

final String tablename = 'todos';

abstract class _HomeStore with Store {
  _HomeStore() {
    init();
  }

  @action
  init() async {
    isLoading = true;
    String dbpath = join(await getDatabasesPath(), 'todos_database.db');

    ///打开数据库并存储引用。
    database = openDatabase(
      dbpath,
      onCreate: (db, version) {
        return db.execute(
          """
          CREATE TABLE $tablename (
              id         INTEGER  PRIMARY KEY AUTOINCREMENT,
              title      TEXT     NOT NULL,
              content    TEXT     NOT NULL,
              isTop      BOOLEAN  DEFAULT (0),
              createTime DATETIME DEFAULT (CURRENT_TIMESTAMP) 
          );
          """,
        );
      },
      version: 1,
    );

    todos = await todoAll();
    isLoading = false;
    sort();
  }

  Future<Database> database;

  @observable
  bool isLoading = true;

  @observable
  ObservableList<Todo> todos = ObservableList<Todo>();

  @action
  void initSelect() {
    todos.forEach((Todo e) => e.isSelect = false);
  }

  /// 查询所有todos
  Future<ObservableList<Todo>> todoAll() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tablename);
    var todos = ObservableList<Todo>();
    for (var m in maps) {
      todos.add(Todo(
        id: m['id'],
        title: m['title'],
        content: m['content'],
        isTop: m['isTop'] == 0 ? false : true,
        createTime: DateTime.parse(m['createTime']),
      ));
    }
    return todos;
  }

  @action
  void clearSelect() {
    todos.removeWhere((Todo e) => e.isSelect);
  }

  @action
  void select(Todo todo, bool v) {
    todo.isSelect = v;
  }

  /// 添加一条待办事项
  @action
  Future<void> oneAdd(Todo todo) async {
    final Database db = await database;
    await db.insert(
      tablename,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    todos.add(todo);
  }

  /// 对todos进行置顶排序
  @action
  void sort() {
    todos.sort((a, b) => b - a);
  }

  /// 更新置顶
  @action
  Future<void> updateTop(Todo todo) async {
    todo.isTop = !todo.isTop;
    final db = await database;
    await db.update(
      tablename,
      todo.toMap(),
      where: "id = ?",
      whereArgs: [todo.id],
    );

    // 设置置顶后在排序，才能触发Observer重新渲染
    sort();
  }

  /// 移除一条待办事项
  @action
  Future<void> remove(Todo todo) async {
    final db = await database;
    await db.delete(
      tablename,
      where: "id = ?",
      whereArgs: [todo.id],
    );
    todos.removeWhere((x) => x == todo);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
