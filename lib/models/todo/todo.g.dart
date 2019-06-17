// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$Todo on _Todo, Store {
  Computed<String> _$createTimeStringComputed;

  @override
  String get createTimeString => (_$createTimeStringComputed ??=
          Computed<String>(() => super.createTimeString))
      .value;

  final _$isSelectAtom = Atom(name: '_Todo.isSelect');

  @override
  bool get isSelect {
    _$isSelectAtom.reportObserved();
    return super.isSelect;
  }

  @override
  set isSelect(bool value) {
    _$isSelectAtom.context.checkIfStateModificationsAreAllowed(_$isSelectAtom);
    super.isSelect = value;
    _$isSelectAtom.reportChanged();
  }

  final _$titleAtom = Atom(name: '_Todo.title');

  @override
  String get title {
    _$titleAtom.reportObserved();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.context.checkIfStateModificationsAreAllowed(_$titleAtom);
    super.title = value;
    _$titleAtom.reportChanged();
  }

  final _$contentAtom = Atom(name: '_Todo.content');

  @override
  String get content {
    _$contentAtom.reportObserved();
    return super.content;
  }

  @override
  set content(String value) {
    _$contentAtom.context.checkIfStateModificationsAreAllowed(_$contentAtom);
    super.content = value;
    _$contentAtom.reportChanged();
  }

  final _$isTopAtom = Atom(name: '_Todo.isTop');

  @override
  bool get isTop {
    _$isTopAtom.reportObserved();
    return super.isTop;
  }

  @override
  set isTop(bool value) {
    _$isTopAtom.context.checkIfStateModificationsAreAllowed(_$isTopAtom);
    super.isTop = value;
    _$isTopAtom.reportChanged();
  }

  final _$createTimeAtom = Atom(name: '_Todo.createTime');

  @override
  DateTime get createTime {
    _$createTimeAtom.reportObserved();
    return super.createTime;
  }

  @override
  set createTime(DateTime value) {
    _$createTimeAtom.context
        .checkIfStateModificationsAreAllowed(_$createTimeAtom);
    super.createTime = value;
    _$createTimeAtom.reportChanged();
  }
}
