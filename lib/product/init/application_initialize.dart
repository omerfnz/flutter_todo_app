import 'package:flutter/widgets.dart';
import 'package:flutter_todo_app/feature/todo/model/todo_model.dart';
import 'package:flutter_todo_app/product/init/dependency_initialize.dart';
import 'package:flutter_todo_app/product/init/localization_initialize.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Handles application-wide initialization: localization, Hive, DI, adapters.
class ApplicationInitialize {
  /// Initializes the application with required dependencies and configurations.
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await LocalizationInitialize.init();
    await Hive.initFlutter();

    // Migration completed - box cleanup no longer needed

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TodoModelAdapter());
    }
    await DependencyInitialize.setup();
  }
}
