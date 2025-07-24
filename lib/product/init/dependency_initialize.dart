import 'package:flutter_todo_app/feature/todo/view_model/todo_bloc.dart';
import 'package:flutter_todo_app/product/cache/todo_cache_manager.dart';
import 'package:flutter_todo_app/product/service/todo_service.dart';
import 'package:get_it/get_it.dart';

/// Sets up dependency injection for the app using GetIt.
class DependencyInitialize {
  /// Sets up all dependencies using GetIt service locator.
  static Future<void> setup() async {
    // Register cache manager
    GetIt.instance.registerLazySingleton<TodoCacheManager>(
      TodoCacheManager.new,
    );

    // Register service
    GetIt.instance.registerLazySingleton<TodoService>(
      () => TodoService(GetIt.instance<TodoCacheManager>()),
    );

    // Register BLoC
    GetIt.instance.registerFactory<TodoBloc>(
      () => TodoBloc(GetIt.instance<TodoService>()),
    );
  }
}
