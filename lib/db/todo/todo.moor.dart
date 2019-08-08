import 'package:moor_flutter/moor_flutter.dart';

part 'todo.moor.g.dart';

// 建表
class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get content => text()();
  DateTimeColumn get createTime => dateTime()();
  BoolColumn get isTop => boolean().withDefault(const Constant(false))();

  /// 假删除
  BoolColumn get isDelete => boolean().withDefault(const Constant(false))();
}

@UseMoor(tables: [Todos], daos: [TodoDao])
class TodosDatabase extends _$TodosDatabase {
  TodosDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));
  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (Migrator m, int from, int to) async {
        if (from == 1) {
          await m.addColumn(todos, todos.isDelete);
        }
      },
    );
  }
}

@UseDao(
  tables: [Todos],
)
class TodoDao extends DatabaseAccessor<TodosDatabase> with _$TodoDaoMixin {
  final TodosDatabase db;
  TodoDao(this.db) : super(db);

  /// 过滤掉delete的数据
  Stream<List<Todo>> watchNotDeleteTodos() => (select(todos)
        ..where((t) => t.isDelete.equals(false))
        ..orderBy([
          /// 把标星的排在前面
          (t) => OrderingTerm(expression: t.isTop, mode: OrderingMode.desc),
        ]))
      .watch();

  /// 被delte的数据
  Stream<List<Todo>> watchDeleteTodos() =>
      (select(todos)..where((t) => t.isDelete.equals(true))).watch();

  Stream<Todo> watchTodo(Todo todo) =>
      (select(todos)..where((t) => t.id.equals(todo.id))).watchSingle();

  /// 插入一条数据
  Future<int> insertTodo(Insertable<Todo> todo) => into(todos).insert(todo);

  /// 更新一条数据
  Future<bool> updateTodo(Insertable<Todo> todo) => update(todos).replace(todo);

  /// 删除一条数据
  Future<int> deleteTodo(Insertable<Todo> todo) => delete(todos).delete(todo);

  /// 软删除
  removeTodo(Todo todo) =>
      (update(todos)..where((t) => t.id.equals(todo.id))).write(
        TodosCompanion(
          isDelete: Value(true),
        ),
      );
  unremoveTodo(Todo todo) =>
      (update(todos)..where((t) => t.id.equals(todo.id))).write(
        TodosCompanion(
          isDelete: Value(false),
        ),
      );
}
