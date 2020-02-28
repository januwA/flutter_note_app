import 'package:flutter/material.dart';
import 'package:flutter_note_app/db/todo/todo.moor.dart';

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
          _createTimeString(todo.createTime),
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }

  String _createTimeString(DateTime createTime) {
    var now = new DateTime.now();
    // 一天前
    var oneDayAgo = now.subtract(const Duration(days: 1));
    // 一年前
    var aYearAgo = now.subtract(const Duration(days: 365));
    bool isOneDayAgo = createTime.isBefore(oneDayAgo);
    bool isAYearAgo = createTime.isBefore(aYearAgo);
    if (isAYearAgo) {
      return '${createTime.year}年${createTime.month}月';
    } else if (isOneDayAgo) {
      return '${createTime.month}月${createTime.day}号';
    } else {
      String hour = createTime.hour.toString();
      hour = hour.length == 2 ? hour : '0' + hour;
      String minute = createTime.minute.toString();
      minute = minute.length == 2 ? minute : '0' + minute;
      return '$hour:$minute';
    }
  }
}
