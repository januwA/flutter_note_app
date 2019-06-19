import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_note_app/pages/home_page/home_store.dart';
import 'package:flutter_note_app/shared/widgets/dismissible_background.dart';
import 'package:flutter_note_app/shared/widgets/todo_subtitle.dart';
import 'package:flutter_note_app/shared/widgets/todo_title.dart';

/// 批量删除页面
class DeletePage extends StatelessWidget {
  const DeletePage({
    Key key,
    @required this.homeStore,
  }) : super(key: key);

  final HomeStore homeStore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: homeStore.clearSelect,
          ),
        ],
      ),
      body: Observer(
        builder: (_) => ListView.builder(
              itemCount: homeStore.todos.length,
              itemBuilder: (context, index) {
                var todo = homeStore.todos[index];
                return Hero(
                  tag: todo,
                  child: Material(
                    child: Observer(
                      builder: (_) => Dismissible(
                            key: ValueKey(todo),
                            onDismissed: (DismissDirection direction) =>
                                homeStore.remove(todo),
                            background: DismissibleBackground(
                              padding: EdgeInsets.only(left: 14),
                              alignment: Alignment.centerLeft,
                            ),
                            secondaryBackground: DismissibleBackground(
                              padding: EdgeInsets.only(right: 14),
                              alignment: Alignment.centerRight,
                            ),
                            child: ListTile(
                              onTap: () =>
                                  homeStore.select(todo, !todo.isSelect),
                              leading: Checkbox(
                                value: todo.isSelect,
                                onChanged: (bool v) =>
                                    homeStore.select(todo, v),
                              ),
                              title: TodoTitle(todo: todo),
                              subtitle: TodoSubtitle(
                                todo: todo,
                                onTop: homeStore.updateTop,
                              ),
                            ),
                          ),
                    ),
                  ),
                );
              },
            ),
      ),
    );
  }
}
