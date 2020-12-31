import 'package:flutter/material.dart';
import 'package:flutter_note_app/db/todo/todo.moor.dart';
import 'package:flutter_note_app/router/router.dart';
import 'package:flutter_note_app/store/main/main.store.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../router/router.dart';

/// 添加待办事项，或则编辑待办事项
class EditPage extends StatefulWidget {
  final Todo todo;

  const EditPage({Key key, this.todo}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
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

  /// 向context编辑器中新添加一行
  void _addLine(String text) {
    _contentController.text += '\n$text';
    // 更新光标位置
    _contentController.selection = TextSelection.fromPosition(
        TextPosition(offset: _contentController.text.length));
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

  /// 发布这条备注
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

  /// 预览markdown
  _preview() {
    router.pushNamed('/preview', arguments: _contentController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? '编辑' : '添加'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.preview),
            onPressed: _preview,
            tooltip: '预览',
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _publish,
            tooltip: '保存',
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
              Wrap(
                children: [
                  MarkdownIconButton(
                    icon: 'bold',
                    onPressed: () {
                      _addLine('**text**');
                    },
                  ),
                  MarkdownIconButton(
                    icon: 'italic',
                    onPressed: () {
                      _addLine('*text*');
                    },
                  ),
                  MarkdownIconButton(
                    icon: 'strikethrough',
                    onPressed: () {
                      _addLine('~~text~~');
                    },
                  ),
                  MarkdownIconButton(
                    icon: 'underline',
                    onPressed: () {
                      _addLine('++text++');
                    },
                  ),
                  MarkdownIconButton(
                    icon: 'pencil',
                    onPressed: () {
                      _addLine('==text==');
                    },
                  ),
                  MarkdownIconButton(
                    icon: 'heading1',
                    onPressed: () {
                      _addLine('# text');
                    },
                  ),
                  MarkdownIconButton(
                    icon: 'heading2',
                    onPressed: () {
                      _addLine('## text');
                    },
                  ),
                  MarkdownIconButton(
                    icon: 'heading3',
                    onPressed: () {
                      _addLine('### text');
                    },
                  ),
                  MarkdownIconButton(
                    icon: 'heading4',
                    onPressed: () {
                      _addLine('#### text');
                    },
                  ),
                  MarkdownIconButton(
                    icon: 'heading5',
                    onPressed: () {
                      _addLine('##### text');
                    },
                  ),
                  MarkdownIconButton(
                    icon: 'heading6',
                    onPressed: () {
                      _addLine('###### text');
                    },
                  ),
                  MarkdownIconButton(
                    icon: 'hr',
                    onPressed: () {
                      _addLine('\n---\n');
                    },
                  ),
                  MarkdownIconButton(
                    icon: 'quote',
                    onPressed: () {
                      _addLine('> text');
                    },
                  ),
                  MarkdownIconButton(
                    icon: 'ul',
                    onPressed: () {
                      _addLine('- text');
                    },
                  ),
                  MarkdownIconButton(
                    icon: 'ol',
                    onPressed: () {
                      _addLine('1. text');
                    },
                  ),
                  MarkdownIconButton(
                    icon: 'unchecked',
                    onPressed: () {
                      _addLine('- [ ] text');
                    },
                  ),
                  MarkdownIconButton(
                    icon: 'checked',
                    onPressed: () {
                      _addLine('- [x] text');
                    },
                  ),
                  MarkdownIconButton(
                    icon: 'html',
                    onPressed: () {
                      _addLine('\n<html><!--在这里插入内容--></html>\n');
                    },
                  ),
                  MarkdownIconButton(
                    icon: 'link',
                    onPressed: () {
                      _addLine(
                          '[link](https://github.com/januwA/flutter_note_app)');
                    },
                  ),
                  MarkdownIconButton(
                    icon: 'image',
                    onPressed: () {
                      _addLine(
                          '![image](https://i.loli.net/2020/10/14/gQq96O4DxRVXSKP.jpg)');
                    },
                  ),
                  MarkdownIconButton(
                    icon: 'code',
                    onPressed: () {
                      _addLine('\n```\n\n```\n');
                    },
                  ),
                  MarkdownIconButton(
                    icon: 'table',
                    onPressed: () {
                      _addLine('''
header 1 | header 2
---|---
row 1 col 1 | row 1 col 2
row 2 col 1 | row 2 col 2
''');
                    },
                  ),
                  MarkdownIconButton(
                    icon: 'formula',
                    onPressed: () {
                      _addLine('''
```math
E = mc^2
```
''');
                    },
                  ),
                  MarkdownIconButton(
                    icon: 'flow',
                    onPressed: () {},
                  ),
                  MarkdownIconButton(
                    icon: 'seq',
                    onPressed: () {
                      _addLine('''
```
graph LR
A-->B
```
''');
                    },
                  ),
                  MarkdownIconButton(
                    icon: 'gantt',
                    onPressed: () {
                      _addLine('''
```
gantt
dateFormat YYYY-MM-DD
section S1
T1: 2014-01-01, 9d
section S2
T2: 2014-01-11, 9d
section S3
T3: 2014-01-02, 9d
```
''');
                    },
                  ),
                ],
              ),
              Divider(),
              Flexible(
                fit: FlexFit.tight,
                child: TextFormField(
                  controller: _contentController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  textInputAction: TextInputAction.unspecified, // 能够换行
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "内容",
                      contentPadding: EdgeInsets.only(top: 14.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MarkdownIconButton extends StatelessWidget {
  final String icon;
  final void Function() onPressed;

  const MarkdownIconButton({
    Key key,
    @required this.icon,
    @required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset('assets/markdown_icons/${icon}_hover.svg'),
      ),
      onTap: onPressed,
    );
  }
}
