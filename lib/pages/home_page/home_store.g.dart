// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$HomeStore on _HomeStore, Store {
  final _$isSelectAllAtom = Atom(name: '_HomeStore.isSelectAll');

  @override
  bool get isSelectAll {
    _$isSelectAllAtom.reportObserved();
    return super.isSelectAll;
  }

  @override
  set isSelectAll(bool value) {
    _$isSelectAllAtom.context
        .checkIfStateModificationsAreAllowed(_$isSelectAllAtom);
    super.isSelectAll = value;
    _$isSelectAllAtom.reportChanged();
  }

  final _$todosAtom = Atom(name: '_HomeStore.todos');

  @override
  ObservableList<Todo> get todos {
    _$todosAtom.reportObserved();
    return super.todos;
  }

  @override
  set todos(ObservableList<Todo> value) {
    _$todosAtom.context.checkIfStateModificationsAreAllowed(_$todosAtom);
    super.todos = value;
    _$todosAtom.reportChanged();
  }

  final _$initAsyncAction = AsyncAction('init');

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  final _$oneAddAsyncAction = AsyncAction('oneAdd');

  @override
  Future<void> oneAdd(Todo todo) {
    return _$oneAddAsyncAction.run(() => super.oneAdd(todo));
  }

  final _$updateTopAsyncAction = AsyncAction('updateTop');

  @override
  Future<void> updateTop(Todo todo) {
    return _$updateTopAsyncAction.run(() => super.updateTop(todo));
  }

  final _$removeAsyncAction = AsyncAction('remove');

  @override
  Future<void> remove(Todo todo) {
    return _$removeAsyncAction.run(() => super.remove(todo));
  }

  final _$_HomeStoreActionController = ActionController(name: '_HomeStore');

  @override
  void initSelect() {
    final _$actionInfo = _$_HomeStoreActionController.startAction();
    try {
      return super.initSelect();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectAll(bool v) {
    final _$actionInfo = _$_HomeStoreActionController.startAction();
    try {
      return super.setSelectAll(v);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearSelect() {
    final _$actionInfo = _$_HomeStoreActionController.startAction();
    try {
      return super.clearSelect();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void select(Todo todo, bool v) {
    final _$actionInfo = _$_HomeStoreActionController.startAction();
    try {
      return super.select(todo, v);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void sort() {
    final _$actionInfo = _$_HomeStoreActionController.startAction();
    try {
      return super.sort();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }
}
