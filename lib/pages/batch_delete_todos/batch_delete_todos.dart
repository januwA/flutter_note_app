import 'package:flutter/material.dart';

import '../../router/router.dart';
import '../../shared/widgets/todo_subtitle.dart';
import '../../shared/widgets/todo_title.dart';
import '../../store/main/main.store.dart';
import '../delete_todos/delete_todos_page.dart';

class BatchDeleteTodos extends StatefulWidget {
  final List<DeleteTodo> deleteTodos;

  const BatchDeleteTodos({Key key, @required this.deleteTodos})
      : super(key: key);

  @override
  _BatchDeleteTodosState createState() => _BatchDeleteTodosState();
}

class _BatchDeleteTodosState extends State<BatchDeleteTodos> {
  List<DeleteTodo> get _selectTodods =>
      widget.deleteTodos.where((todo) => todo.value).toList();

  List<int> get _selectTododIds =>
      _selectTodods.map((dt) => dt.todo.id).toList();

  String get selectLenght => _selectTodods.length.toString();

  @override
  Widget build(BuildContext context) {
    var deleteTodos = widget.deleteTodos;
    return Scaffold(
      appBar: AppBar(
        title: Text(selectLenght),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              mainStore.todosService.deleteTodos(_selectTododIds);
              router.navigator.pop();
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: deleteTodos.length,
        itemBuilder: (context, index) {
          var dtodo = deleteTodos[index];
          return CheckboxListTile(
            value: dtodo.value,
            title: TodoTitle(todo: dtodo.todo),
            subtitle: TodoSubtitle(todo: dtodo.todo),
            onChanged: (bool value) {
              setState(() {
                dtodo.value = value;
              });
            },
          );
        },
      ),
    );
  }
}
