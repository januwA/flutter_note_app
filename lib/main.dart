import 'package:flutter/material.dart';
import 'package:flutter_note_app/router/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final onGenerateRoute = router.forRoot(routes);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '',
      title: '记事本',
      theme: ThemeData(primarySwatch: Colors.blue),
      navigatorObservers: [router.navigatorObserver],
      navigatorKey: router.navigatorKey,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
