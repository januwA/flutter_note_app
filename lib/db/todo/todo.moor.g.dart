// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.moor.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class Todo extends DataClass implements Insertable<Todo> {
  final int id;
  final String title;
  final String content;
  final DateTime createTime;
  final bool isTop;
  final bool isDelete;
  final int sort;
  Todo(
      {@required this.id,
      @required this.title,
      @required this.content,
      @required this.createTime,
      @required this.isTop,
      @required this.isDelete,
      @required this.sort});
  factory Todo.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Todo(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      content:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}content']),
      createTime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}create_time']),
      isTop: boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_top']),
      isDelete:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_delete']),
      sort: intType.mapFromDatabaseResponse(data['${effectivePrefix}sort']),
    );
  }
  factory Todo.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Todo(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      createTime: serializer.fromJson<DateTime>(json['createTime']),
      isTop: serializer.fromJson<bool>(json['isTop']),
      isDelete: serializer.fromJson<bool>(json['isDelete']),
      sort: serializer.fromJson<int>(json['sort']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'createTime': serializer.toJson<DateTime>(createTime),
      'isTop': serializer.toJson<bool>(isTop),
      'isDelete': serializer.toJson<bool>(isDelete),
      'sort': serializer.toJson<int>(sort),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Todo>>(bool nullToAbsent) {
    return TodosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      createTime: createTime == null && nullToAbsent
          ? const Value.absent()
          : Value(createTime),
      isTop:
          isTop == null && nullToAbsent ? const Value.absent() : Value(isTop),
      isDelete: isDelete == null && nullToAbsent
          ? const Value.absent()
          : Value(isDelete),
      sort: sort == null && nullToAbsent ? const Value.absent() : Value(sort),
    ) as T;
  }

  Todo copyWith(
          {int id,
          String title,
          String content,
          DateTime createTime,
          bool isTop,
          bool isDelete,
          int sort}) =>
      Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        createTime: createTime ?? this.createTime,
        isTop: isTop ?? this.isTop,
        isDelete: isDelete ?? this.isDelete,
        sort: sort ?? this.sort,
      );
  @override
  String toString() {
    return (StringBuffer('Todo(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('createTime: $createTime, ')
          ..write('isTop: $isTop, ')
          ..write('isDelete: $isDelete, ')
          ..write('sort: $sort')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      $mrjc(
          $mrjc(
              $mrjc(
                  $mrjc($mrjc($mrjc(0, id.hashCode), title.hashCode),
                      content.hashCode),
                  createTime.hashCode),
              isTop.hashCode),
          isDelete.hashCode),
      sort.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Todo &&
          other.id == id &&
          other.title == title &&
          other.content == content &&
          other.createTime == createTime &&
          other.isTop == isTop &&
          other.isDelete == isDelete &&
          other.sort == sort);
}

class TodosCompanion extends UpdateCompanion<Todo> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> content;
  final Value<DateTime> createTime;
  final Value<bool> isTop;
  final Value<bool> isDelete;
  final Value<int> sort;
  const TodosCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.createTime = const Value.absent(),
    this.isTop = const Value.absent(),
    this.isDelete = const Value.absent(),
    this.sort = const Value.absent(),
  });
}

