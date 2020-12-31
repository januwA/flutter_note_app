import 'package:flutter/material.dart';
import 'package:flutter_note_app/db/todo/todo.moor.dart';
import 'package:flutter_note_app/router/router.dart';
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
        switch (snap.connectionState) {
          case ConnectionState.waiting:
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          case ConnectionState.active:
            return _buildBody(snap.data ?? []);
          default:
            return Scaffold(body: SizedBox());
        }
      },
    );
  }

  Widget _buildNotTodo() {
    var style = TextStyle(fontSize: 16, color: Colors.grey[600]);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              'assets/note.png',
              width: 120,
              height: 120,
            ),
          ),
          SizedBox(height: 6),
          Text('点击右下方的按钮', style: style),
          SizedBox(height: 2),
          Text('以创建备注', style: style),
        ],
      ),
    );
  }

  _buildBody(List<Todo> todos) {
    return Scaffold(
      appBar: AppBar(
        title: Text('备注列表 #${todos.length}'),
      ),
      drawer: AppDrawer(
        pageName: TodosPage.routeName,
      ),
      body: todos.isEmpty
          ? _buildNotTodo()
          : ReorderableListView(
              onReorder: (int oldIndex, int newIndex) {
                bool isLast = false;
                if (newIndex >= todos.length) {
                  newIndex = todos.length - 1;
                  isLast = true;
                }
                Todo oldTodo = todos[oldIndex];
                Todo newTodo = todos[newIndex];
                mainStore.todosService.updateSort(oldTodo, newTodo, isLast);
              },
              children: todos.map((t) => _todoItemView(t, context)).toList(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/edit-todo'),
        child: Icon(Icons.add),
      ),
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
          onTap: () => mainStore.todosService.removeTodo(todo.id),
        ),
      ],
      child: ListTile(
        onTap: () => router.pushNamed('/detail-todo', arguments: todo.id),
        title: TodoTitle(todo: todo),
        subtitle: TodoSubtitle(todo: todo),
      ),
    );
  }
}
