import 'package:flutter/material.dart';
import 'package:flutter_note_app/models/todo/todo.dart';

class TodoSubtitle extends StatelessWidget {
  TodoSubtitle({
    @required this.todo,
    @required this.onTop,
  });
  final Todo todo;
  final Function onTop;
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
            onTap: () => onTop(todo),
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
