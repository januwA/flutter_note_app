// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.moor.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    if (!nullToAbsent || createTime != null) {
      map['create_time'] = Variable<DateTime>(createTime);
    }
    if (!nullToAbsent || isTop != null) {
      map['is_top'] = Variable<bool>(isTop);
    }
    if (!nullToAbsent || isDelete != null) {
      map['is_delete'] = Variable<bool>(isDelete);
    }
    if (!nullToAbsent || sort != null) {
      map['sort'] = Variable<int>(sort);
    }
    return map;
  }

  TodosCompanion toCompanion(bool nullToAbsent) {
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
    );
  }

  factory Todo.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
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
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'createTime': serializer.toJson<DateTime>(createTime),
      'isTop': serializer.toJson<bool>(isTop),
      'isDelete': serializer.toJson<bool>(isDelete),
      'sort': serializer.toJson<int>(sort),
    };
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
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(
              content.hashCode,
              $mrjc(
                  createTime.hashCode,
                  $mrjc(isTop.hashCode,
                      $mrjc(isDelete.hashCode, sort.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Todo &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.createTime == this.createTime &&
          other.isTop == this.isTop &&
          other.isDelete == this.isDelete &&
          other.sort == this.sort);
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
  TodosCompanion.insert({
    this.id = const Value.absent(),
    @required String title,
    @required String content,
    @required DateTime createTime,
    this.isTop = const Value.absent(),
    this.isDelete = const Value.absent(),
    this.sort = const Value.absent(),
  })  : title = Value(title),
        content = Value(content),
        createTime = Value(createTime);
  static Insertable<Todo> custom({
    Expression<int> id,
    Expression<String> title,
    Expression<String> content,
    Expression<DateTime> createTime,
    Expression<bool> isTop,
    Expression<bool> isDelete,
    Expression<int> sort,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (createTime != null) 'create_time': createTime,
      if (isTop != null) 'is_top': isTop,
      if (isDelete != null) 'is_delete': isDelete,
      if (sort != null) 'sort': sort,
    });
  }

  TodosCompanion copyWith(
      {Value<int> id,
      Value<String> title,
      Value<String> content,
      Value<DateTime> createTime,
      Value<bool> isTop,
      Value<bool> isDelete,
      Value<int> sort}) {
    return TodosCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createTime: createTime ?? this.createTime,
      isTop: isTop ?? this.isTop,
      isDelete: isDelete ?? this.isDelete,
      sort: sort ?? this.sort,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<DateTime>(createTime.value);
    }
    if (isTop.present) {
      map['is_top'] = Variable<bool>(isTop.value);
    }
    if (isDelete.present) {
      map['is_delete'] = Variable<bool>(isDelete.value);
    }
    if (sort.present) {
      map['sort'] = Variable<int>(sort.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodosCompanion(')
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
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
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
  VerificationContext validateIntegrity(Insertable<Todo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content'], _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('create_time')) {
      context.handle(
          _createTimeMeta,
          createTime.isAcceptableOrUnknown(
              data['create_time'], _createTimeMeta));
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    if (data.containsKey('is_top')) {
      context.handle(
          _isTopMeta, isTop.isAcceptableOrUnknown(data['is_top'], _isTopMeta));
    }
    if (data.containsKey('is_delete')) {
      context.handle(_isDeleteMeta,
          isDelete.isAcceptableOrUnknown(data['is_delete'], _isDeleteMeta));
    }
    if (data.containsKey('sort')) {
      context.handle(
          _sortMeta, sort.isAcceptableOrUnknown(data['sort'], _sortMeta));
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
  $TodosTable createAlias(String alias) {
    return $TodosTable(_db, alias);
  }
}

abstract class _$TodosDatabase extends GeneratedDatabase {
  _$TodosDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $TodosTable _todos;
  $TodosTable get todos => _todos ??= $TodosTable(this);
  TodoDao _todoDao;
  TodoDao get todoDao => _todoDao ??= TodoDao(this as TodosDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todos];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$TodoDaoMixin on DatabaseAccessor<TodosDatabase> {
  $TodosTable get todos => attachedDatabase.todos;
}
