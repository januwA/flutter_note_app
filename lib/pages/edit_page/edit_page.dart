import 'package:flutter/material.dart';
import 'package:flutter_note_app/db/todo/todo.moor.dart';
import 'package:flutter_note_app/router/router.dart';
import 'package:flutter_note_app/store/main/main.store.dart';

/// 添加待办事项，或则编辑待办事项
class EditPage extends StatefulWidget {
  final Todo todo;

  const EditPage({Key key, this.todo}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController(text: "");
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool get isEdit => widget.todo != null;
  String get title => _titleController.text.trim();
  String get content => _contentController.text.trim();

  @override
  void initState() {
    super.initState();
    if (isEdit) {
      _titleController.text = widget.todo.title;
      _contentController.text = widget.todo.content;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
  }

  /// 编辑：更新todo
  void _edit() {
    mainStore.todosService.updateTodo(widget.todo.copyWith(
      title: title,
      content: content,
    ));
  }

  /// 新增：添加todo
  void _add() {
    var newTodo = TodosCompanion.insert(
      title: title,
      content: content,
      createTime: DateTime.now(),
    );
    mainStore.todosService.insertTodo(newTodo);
  }

  /// 清理input内容
  _clean() {
    _titleController.clear();
    _contentController.clear();
  }

  _publish() {
    if (_formKey.currentState.validate()) {
      if (isEdit) {
        _edit();
      } else {
        _add();
      }
      router.pop();
      _clean();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加待办事项'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.send), onPressed: _publish),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
