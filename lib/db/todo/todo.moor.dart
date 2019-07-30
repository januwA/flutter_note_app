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

  Future<List<Todo>> get getAllTasks => select(todos).get();

  /// 每当基础数据发生变化时，都会发出新项
  Stream<List<Todo>> watchAllTasks() => select(todos).watch();

  /// 插入一条数据
  Future<int> insertTask({
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
  Future<bool> updateTask(Todo todo) => update(todos).replace(todo);

  /// 删除一条数据
  Future<int> deleteTask(Todo todo) => delete(todos).delete(todo);
}
