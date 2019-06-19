import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_note_app/models/todo/todo.dart';
import 'package:flutter_note_app/pages/add_page/add_page.dart';
import 'package:flutter_note_app/pages/delete_page/delete_page.dart';
import 'package:flutter_note_app/pages/home_page/home_store.dart';
import 'package:flutter_note_app/shared/widgets/dismissible_background.dart';
import 'package:flutter_note_app/shared/widgets/todo_subtitle.dart';
import 'package:flutter_note_app/shared/widgets/todo_title.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var homeStore = HomeStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes List'),
      ),
      body: Observer(
        builder: (_) => homeStore.todos.isEmpty
            ? Center(
                child: Text('暂无待办事项.'),
              )
            : ListView.builder(
                itemCount: homeStore.todos.length,
                itemBuilder: (context, index) {
                  var todo = homeStore.todos[index];
                  return Hero(
                    tag: todo,
                    child: Material(
                      child: Observer(
                        builder: (_) {
                          return Dismissible(
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
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return DetailPage(
                                          homeStore: homeStore, todo: todo);
                                    },
                                  ),
                                );
                              },
                              onLongPress: () => onTodoLongPress(todo),
                              title: TodoTitle(todo: todo),
                              subtitle: TodoSubtitle(
                                todo: todo,
                                onTop: homeStore.updateTop,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context)
              .push<Todo>(MaterialPageRoute(builder: (context) => AddPage()));
          if (result == null) return false;
          homeStore.oneAdd(result);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  /// 长按时
  onTodoLongPress(Todo todo) {
    homeStore.initSelect();
    homeStore.select(todo, true);
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 400),
        pageBuilder: (
          BuildContext context,
          Animation animation,
          Animation secondaryAnimation,
        ) {
          /// 淡入
          return FadeTransition(
            opacity: animation,
            child: DeletePage(homeStore: homeStore),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key key,
    @required this.homeStore,
    @required this.todo,
  }) : super(key: key);

  final HomeStore homeStore;
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Observer(
            builder: (_) => IconButton(
                  icon: todo.isTop
                      ? Icon(
                          Icons.star,
                          color: Colors.red[400],
                        )
                      : Icon(Icons.star_border),
                  onPressed: () => homeStore.updateTop(todo),
                ),
          ),
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              homeStore.remove(todo);
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
