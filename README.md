# Flutter iOS Native Bridge

Простое iOS-приложение на Flutter, демонстрирующее взаимодействие между Flutter, Swift и C++ через MethodChannel.

## Описание

Приложение реализует следующую цепочку взаимодействия:
1. **Flutter UI** - интерфейс с кнопкой и областью вывода текста
2. **MethodChannel** - связь между Flutter и нативным iOS кодом
3. **Swift** - обработка запросов от Flutter
4. **C++ библиотека** - запись данных в файл
5. **Обратная связь** - отображение обновлённого содержимого файла в UI

## Функциональность

- Увеличение счётчика при каждом нажатии кнопки
- Запись строки "hello world N" в текстовый файл через C++ библиотеку
- Отображение содержимого файла в реальном времени
- Управление состоянием через BLoC архитектуру
- Обработка ошибок и состояний загрузки

## Архитектура

Проект использует чистую архитектуру с разделением на слои:

```
lib/
├── main.dart              # Точка входа приложения
├── screens/               # UI экраны
│   ├── home_screen.dart
│   └── screens.dart
├── bloc/                  # Управление состоянием (BLoC)
│   ├── file_bloc.dart
│   ├── file_event.dart
│   ├── file_state.dart
│   └── bloc.dart
├── services/              # Сервисы для работы с нативным кодом
│   ├── native_channel_service.dart
│   └── services.dart
├── constants/             # Константы приложения
│   ├── app_constants.dart
│   └── constants.dart
└── styles/                # Стили UI
    ├── app_styles.dart
    └── styles.dart

ios/Runner/
├── AppDelegate.swift              # Настройка MethodChannel
├── Services/
│   └── FileService.swift          # Сервис работы с файлами
├── Constants/
│   ├── NativeChannelConstants.swift
│   └── FileConstants.swift
└── file_writer.cpp                # C++ библиотека для записи в файл
```

## Технологии

- **Flutter** - кроссплатформенный фреймворк
- **BLoC** - управление состоянием
- **MethodChannel** - связь Flutter ↔ Swift
- **Swift** - нативный iOS код
- **C++** - низкоуровневая библиотека для работы с файлами

## Требования

- Flutter SDK >= 3.9.0
- Dart SDK >= 3.9.0
- Xcode (для iOS разработки)
- macOS (для сборки iOS приложения)

## Установка

1. Клонируйте репозиторий:
```bash
git clone <repository-url>
cd test_ios_flutter
```

2. Установите зависимости:
```bash
flutter pub get
```

3. Для iOS:
```bash
cd ios
pod install
cd ..
```

## Запуск

### iOS (симулятор или устройство):
```bash
flutter run
```

### Выбор конкретного устройства:
```bash
flutter devices
flutter run -d <device-id>
```

## Структура проекта

### Flutter слой

- **Screens** - UI компоненты
- **BLoC** - бизнес-логика и управление состоянием
- **Services** - взаимодействие с нативным кодом
- **Constants** - все строковые константы централизованы

### iOS слой

- **AppDelegate** - инициализация MethodChannel
- **FileService** - абстракция для работы с файлами
- **Constants** - константы для нативного кода
- **C++ библиотека** - низкоуровневая запись в файл

## Как это работает

1. Пользователь нажимает кнопку в Flutter UI
2. BLoC обрабатывает событие `FileIncrementAndWriteRequested`
3. `NativeChannelService` вызывает метод через MethodChannel
4. Swift код в `AppDelegate` получает запрос
5. `FileService` вызывает C++ функцию `write_to_file()`
6. C++ библиотека записывает строку в файл `output.txt`
7. Swift читает обновлённое содержимое файла
8. Данные возвращаются в Flutter через MethodChannel
9. BLoC обновляет состояние
10. UI автоматически обновляется через BlocBuilder

## Файлы

Приложение создаёт файл `output.txt` в директории документов iOS приложения. Файл содержит строки вида:
```
hello world 1
hello world 2
hello world 3
...
```

## Разработка

### Добавление новых методов

1. Добавьте метод в `NativeChannelConstants.Method`
2. Добавьте обработчик в `AppDelegate.handleMethodCall()`
3. Создайте соответствующий метод в `NativeChannelService`
4. Добавьте событие в BLoC при необходимости

### Изменение стилей

Все стили находятся в `lib/styles/app_styles.dart`. Константы размеров и отступов - в `lib/constants/app_constants.dart`.

## Лицензия

Этот проект лицензирован под MIT License - см. файл [LICENSE](LICENSE) для деталей.

## Автор

Создано как демонстрационный проект для изучения интеграции Flutter с нативным iOS кодом.
