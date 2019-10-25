import 'package:flutter/material.dart';
import 'package:flutter_note_app/db/todo/todo.moor.dart';
import 'package:flutter_note_app/shared/widgets/app_drawer.dart';
import 'package:flutter_note_app/shared/widgets/todo_subtitle.dart';
import 'package:flutter_note_app/shared/widgets/todo_title.dart';
import 'package:flutter_note_app/store/main/main.store.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodosPage extends StatefulWidget {
  static const routeName = 'todos';
  @override
  _TodosPageState createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Todo>>(
      stream: mainStore.todosService.todos$,
      initialData: List<Todo>(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snap.connectionState == ConnectionState.active) {
          final List<Todo> todos = snap.data;
          return Scaffold(
            appBar: AppBar(
              title: Text('待办事项 #${todos.length}'),
            ),
            drawer: AppDrawer(
              pageName: TodosPage.routeName,
            ),
            body: todos.isEmpty
                ? Center(child: Text('Not Todos.'))
                : ReorderableListView(
                    onReorder: (int oldIndex, int newIndex) {
                      bool isLast = false;
                      if (newIndex >= todos.length) {
                        newIndex = todos.length - 1;
                        isLast = true;
                      }
                      Todo oldTodo = todos[oldIndex];
                      Todo newTodo = todos[newIndex];
                      mainStore.todosService
                          .updateSort(oldTodo, newTodo, isLast);
                    },
                    children:
                        todos.map((t) => _todoItemView(t, context)).toList(),
                  ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.of(context).pushNamed('/add-todo'),
              child: Icon(Icons.add),
            ),
          );
        }
        return Scaffold(body: SizedBox());
      },
    );
  }

  Slidable _todoItemView(Todo todo, BuildContext context) {
    return Slidable(
      key: ValueKey(todo.id),
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: '删除',
          color: Colors.red,
          icon: Icons.delete_forever,
          onTap: () => mainStore.todosService.removeTodo(todo),
        ),
      ],
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed('/detail-todo', arguments: todo);
        },
        title: TodoTitle(todo: todo),
        subtitle: TodoSubtitle(todo: todo),
      ),
    );
  }
}
