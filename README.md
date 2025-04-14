# Morphr

A bridge between Figma and Flutter that transforms your Figma designs into pixel-perfect Flutter widgets with real-time updates.

## Overview

Morphr eliminates the gap between design and development, allowing designers and developers to work in parallel while keeping your app's UI perfectly aligned with your design system.

## Features

- **High-Fidelity Rendering**: Preserves all visual details from your Figma designs
- **Zero-Config Setup**: Transform designs to code without complex configuration
- **Full Control**: Maintain complete control over layout and logic in your Flutter code
- **Type-Safe Overrides**: Override component properties with type-checking
- **Over-the-Air Updates**: Sync your app's UI without redeploying your app
- **Native Performance**: Uses Flutter's layout system for optimal performance

## Installation

### CLI

Install the Morphr CLI:

```bash
dart pub global activate morphr
```

### Flutter Library

Add Morphr to your `pubspec.yaml`:

```yaml
dependencies:
  morphr: ^0.1.0
```

Then run:

```bash
flutter pub get
```

## Quick Start

### 1. Register and Connect

Register a Morphr account and connect it to Figma:

```bash
morphr register
morphr verify
morphr figma-connect
```

### 2. Initialize Your Project

Initialize Morphr in your Flutter project:

```bash
cd your_flutter_project
morphr init
```

### 3. Sync Your Design

Whenever your Figma design changes:

```bash
morphr sync
```

### 4. Use Components in Flutter

Update your `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:morphr/morphr.dart';
import 'package:your_app/morphr_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Morphr with your configuration
  await MorphrService.instance.initializeCloud(options: morphrOptions);
  
  runApp(MyApp());
}
```

Use Figma components in your widgets:

```dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FigmaComponent.appBar(
        "my_app_bar",
        context: context,
        children: [
          FigmaComponent.text("app_title", text: "My App"),
        ],
      ),
      body: FigmaComponent.container(
        "home_screen",
        child: FigmaComponent.column(
          "content_column",
          children: [
            FigmaComponent.text("welcome_text", text: "Welcome!"),
            FigmaComponent.button(
              "action_button",
              onPressed: () => print("Button pressed"),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Available Components

- `FigmaComponent.container`: For frames and shapes
- `FigmaComponent.text`: For text elements
- `FigmaComponent.button`: For interactive buttons
- `FigmaComponent.column`: For vertical auto-layout
- `FigmaComponent.row`: For horizontal auto-layout
- `FigmaComponent.appBar`: For top navigation bars
- `FigmaComponent.bottomBar`: For bottom navigation bars
- `FigmaComponent.list`: For scrollable lists
- `FigmaComponent.textField`: For input fields
- `FigmaComponent.icon`: For vector graphics

## Documentation

For complete documentation, go [here](https://docs.page/intales/morphr).

## Examples

Check out our [example app](https://github.com/intales/morphr/tree/main/example) to see Morphr in action.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
