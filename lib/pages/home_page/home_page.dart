import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_note_app/models/todo/todo.dart';
import 'package:flutter_note_app/pages/home_page/home_store.dart';

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
                itemBuilder: (context, index) {
                  var todo = homeStore.todos[index];
                  return Observer(
                    builder: (_) {
                      return GestureDetector(
                        onLongPress: () => homeStore.setSelectAll(true),
                        child: Dismissible(
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
                          child: homeStore.isSelectAll
                              ? ListTile(
                                  leading: Checkbox(
                                    value: todo.isSelect,
                                    onChanged: (bool v) =>
                                        homeStore.select(todo, v),
                                  ),
                                  title: buildTodoTitle(todo, context),
                                  subtitle: buildTodoSubtitle(todo),
                                )
                              : ListTile(
                                  title: buildTodoTitle(todo, context),
                                  subtitle: buildTodoSubtitle(todo),
                                ),
                        ),
                      );
                    },
                  );
                },
                itemCount: homeStore.todos.length,
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

  Padding buildTodoSubtitle(Todo todo) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              todo.content,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          InkWell(
            onTap: () => homeStore.updateTop(todo),
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

  Row buildTodoTitle(Todo todo, BuildContext context) {
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

class DismissibleBackground extends StatelessWidget {
  const DismissibleBackground({
    Key key,
    @required this.padding,
    this.alignment = Alignment.center,
  }) : super(key: key);

  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: padding,
          child: Icon(Icons.delete_forever, color: Colors.white),
        ),
      ),
    );
  }
}

/// 添加待办事项page
class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加待办事项'),
        actions: <Widget>[
          FlatButton(
            child: Text('确定'),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Navigator.of(context).pop(
                  Todo(
                    title: _titleController.text.trim(),
                    content: _contentController.text.trim(),
                  ),
                );
                _titleController.clear();
                _contentController.clear();
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        autovalidate: true,
        onWillPop: () async {
          return true;
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "标题",
                ),
                validator: (String v) {
                  return (v.isEmpty) ? '请输入标题!' : null;
                },
              ),
              Flexible(
                fit: FlexFit.tight,
                child: TextFormField(
                  controller: _contentController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "内容",
                      contentPadding: EdgeInsets.only(top: 14.0)),
                  maxLines: null,
                  validator: (String v) {
                    return (v.isEmpty) ? '请输入内容!' : null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
