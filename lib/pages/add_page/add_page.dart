
import 'package:flutter/material.dart';
import 'package:flutter_note_app/models/todo/todo.dart';

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