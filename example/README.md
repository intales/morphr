# Morphr Todo Example

A Flutter application showcasing how to use the Morphr library to render a Figma-designed todo app.

## Overview

This example demonstrates:
- Integration with Figma components
- Navigation bar handling
- List rendering
- Interactive elements (buttons, checkboxes)
- Nested layouts

## Project Structure

```
assets/
  figma_document.json  # Exported Figma design
lib/
  main.dart           # Main application code
```

## Key Components

### 1. Application Setup
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FigmaService.instance.initialize(
    documentPath: 'assets/figma_document.json',
  );

  runApp(const FigmaTestApp());
}
```

### 2. Navigation Components
```dart
// AppBar with title and add button
appBar: FigmaComponent.appBar(
  "app_bar",
  context: context,
  children: [
    const FigmaComponent.text("app_bar_title", text: "Todo App"),
    FigmaComponent.button("app_bar_add_todo_button", onPressed: () {}),
  ],
),

// Bottom navigation bar
bottomNavigationBar: const FigmaComponent.bottomBar(
  "bottom_bar",
  children: [
    Icon(Icons.home),
    Icon(Icons.task_rounded),
    Icon(Icons.add_task_outlined),
  ],
),
```

### 3. Dynamic List Rendering
```dart
FigmaComponent.list(
  "todos_list",
  itemCount: todos.length,
  itemBuilder: (context, index) {
    final todo = todos[index];
    return FigmaComponent.row(
      "todo_frame",
      children: [
        // Todo item structure
      ],
    );
  },
  scrollDirection: Axis.vertical,
),
```

### 4. Nested Layouts
```dart
FigmaComponent.row(
  "todo_frame",
  children: [
    FigmaComponent.button(
      "todo_checkbox${todo.done ? "_done" : ""}",
      onPressed: () {},
    ),
    FigmaComponent.column(
      "todo_frame_content",
      children: [
        FigmaComponent.text("todo_title", text: todo.title),
        FigmaComponent.text("todo_description", text: todo.description),
      ],
    ),
  ],
),
```

## Required Figma Components

The following components must be defined in your Figma file:
- `app_bar`: Application top bar
- `app_bar_title`: Title text component
- `app_bar_add_todo_button`: Add button
- `bottom_bar`: Bottom navigation bar
- `todo_frame`: Todo item container
- `todo_checkbox`: Unchecked state
- `todo_checkbox_done`: Checked state
- `todo_frame_content`: Content container
- `todo_title`: Title text style
- `todo_description`: Description text style

## Running the Example

1. Download your Figma design:
```bash
morphr download
```

2. Place the JSON file in `assets/figma_document.json`

3. Run the app:
```bash
flutter run
```

## Points of Interest

1. **Component Reuse**: The todo items demonstrate how to reuse Figma components effectively

2. **Dynamic States**: The checkbox shows how to handle different states (`done` vs unchecked)

3. **Layout Composition**: Shows how to compose complex layouts using Morphr components

4. **Performance**: The list demonstrates Morphr's performance with large datasets (300 items)

## Notes

- Make sure your Figma components match the IDs used in the code
- The example uses Roboto Mono font, but you can change this in the `ThemeData`
- Components like the add button need implementation of their `onPressed` handlers
