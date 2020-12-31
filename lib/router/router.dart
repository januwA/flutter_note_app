import 'package:flutter/material.dart';
import 'package:flutter_ajanuw_router/ajanuw_route.dart';
import 'package:flutter_ajanuw_router/flutter_ajanuw_router.dart';
import 'package:flutter_note_app/pages/batch_delete_todos/batch_delete_todos.dart';
import 'package:flutter_note_app/pages/delete_todos/delete_todos_page.dart';
import 'package:flutter_note_app/pages/detail_page/detail.page.dart';
import 'package:flutter_note_app/pages/edit_page/edit_page.dart';
import 'package:flutter_note_app/pages/not-found/not-found.dart';
import 'package:flutter_note_app/pages/preview_page.dart';
import 'package:flutter_note_app/pages/todos_page/todos.page.dart';

import '../db/todo/todo.moor.dart';

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
  AjanuwRoute<Todo>(
    path: 'edit-todo',
    builder: (context, r) => EditPage(todo: r.arguments),
    transitionDuration: Duration(milliseconds: 500),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      );

      return SlideTransition(
        position: Tween(
          begin: Offset(0.0, 0.7),
          end: Offset.zero,
        ).animate(curvedAnimation),
        child: ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(curvedAnimation),
          child: child,
        ),
      );
    },
  ),
  AjanuwRoute<int>(
    path: 'detail-todo',
    builder: (context, r) => DetailPage(id: r.arguments),
  ),
  AjanuwRoute(
    path: 'delete-todos',
    builder: (context, r) => DeleteTodosPage(),
  ),
  AjanuwRoute(
    path: 'preview',
    builder: (context, r) => PreviewPage(text: r.arguments),
  ),
  AjanuwRoute<List<DeleteTodo>>(
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
