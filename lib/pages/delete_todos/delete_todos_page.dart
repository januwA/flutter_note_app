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
        title: Text('已删除待办事项'),
      ),
      drawer: AppDrawer(pageName: DeleteTodosPage.routeName),
      body: StreamBuilder(
          stream: mainStore.todosService.deleteTodos$,
          builder: (context, AsyncSnapshot<List<Todo>> snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snap.connectionState == ConnectionState.active) {
              List<Todo> todos = snap.data;
              return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  var todo = todos[index];
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: ListTile(
                      title: TodoTitle(todo: todo),
                      subtitle: TodoSubtitle(todo: todo),
                    ),
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: '恢复',
                        color: Colors.green,
                        icon: Icons.restore_from_trash,
                        onTap: () => mainStore.todosService.unremoveTodo(todo),
                      ),
                      IconSlideAction(
                        caption: '移除',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () => mainStore.todosService.deleteTodo(todo),
                      ),
                    ],
                  );
                },
              );
            }

            return SizedBox();
          }),
    );
  }
}