class $TodosTable extends Todos with TableInfo<$TodosTable, Todo> {
  final GeneratedDatabase _db;
  final String _alias;
  $TodosTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false, hasAutoIncrement: true);
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _contentMeta = const VerificationMeta('content');
  GeneratedTextColumn _content;
  @override
  GeneratedTextColumn get content => _content ??= _constructContent();
  GeneratedTextColumn _constructContent() {
    return GeneratedTextColumn(
      'content',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createTimeMeta = const VerificationMeta('createTime');
  GeneratedDateTimeColumn _createTime;
  @override
  GeneratedDateTimeColumn get createTime =>
      _createTime ??= _constructCreateTime();
  GeneratedDateTimeColumn _constructCreateTime() {
    return GeneratedDateTimeColumn(
      'create_time',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isTopMeta = const VerificationMeta('isTop');
  GeneratedBoolColumn _isTop;
  @override
  GeneratedBoolColumn get isTop => _isTop ??= _constructIsTop();
  GeneratedBoolColumn _constructIsTop() {
    return GeneratedBoolColumn('is_top', $tableName, false,
        defaultValue: const Constant(false));
  }

  final VerificationMeta _isDeleteMeta = const VerificationMeta('isDelete');
  GeneratedBoolColumn _isDelete;
  @override
  GeneratedBoolColumn get isDelete => _isDelete ??= _constructIsDelete();
  GeneratedBoolColumn _constructIsDelete() {
    return GeneratedBoolColumn('is_delete', $tableName, false,
        defaultValue: const Constant(false));
  }

  final VerificationMeta _sortMeta = const VerificationMeta('sort');
  GeneratedIntColumn _sort;
  @override
  GeneratedIntColumn get sort => _sort ??= _constructSort();
  GeneratedIntColumn _constructSort() {
    return GeneratedIntColumn('sort', $tableName, false,
        defaultValue: const Constant(0));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, title, content, createTime, isTop, isDelete, sort];
  @override
  $TodosTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'todos';
  @override
  final String actualTableName = 'todos';
  @override
  VerificationContext validateIntegrity(TodosCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (title.isRequired && isInserting) {
      context.missing(_titleMeta);
    }
    if (d.content.present) {
      context.handle(_contentMeta,
          content.isAcceptableValue(d.content.value, _contentMeta));
    } else if (content.isRequired && isInserting) {
      context.missing(_contentMeta);
    }
    if (d.createTime.present) {
      context.handle(_createTimeMeta,
          createTime.isAcceptableValue(d.createTime.value, _createTimeMeta));
    } else if (createTime.isRequired && isInserting) {
      context.missing(_createTimeMeta);
    }
    if (d.isTop.present) {
      context.handle(
          _isTopMeta, isTop.isAcceptableValue(d.isTop.value, _isTopMeta));
    } else if (isTop.isRequired && isInserting) {
      context.missing(_isTopMeta);
    }
    if (d.isDelete.present) {
      context.handle(_isDeleteMeta,
          isDelete.isAcceptableValue(d.isDelete.value, _isDeleteMeta));
    } else if (isDelete.isRequired && isInserting) {
      context.missing(_isDeleteMeta);
    }
    if (d.sort.present) {
      context.handle(
          _sortMeta, sort.isAcceptableValue(d.sort.value, _sortMeta));
    } else if (sort.isRequired && isInserting) {
      context.missing(_sortMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Todo map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Todo.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TodosCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.content.present) {
      map['content'] = Variable<String, StringType>(d.content.value);
    }
    if (d.createTime.present) {
      map['create_time'] = Variable<DateTime, DateTimeType>(d.createTime.value);
    }
    if (d.isTop.present) {
      map['is_top'] = Variable<bool, BoolType>(d.isTop.value);
    }
    if (d.isDelete.present) {
      map['is_delete'] = Variable<bool, BoolType>(d.isDelete.value);
    }
    if (d.sort.present) {
      map['sort'] = Variable<int, IntType>(d.sort.value);
    }
    return map;
  }

  @override
  $TodosTable createAlias(String alias) {
    return $TodosTable(_db, alias);
  }
}

abstract class _$TodosDatabase extends GeneratedDatabase {
  _$TodosDatabase(QueryExecutor e)
      : super(const SqlTypeSystem.withDefaults(), e);
  $TodosTable _todos;
  $TodosTable get todos => _todos ??= $TodosTable(this);
  TodoDao _todoDao;
  TodoDao get todoDao => _todoDao ??= TodoDao(this as TodosDatabase);
  @override
  List<TableInfo> get allTables => [todos];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$TodoDaoMixin on DatabaseAccessor<TodosDatabase> {
  $TodosTable get todos => db.todos;
}
