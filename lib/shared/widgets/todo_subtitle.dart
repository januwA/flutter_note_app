import 'package:flutter/material.dart';
import 'package:flutter_note_app/db/todo/todo.moor.dart';
import 'package:flutter_note_app/store/main/main.store.dart';

class TodoSubtitle extends StatelessWidget {
  TodoSubtitle({
    @required this.todo,
  });
  final Todo todo;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              todo.content,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          InkWell(
            onTap: () {
              mainStore.todosService.todosDB
                  .updateTodo(todo.copyWith(isTop: !todo.isTop));
            },
            child: todo.isTop
                ? Icon(
                    Icons.star,
                    color: Colors.red[400],
                  )
                : Icon(
                    Icons.star_border,
                    color: Colors.grey[400],
                  ),
          ),
        ],
      ),
    );
  }
}
