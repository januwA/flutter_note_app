import 'package:flutter/material.dart';
import 'package:flutter_note_app/db/todo/todo.moor.dart';
import 'package:flutter_note_app/store/main/main.store.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key key,
    @required this.todo,
  }) : super(key: key);

  final Todo todo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          StreamBuilder<Todo>(
              stream: mainStore.todosService.watchTodo(todo),
              initialData: null,
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.active &&
                    snap.hasData) {
                  return IconButton(
                    icon: snap.data.isTop
                        ? Icon(
                            Icons.star,
                            color: Colors.red[400],
                          )
                        : Icon(Icons.star_border),
                    onPressed: () {
                      mainStore.todosService
                          .updateTodo(todo.copyWith(isTop: !snap.data.isTop));
                    },
                  );
                } else {
                  return SizedBox();
                }
              }),
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              mainStore.todosService.deleteTodo(todo);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              todo.title,
              style: Theme.of(context).textTheme.display1,
            ),
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
                      style: Theme.of(context).textTheme.title,
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
