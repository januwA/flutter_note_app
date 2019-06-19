
import 'package:flutter/material.dart';
import 'package:flutter_note_app/models/todo/todo.dart';

class TodoTitle extends StatelessWidget {
  TodoTitle({
    @required this.todo,
  });

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          fit: FlexFit.tight,
          child: Text(
            todo.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        Text(
          todo.createTimeString,
          style: Theme.of(context).textTheme.subhead,
        ),
      ],
    );
  }
}