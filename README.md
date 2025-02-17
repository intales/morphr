# Morphr

A Flutter library for rendering Figma designs at runtime with high fidelity. This is the rendering engine that powers the Morphr synchronization service.

## Architecture

Morphr uses a three-layer architecture to convert Figma nodes into Flutter widgets:

### 1. Adapters
Adapters abstract Figma node properties and convert them into Flutter-friendly formats. Each adapter handles a specific aspect:

- `FigmaShapeAdapter`: Handles shape properties (fills, strokes, corners)
- `FigmaTextAdapter`: Manages text properties and styles
- `FigmaLayoutAdapter`: Converts Figma auto-layout to Flutter layout
- `FigmaBarAdapter`: Specializes in navigation bars adaptation
- `FigmaVectorAdapter`: Handles vector nodes and paths
- `FigmaDecorationAdapter`: Manages visual properties and effects

### 2. Renderers
Renderers use adapters to create actual Flutter widgets:

- `FigmaShapeRenderer`: Renders rectangles, ellipses, and frames
- `FigmaTextRenderer`: Renders text nodes with proper styling
- `FigmaFlexRenderer`: Handles auto-layout containers
- `FigmaVectorRenderer`: Renders vector graphics
- `FigmaAppbarRenderer` & `FigmaBottomBarRenderer`: Specialized navigation bar renderers

### 3. Components
High-level widgets that combine renderers and adapters into reusable pieces:

- `FigmaComponent`: Base class for all components
- `FigmaContainerComponent`: Renders frames and shapes
- `FigmaTextComponent`: Text rendering
- `FigmaButtonComponent`: Interactive buttons
- `FigmaListComponent`: Scrollable lists
- And more...

## CLI Installation

1. Activate the Morphr CLI:
```bash
dart pub global activate morphr_cli
```

2. Download a Figma file:
```bash
morphr download --token YOUR_FIGMA_TOKEN --file YOUR_FILE_ID --output design.json
```

Or use the interactive mode:
```bash
morphr download
```

The CLI will guide you through:
- Entering your Figma access token
- Specifying the file ID
- Choosing the output location

## Quick Start

1. Add Morphr to your pubspec.yaml:
```yaml
dependencies:
  morphr: ^0.1.0
```

2. Basic usage example:
```dart
// Create a text component
final text = FigmaComponent.text(
  'my_text_component',
  text: 'Hello World',
);

// Create a button
final button = FigmaComponent.button(
  'my_button_component',
  onPressed: () => print('Button pressed'),
);

// Create an auto-layout container
final container = FigmaComponent.column(
  'my_container',
  children: [text, button],
);
```

3. Using navigation bars:
```dart
// AppBar with safe area handling
final appBar = FigmaComponent.appBar(
  'app_bar_component',
  context: context,
  children: [/* your items */],
);

// Bottom bar
final bottomBar = FigmaComponent.bottomBar(
  'bottom_bar_component',
  children: [/* your items */],
);
```

## Key Features

- **High-fidelity rendering**: Preserves Figma design details including gradients, shadows, and effects
- **Native Flutter layout**: Uses Flutter's layout system for optimal performance
- **Safe area handling**: Proper handling of notches, status bars, and system UI
- **Vector support**: Renders Figma vectors as Flutter paths
- **Responsive**: Adapts to different screen sizes while maintaining design fidelity

## Known Limitations

1. Auto-layout:
   - Complex nested auto-layouts might need manual adjustment
   - Some Figma constraints behaviors might differ slightly

2. Text:
   - Custom fonts must be included in your Flutter project
   - Some advanced text decorations might not render exactly as in Figma

3. Effects:
   - Complex blend modes might have slight visual differences
   - Some advanced Figma effects might need simplification

## Looking for Feedback On

1. Layout behavior and constraints handling
2. Navigation bars integration with system UI
3. Vector rendering performance
4. Component API ergonomics

## License

MIT License - see [LICENSE](LICENSE) file for details

The synchronization service is a separate commercial product.
