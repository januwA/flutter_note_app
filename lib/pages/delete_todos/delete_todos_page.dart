import 'package:flutter/material.dart';
import 'package:flutter_note_app/db/todo/todo.moor.dart';
import 'package:flutter_note_app/shared/widgets/app_drawer.dart';
import 'package:flutter_note_app/shared/widgets/todo_subtitle.dart';
import 'package:flutter_note_app/shared/widgets/todo_title.dart';
import 'package:flutter_note_app/store/main/main.store.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DeleteTodosPage extends StatefulWidget {
  static const routeName = '/DeleteTodosPage';
  @override
  _DeleteTodosPageState createState() => _DeleteTodosPageState();
}

class _DeleteTodosPageState extends State<DeleteTodosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('已删除事项'),
      ),
      drawer: AppDrawer(pageName: DeleteTodosPage.routeName),
      body: _initDataWidget(),
    );
  }

  Widget _initDataWidget() {
    return StreamBuilder(
      stream: mainStore.todosService.deleteTodos$,
      builder: (context, AsyncSnapshot<List<Todo>> snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snap.connectionState == ConnectionState.active) {
          List<Todo> todos = snap.data;
          if (todos == null || todos.isEmpty) {
            return Center(
              child: Text('not data.'),
            );
          }
          List<DeleteTodo> deleteTodos =
              todos.map((todo) => DeleteTodo(todo)).toList();
          return _buildDeleteTodosListView(deleteTodos);
        }
        return SizedBox();
      },
    );
  }

  ListView _buildDeleteTodosListView(List<DeleteTodo> deleteTodos) {
    return ListView.builder(
      itemCount: deleteTodos.length,
      itemBuilder: (context, index) {
        var dtodo = deleteTodos[index];
        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: ListTile(
            title: TodoTitle(todo: dtodo.todo),
            subtitle: TodoSubtitle(todo: dtodo.todo),
            onLongPress: () {
              setState(() {
                dtodo.value = true;
              });

              Navigator.of(context)
                  .pushNamed('/batch-delete-todos', arguments: deleteTodos);
            },
          ),
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: '恢复',
              color: Colors.green,
              icon: Icons.restore_from_trash,
              onTap: () => mainStore.todosService.unremoveTodo(dtodo.todo.id),
            ),
            IconSlideAction(
              caption: '移除',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () => mainStore.todosService.deleteTodo(dtodo.todo.id),
            ),
          ],
        );
      },
    );
  }
}

class DeleteTodo {
  bool value;
  final Todo todo;

  DeleteTodo(this.todo, [this.value = false]);
}
