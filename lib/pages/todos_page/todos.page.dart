import 'package:flutter/material.dart';
import 'package:flutter_note_app/db/todo/todo.moor.dart';
import 'package:flutter_note_app/pages/add_page/add_page.dart';
import 'package:flutter_note_app/pages/detail_page/detail.page.dart';
import 'package:flutter_note_app/shared/widgets/dismissible_background.dart';
import 'package:flutter_note_app/shared/widgets/todo_subtitle.dart';
import 'package:flutter_note_app/shared/widgets/todo_title.dart';
import 'package:flutter_note_app/store/main/main.store.dart';

class TodosPage extends StatefulWidget {
  @override
  _TodosPageState createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Todo>>(
        stream: mainStore.todosService.todos$,
        initialData: List<Todo>(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.active) {
            final List<Todo> todos = snap.data;
            return Scaffold(
              appBar: AppBar(
                title: Text('待办事项 #${todos.length}'),
              ),
              body: todos.isEmpty
                  ? Center(
                      child: Text('Not Todos.'),
                    )
                  : ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        var todo = todos[index];
                        return Hero(
                          tag: todo,
                          child: Material(
                            child: Dismissible(
                              key: ValueKey(todo),
                              onDismissed: (DismissDirection direction) =>
                                  mainStore.todosService.todosDB
                                      .deleteTodo(todo),
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
                                        return DetailPage(todo: todo);
                                      },
                                    ),
                                  );
                                },
                                title: TodoTitle(todo: todo),
                                subtitle: TodoSubtitle(todo: todo),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push<Todo>(
                      MaterialPageRoute(builder: (context) => AddPage()));
                },
                child: Icon(Icons.add),
              ),
            );
          } else if (snap.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SizedBox();
          }
        });
  }
}