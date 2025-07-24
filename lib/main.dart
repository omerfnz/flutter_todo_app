import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/feature/todo/view/todo_list_view.dart';
import 'package:flutter_todo_app/feature/todo/view_model/todo_bloc.dart';
import 'package:flutter_todo_app/feature/todo/view_model/todo_event.dart';
import 'package:flutter_todo_app/product/init/application_initialize.dart';
import 'package:flutter_todo_app/product/init/localization_initialize.dart';
import 'package:flutter_todo_app/product/init/theme_initialize.dart';
import 'package:get_it/get_it.dart';

void main() async {
  await ApplicationInitialize.init();
  runApp(
    EasyLocalization(
      supportedLocales: LocalizationInitialize.supportedLocales,
      path: LocalizationInitialize.translationsPath,
      fallbackLocale: LocalizationInitialize.fallbackLocale,
      child: const MyApp(),
    ),
  );
}

/// Main application widget that sets up routing, theming, and localization.
class MyApp extends StatelessWidget {
  /// Creates a [MyApp] widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      create: (_) => GetIt.I<TodoBloc>()..add(const LoadTodos()),
      child: MaterialApp(
        title: 'Task Manager',
        theme: ThemeInitialize.darkTheme,
        home: const TodoListView(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
