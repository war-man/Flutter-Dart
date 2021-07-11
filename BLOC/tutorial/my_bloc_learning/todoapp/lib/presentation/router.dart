import 'package:flutter/material.dart';
import 'package:todoapp/presentation/screens/add_todo_screen.dart';
import 'package:todoapp/presentation/screens/edit_todo_screen.dart';
import 'package:todoapp/presentation/screens/todos_screen.dart';

class AppRouter {
  Route? generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => TodoScreen());
      case "/add_todo":
        return MaterialPageRoute(builder: (_) => AddTodoScreen());
      case "/edit_todo":
        return MaterialPageRoute(builder: (_) => EditTodoScreen());
      default:
        return null;
    }
  }
}
