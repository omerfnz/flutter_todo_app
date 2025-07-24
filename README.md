# Görev Yöneticisi (Task Manager)

A modern, minimalist Flutter Todo application following strict clean architecture principles. The app is dark-mode only, supports Turkish and English, and is designed for maintainability, testability, and scalability.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Material Design](https://img.shields.io/badge/Material%20Design-757575?style=for-the-badge&logo=material-design&logoColor=white)

## ✨ Features

### Core Functionality

- ✅ **Task Management**: Complete CRUD operations for todo items
- ✅ **Persistent Storage**: Local data storage with Hive database
- ✅ **Real-time Updates**: Instant UI updates with BLoC state management
- ✅ **Swipe to Delete**: Intuitive gesture-based task deletion
- ✅ **Task Completion**: Toggle task completion with visual feedback

### Technical Features

- 🏗️ **Clean Architecture**: Layered architecture with clear separation of concerns
- 🔄 **BLoC Pattern**: Reactive state management with flutter_bloc
- 💉 **Dependency Injection**: Service locator pattern with GetIt
- 🌐 **Internationalization**: Turkish and English language support
- 🎨 **Material 3 Design**: Modern dark theme with consistent styling
- 📱 **Responsive UI**: Optimized for different screen sizes
- 🔧 **Code Generation**: Automated code generation for models and serialization

## 🏛️ Architecture

The application follows a layered clean architecture pattern:

```
┌─────────────────────────────────────┐
│           Presentation Layer        │
│  (Views, Widgets, BLoC Consumers)   │
├─────────────────────────────────────┤
│          Business Logic Layer       │
│     (BLoC, Events, States)          │
├─────────────────────────────────────┤
│            Service Layer            │
│    (TodoService, Cache Manager)     │
├─────────────────────────────────────┤
│            Data Layer               │
│      (Models, Hive Storage)         │
└─────────────────────────────────────┘
```

## 📁 Project Structure

```
lib/
├── core/                           # Core utilities and shared components
│   ├── constants/                  # Application constants
│   │   ├── app_constants.dart      # App-wide constants
│   │   └── cache_constants.dart    # Cache and storage constants
│   └── extensions/                 # Dart extensions
│       └── build_context_extension.dart  # Context extensions for localization
├── feature/                        # Feature modules
│   └── todo/                       # Todo feature module
│       ├── view/                   # UI components
│       │   ├── todo_list_view.dart # Main todo list screen
│       │   └── widgets/            # Feature-specific widgets
│       │       ├── todo_list_item_card.dart  # Individual todo item
│       │       └── add_todo_dialog.dart      # Add todo modal
│       ├── view_model/             # Business logic (BLoC)
│       │   ├── todo_bloc.dart      # Main BLoC class
│       │   ├── todo_event.dart     # BLoC events
│       │   └── todo_state.dart     # BLoC states
│       └── model/                  # Data models
│           └── todo_model.dart     # Todo data model with Hive/JSON support
├── product/                        # Product-level shared components
│   ├── init/                       # Initialization classes
│   │   ├── application_initialize.dart    # App initialization
│   │   ├── dependency_initialize.dart     # Dependency injection setup
│   │   ├── localization_initialize.dart   # Localization setup
│   │   └── theme_initialize.dart          # Theme configuration
│   ├── service/                    # Business services
│   │   └── todo_service.dart       # Todo business logic
│   ├── cache/                      # Data persistence
│   │   └── todo_cache_manager.dart # Hive storage manager
│   └── widget/                     # Reusable UI components
│       └── common_elevated_button.dart    # Common button component
└── main.dart                       # Application entry point

assets/
└── translations/                   # Localization files
    ├── en-US.json                  # English translations
    └── tr-TR.json                  # Turkish translations
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.4.0)
- Dart SDK (>=3.4.0)
- Git

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/omerfnz/flutter_todo_app.git
   cd flutter_todo_app
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Generate code (if needed):**

   ```bash
   dart run build_runner build
   ```

4. **Run the application:**
   ```bash
   flutter run
   ```

### Available Platforms

- ✅ **Windows** (Primary target)
- ✅ **Android**
- ✅ **iOS**
- ✅ **Web**
- ✅ **macOS**
- ✅ **Linux**

## 🛠️ Tech Stack

### Core Dependencies

- **flutter_bloc** (^8.1.6) - State management
- **get_it** (^7.7.0) - Dependency injection
- **hive** (^2.2.3) & **hive_flutter** (^1.1.0) - Local database
- **easy_localization** (^3.0.7) - Internationalization
- **equatable** (^2.0.5) - Value equality
- **uuid** (^4.5.1) - Unique ID generation

### Development Dependencies

- **build_runner** (^2.4.6) - Code generation
- **hive_generator** (^2.0.1) - Hive type adapters
- **json_serializable** (^6.7.1) - JSON serialization
- **very_good_analysis** (^6.0.0) - Linting rules
- **bloc_test** (^9.1.7) - BLoC testing utilities
- **mockito** (^5.4.4) - Mocking framework

## 🎨 Design System

### Theme

- **Design Language**: Material 3
- **Color Scheme**: Dark mode only with deep purple accent
- **Typography**: Material 3 typography scale
- **Components**: Consistent Material 3 components

### UI Components

- **Cards**: Elevated cards with rounded corners
- **Buttons**: Material 3 elevated buttons with loading states
- **Dialogs**: Modal dialogs with consistent styling
- **Lists**: Efficient ListView.builder implementation

## 🌍 Localization

The app supports multiple languages:

- 🇹🇷 **Turkish (tr-TR)** - Primary language
- 🇺🇸 **English (en-US)** - Fallback language

### Adding New Languages

1. Create a new JSON file in `assets/translations/`
2. Add the locale to `LocalizationInitialize.supportedLocales`
3. Update `pubspec.yaml` if needed

## 🧪 Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/unit/todo_bloc_test.dart
```

### Test Structure

- **Unit Tests**: Business logic and data layer testing
- **Widget Tests**: UI component testing
- **Integration Tests**: End-to-end user flow testing

## 📊 Code Quality

### Linting

The project follows [very_good_analysis](https://pub.dev/packages/very_good_analysis) rules:

```bash
# Run static analysis
flutter analyze

# Check formatting
dart format --set-exit-if-changed .
```

### Code Standards

- ✅ All public APIs are documented
- ✅ Consistent naming conventions
- ✅ Proper error handling
- ✅ Immutable state classes
- ✅ Dependency injection
- ✅ Clean architecture principles

## 🔧 Development

### Code Generation

```bash
# Generate all files
dart run build_runner build

# Watch for changes
dart run build_runner watch

# Clean and rebuild
dart run build_runner build --delete-conflicting-outputs
```

### Adding New Features

1. Create feature module in `lib/feature/`
2. Implement data models with Hive/JSON annotations
3. Create BLoC for state management
4. Build UI components
5. Add to dependency injection
6. Write tests

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Contribution Guidelines

- Follow the existing code style
- Add tests for new features
- Update documentation
- Ensure all tests pass
- Follow clean architecture principles

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Ömer Faruk Naz**

- GitHub: [@omerfnz](https://github.com/omerfnz)
- Project Link: [https://github.com/omerfnz/flutter_todo_app](https://github.com/omerfnz/flutter_todo_app)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design team for the design system
- Open source community for the excellent packages

---

⭐ **Star this repository if you found it helpful!**
