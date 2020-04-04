import 'package:flutter_note_app/store/todos/todos.service.dart';
import 'package:flutter_note_app/store/version/version.service.dart';

class MainStore {
  final todosService = TodosService();
  final VersionService verSionService = VersionService();
}

MainStore mainStore = MainStore();
