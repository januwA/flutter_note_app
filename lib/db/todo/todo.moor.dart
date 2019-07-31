import 'package:moor_flutter/moor_flutter.dart';

part 'todo.moor.g.dart';

// 建表
class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get content => text()();
  DateTimeColumn get createTime =>
      dateTime().withDefault(Constant(DateTime.now()))();
  BoolColumn get isTop => boolean().withDefault(const Constant(false))();
}

@UseMoor(tables: [Todos])
class TodosDatabase extends _$TodosDatabase {
  TodosDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));
  @override
  int get schemaVersion => 1;

  Future<List<Todo>> get getAllTodos => select(todos).get();

  /// 每当基础数据发生变化时，都会发出新项
  Stream<List<Todo>> watchAllTodos() => select(todos).watch();

  Stream<Todo> watchTodo(Todo todo) =>
      (select(todos)..where((t) => t.id.equals(todo.id)))
          .watch()
          .map((List<Todo> todos) => todos[0]);

  /// 插入一条数据
  Future<int> insertTodo({
    String title,
    String content,
  }) =>
      into(todos).insert(
        TodosCompanion(
          title: Value(title),
          content: Value(content),
        ),
      );

  /// 更新一条数据
  Future<bool> updateTodo(Todo todo) => update(todos).replace(todo);

  /// 删除一条数据
  Future<int> deleteTodo(Todo todo) => delete(todos).delete(todo);
}
