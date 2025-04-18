# Changelog

All notable changes to the Morphr package will be documented in this file.

## 0.2.1 - 2025-04-14
- Fixed docs link inside readme

## 0.2.0 - 2025-04-14
- New recursive rendering system with transformers pattern

## 0.1.1 - 2025-04-03
- Migrated to `morphr_figma`

## 0.1.0 - 2025-04-02

### Added
- Initial release of Morphr
- Morphr CLI for account management and Figma synchronization
- Morphr Cloud integration for real-time design updates
- Basic set of Figma components for Flutter:
  - `FigmaComponent.container`
  - `FigmaComponent.text`
  - `FigmaComponent.button`
  - `FigmaComponent.column`
  - `FigmaComponent.row`
  - `FigmaComponent.appBar`
  - `FigmaComponent.bottomBar`
  - `FigmaComponent.list`
  - `FigmaComponent.textField`
  - `FigmaComponent.icon`
- Automatic safe area handling for navigation components
- Layout adapters for Figma's auto-layout
- Vector rendering for Figma vector nodes
- Decoration adapters for Figma visual effects
- CLI commands:
  - `register`: Create a Morphr account
  - `verify`: Verify your account with email code
  - `figma-connect`: Connect your Figma account
  - `init`: Initialize a Flutter project with Morphr
  - `sync`: Synchronize with the latest Figma design

### Developer Notes
- This is the initial beta release
- Feedback and bug reports are highly appreciated
- Some advanced Figma features might require refinement
