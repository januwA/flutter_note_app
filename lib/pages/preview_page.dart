import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PreviewPage extends StatefulWidget {
  static const routeName = '/PreviewPage';
  final String text;

  const PreviewPage({Key key, @required this.text}) : super(key: key);
  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('预览'),
      ),
      body: Markdown(data: widget.text),
    );
  }
}
