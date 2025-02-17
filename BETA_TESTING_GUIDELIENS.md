# Beta Testing Guidelines

Thank you for helping test the Morphr rendering engine. Your expertise will be invaluable in validating and improving the library.

## Focus Areas

We're primarily focused on testing the rendering engine. Specifically:

### 1. Layout Fidelity
- How closely does the Flutter output match the Figma design?
- Are there any issues with:
  - Auto-layout behavior
  - Component spacing
  - Alignment and positioning
  - Nested layouts

### 2. Navigation Elements
- AppBar behavior with different status bar configurations
- BottomBar interaction with system UI
- Safe area handling across different devices

### 3. Performance
- Scrolling performance with long lists
- Vector rendering performance
- Memory usage with complex layouts

### 4. API Ergonomics
- Is the component API intuitive?
- Are there common use cases that are difficult to implement?
- Could certain patterns be simplified?

## How to Report Issues

When you encounter issues, please include:

1. For Layout Issues:
   - Screenshot of Figma design
   - Screenshot of Flutter output
   - Device/simulator specifications
   - Relevant component code

2. For Performance Issues:
   - Description of the scenario
   - Number of components rendered
   - Device specifications
   - Performance metrics if available

3. For API Suggestions:
   - Current implementation
   - Proposed alternative
   - Use case explanation

## Not in Scope (Yet)

The following areas are not part of this beta test:
- State management integration
- Data binding
- Animation
- Navigation logic
- Backend integration

## Communication

Please use GitHub issues for:
- Bug reports
- Performance concerns
- API suggestions

Use the following labels:
- `rendering`: Visual output issues
- `performance`: Performance-related issues
- `api`: API design suggestions
- `navigation`: AppBar/BottomBar issues

## Examples to Try

1. Complex Layouts:
   - Deeply nested auto-layout components
   - Grid-like structures
   - Responsive layouts

2. Performance Tests:
   - Lists with 300+ items
   - Components with multiple vectors
   - Deeply nested component trees

3. Navigation Scenarios:
   - Different status bar colors
   - Transparent navigation bars
   - Landscape orientation

## Success Criteria

The beta will help validate:
1. Layout engine reliability
2. Performance with real-world components
3. API usability in production scenarios
4. Navigation bar implementation robustness
