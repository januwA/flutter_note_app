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

  /// 排序
  IntColumn get sort => integer().withDefault(const Constant(0))();
}

@UseMoor(tables: [Todos], daos: [TodoDao])
class TodosDatabase extends _$TodosDatabase {
  TodosDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));
  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) {
        return m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from == 1) {
          await m.addColumn(todos, todos.isDelete);
        } else if (from == 2) {
          await m.addColumn(todos, todos.sort);
        }
      },
      beforeOpen: (OpeningDetails details) async {
        if (details.wasCreated) {
          List<Todo> todosData = await this.select(todos).get();
          for (var t in todosData) {
            await customUpdate('UPDATE todos SET sort = id WHERE id = ?',
                variables: [Variable.withInt(t.id)]);
          }
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
  Stream<List<Todo>> watchNotDeleteTodos() {
    var selectData = select(todos)
      ..where((t) => t.isDelete.equals(false))
      ..orderBy([
        /// 把标星的排在前面
        (t) => OrderingTerm(expression: t.isTop, mode: OrderingMode.desc),

        /// sort 升序排列
        (t) => OrderingTerm(expression: t.sort, mode: OrderingMode.asc),
      ]);
    return selectData.watch();
  }

  /// 被delte的数据
  Stream<List<Todo>> watchDeleteTodos() =>
      (select(todos)..where((t) => t.isDelete.equals(true))).watch();

  Stream<Todo> watchTodo(Todo todo) =>
      (select(todos)..where((t) => t.id.equals(todo.id))).watchSingle();

  /// 插入一条数据
  /// v3: 插入时把sort字段设置为id字段
  insertTodo(Insertable<Todo> todo) {
    return transaction(() async {
      final insertedId = await into(todos).insert(todo);
      await customUpdate('UPDATE todos SET sort = id WHERE id = ?',
          variables: [Variable.withInt(insertedId)]);
    });
  }

  /// 更新一条数据
  Future<bool> updateTodo(Insertable<Todo> todo) => update(todos).replace(todo);

  /// 删除一条数据
  Future<int> deleteTodo(Insertable<Todo> todo) => delete(todos).delete(todo);

  /// 删除多条数据
  void deleteTodos(List<int> dtodoIds) {
    delete(todos)
      ..where(
        // (t) => isIn(t.id, dtodoIds),
        (t) => t.id.isIn(dtodoIds),
      )
      ..go();
  }

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

  updateSort(Todo oldTodo, Todo newTodo, bool isLast) async {
    if (isLast) {
      await (update(todos)..where((t) => t.id.equals(oldTodo.id))).write(
        TodosCompanion(
          sort: Value(newTodo.sort + 1),
        ),
      );
    } else {
      await customUpdate('UPDATE todos SET sort = sort + 1 WHERE sort >= ?',
          variables: [Variable.withInt(newTodo.sort)]);

      await (update(todos)..where((t) => t.id.equals(oldTodo.id))).write(
        TodosCompanion(
          sort: Value(newTodo.sort),
        ),
      );
    }
  }
}
