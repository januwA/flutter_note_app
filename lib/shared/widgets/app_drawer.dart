import 'package:flutter/material.dart';
import 'package:flutter_note_app/db/todo/todo.moor.dart';
import 'package:flutter_note_app/pages/delete_todos/delete_todos_page.dart';
import 'package:flutter_note_app/pages/todos_page/todos.page.dart';
import 'package:flutter_note_app/store/main/main.store.dart';

class AppDrawer extends StatefulWidget {
  final String pageName;

  const AppDrawer({Key key, @required this.pageName}) : super(key: key);
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var grs = mainStore.verSionService.grs;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '记事本',
              style: Theme.of(context).textTheme.title.copyWith(
                    color: Theme.of(context).accentColor,
                  ),
            ),
          ),
          Divider(),
          ListTile(
            title: Text('所有标签'),
          ),
          StreamBuilder(
            stream: mainStore.todosService.todos$,
            builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                List<Todo> dts = snapshot.data;
                return ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    if (widget.pageName != TodosPage.routeName) {
                      /// 清理所有旧路由，并跳转到新路由
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => TodosPage()),
                        (Route<dynamic> route) => false,
                      );
                    }
                  },
                  leading: Icon(Icons.power),
                  title: Text('主要'),
                  trailing: Text('${dts.length}'),
                );
              }

              return SizedBox();
            },
          ),
          StreamBuilder(
            stream: mainStore.todosService.deleteTodos$,
            builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                List<Todo> dts = snapshot.data;
                return ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    if (widget.pageName != DeleteTodosPage.routeName) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => DeleteTodosPage(),
                      ));
                    }
                  },
                  leading: Icon(Icons.delete),
                  title: Text('已删除待办事项'),
                  trailing: Text('${dts.length}'),
                );
              }

              return SizedBox();
            },
          ),
          FutureBuilder(
            future: grs.isNeedUpdate,
            builder: (context, AsyncSnapshot<bool> snap) {
              if (snap.connectionState == ConnectionState.done) {
                bool isNeedUpdate = snap.data;
                var asset = grs.latestSync.assets.first;
                return ListTile(
                  leading: Icon(Icons.update),
                  title: Text(isNeedUpdate ? '检查更新' : '暂无更新'),
                  onTap: () => isNeedUpdate
                      ? grs.downloadApk(
                          downloadUrl: asset.browserDownloadUrl,
                          apkName: asset.name,
                        )
                      : null,
                );
              }
              return SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
