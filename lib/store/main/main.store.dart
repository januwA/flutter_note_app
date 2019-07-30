import 'package:flutter_note_app/store/todos/todos.service.dart';
import 'package:mobx/mobx.dart';

part 'main.store.g.dart';

class MainStore = _MainStore with _$MainStore;

abstract class _MainStore with Store {
  final todosService = TodosService();
}

MainStore mainStore = MainStore();
