import 'package:flutter/material.dart';
import 'package:flutter_note_app/db/todo/todo.moor.dart';
import 'package:flutter_note_app/store/main/main.store.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key key,
    @required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isTop = false;
  @override
  void initState() {
    super.initState();
    isTop = widget.todo.isTop;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: isTop
                ? Icon(
                    Icons.star,
                    color: Colors.red[400],
                  )
                : Icon(Icons.star_border),
            onPressed: () {
              mainStore.todosService.todosDB
                  .updateTask(widget.todo.copyWith(isTop: !widget.todo.isTop));
              setState(() {
                isTop = !isTop;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              mainStore.todosService.todosDB.deleteTask(widget.todo);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              widget.todo.title,
              style: Theme.of(context).textTheme.display1,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${widget.todo.createTime.toString().split('.').first}'),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      widget.todo.content,
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
