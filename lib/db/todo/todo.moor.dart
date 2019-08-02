import 'package:moor_flutter/moor_flutter.dart';

part 'todo.moor.g.dart';

// 建表
class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get content => text()();
  DateTimeColumn get createTime => dateTime()();
  BoolColumn get isTop => boolean().withDefault(const Constant(false))();
}

@UseMoor(tables: [Todos], daos: [TodoDao])
class TodosDatabase extends _$TodosDatabase {
  TodosDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));
  @override
  int get schemaVersion => 1;
}

@UseDao(
  tables: [Todos],
)
class TodoDao extends DatabaseAccessor<TodosDatabase> with _$TodoDaoMixin {
  final TodosDatabase db;
  TodoDao(this.db) : super(db);

  /// 每当基础数据发生变化时，都会发出新项
  Stream<List<Todo>> watchAllTodos() => (select(todos)
        ..orderBy([
          /// 把标星的排在前面
          (t) => OrderingTerm(expression: t.isTop, mode: OrderingMode.desc),
        ]))
      .watch();

  Stream<Todo> watchTodo(Todo todo) =>
      (select(todos)..where((t) => t.id.equals(todo.id))).watchSingle();

  /// 插入一条数据
  Future<int> insertTodo(Insertable<Todo> todo) => into(todos).insert(todo);

  /// 更新一条数据
  Future<bool> updateTodo(Insertable<Todo> todo) => update(todos).replace(todo);

  /// 删除一条数据
  Future<int> deleteTodo(Insertable<Todo> todo) => delete(todos).delete(todo);
}
