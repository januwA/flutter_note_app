import 'package:flutter/material.dart';
import 'package:flutter_note_app/db/todo/todo.moor.dart';
import 'package:flutter_note_app/router/router.dart';
import 'package:flutter_note_app/store/main/main.store.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key key,
    @required this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Todo>(
      stream: mainStore.todosService.watchTodo(id),
      initialData: null,
      builder: (context, snap) {
        switch (snap.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());

          case ConnectionState.active:
          case ConnectionState.done:
            return _buildBody(context, snap.data);

          default:
            return SizedBox();
        }
      },
    );
  }

  /// 顶置切换
  void _toggleSelect(Todo todo) {
    mainStore.todosService.updateTodo(todo.copyWith(isTop: !todo.isTop));
  }

  /// 删除todo
  void _del(int id) {
    mainStore.todosService.removeTodo(id);
    router.pop();
  }

  /// 二次编辑
  void _toEditPage(Todo todo) {
    router.pushNamed('/edit-todo', arguments: todo);
  }

  Widget _buildBody(BuildContext context, Todo todo) {
    var theme = Theme.of(context);
    bool isSelect = todo.isTop;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: isSelect
                ? Icon(Icons.star, color: Colors.red[400])
                : Icon(Icons.star_border),
            onPressed: () => _toggleSelect(todo),
          ),
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () => _del(todo.id),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _toEditPage(todo),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(todo.title, style: theme.textTheme.headline3),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${todo.createTime.toString().split('.').first}'),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      todo.content,
                      style: theme.textTheme.headline6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
