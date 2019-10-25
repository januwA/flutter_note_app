import 'package:flutter_ajanuw_router/ajanuw_route.dart';
import 'package:flutter_ajanuw_router/flutter_ajanuw_router.dart';
import 'package:flutter_note_app/pages/not-found/not-found.dart';
import 'package:flutter_note_app/pages/todos_page/todos.page.dart';

AjanuwRouter router = AjanuwRouter();

final List<AjanuwRoute> routes = [
  AjanuwRoute(
    path: '',
    redirectTo: '/home',
  ),
  AjanuwRoute(
    path: 'home',
    builder: (context, r) => TodosPage(),
  ),
  AjanuwRoute(
    path: 'not-found',
    builder: (context, r) => NotFound(),
  ),
  AjanuwRoute(
    path: "**",
    redirectTo: '/not-found',
  ),
];
