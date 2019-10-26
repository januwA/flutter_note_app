import 'package:flutter/material.dart';
import 'package:flutter_ajanuw_router/ajanuw_route.dart';
import 'package:flutter_ajanuw_router/flutter_ajanuw_router.dart';
import 'package:flutter_note_app/pages/add_page/add_page.dart';
import 'package:flutter_note_app/pages/batch_delete_todos/batch_delete_todos.dart';
import 'package:flutter_note_app/pages/delete_todos/delete_todos_page.dart';
import 'package:flutter_note_app/pages/detail_page/detail.page.dart';
import 'package:flutter_note_app/pages/not-found/not-found.dart';
import 'package:flutter_note_app/pages/todos_page/todos.page.dart';

AjanuwRouter router = AjanuwRouter();

final List<AjanuwRoute> routes = [
  AjanuwRoute(
    path: '',
    redirectTo: '/todos',
  ),
  AjanuwRoute(
    path: 'todos',
    builder: (context, r) => TodosPage(),
  ),
  AjanuwRoute(
    path: 'add-todo',
    builder: (context, r) => AddPage(),
  ),
  AjanuwRoute(
    path: 'detail-todo',
    builder: (context, r) => DetailPage(todo: r.arguments),
  ),
  AjanuwRoute(
    path: 'delete-todos',
    builder: (context, r) => DeleteTodosPage(),
  ),
  AjanuwRoute(
    path: 'batch-delete-todos',
    builder: (c, r) => BatchDeleteTodos(deleteTodos: r.arguments),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
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
