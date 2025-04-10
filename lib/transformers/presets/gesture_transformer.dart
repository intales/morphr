// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:morphr/transformers/core/node_transformer.dart';

/// Creates a transformer that adds tap functionality to a Figma node.
///
/// This transformer wraps the original widget with a GestureDetector to handle
/// tap events while preserving the original appearance and behavior.
///
/// Example usage:
/// ```dart
/// FigmaComponent.tree(
///   "profile_screen",
///   transformers: [
///     onTap("logout_button", () => logoutUser()),
///     onTap("settings_icon", () => openSettings()),
///   ],
/// )
/// ```
NodeTransformer onTap(
  String nodeName,
  VoidCallback onTap, {
  List<NodeTransformer> childTransformers = const [],
  bool exact = true,
}) {
  return NodeTransformer.byName(
    nodeName,
    exact: exact,
    transformer: (context) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: context.defaultWidget,
      );
    },
    childTransformers: childTransformers,
  );
}

/// Creates a transformer that adds long press functionality to a Figma node.
///
/// This transformer wraps the original widget with a GestureDetector to handle
/// long press events while preserving the original appearance and behavior.
NodeTransformer onLongPress(
  String nodeName,
  VoidCallback onLongPress, {
  List<NodeTransformer> childTransformers = const [],
  bool exact = true,
}) {
  return NodeTransformer.byName(
    nodeName,
    exact: exact,
    transformer: (context) {
      return GestureDetector(
        onLongPress: onLongPress,
        behavior: HitTestBehavior.opaque,
        child: context.defaultWidget,
      );
    },
    childTransformers: childTransformers,
  );
}

/// Creates a transformer that adds multiple gesture capabilities to a Figma node.
///
/// This transformer allows adding multiple gesture recognizers to a single node,
/// such as tap, double tap, long press, etc.
NodeTransformer withGestures(
  String nodeName, {
  VoidCallback? onTap,
  VoidCallback? onLongPress,
  VoidCallback? onDoubleTap,
  GestureTapDownCallback? onTapDown,
  GestureTapUpCallback? onTapUp,
  GestureTapCancelCallback? onTapCancel,
  List<NodeTransformer> childTransformers = const [],
  bool exact = true,
}) {
  return NodeTransformer.byName(
    nodeName,
    exact: exact,
    transformer: (context) {
      return GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        onDoubleTap: onDoubleTap,
        onTapDown: onTapDown,
        onTapUp: onTapUp,
        onTapCancel: onTapCancel,
        behavior: HitTestBehavior.opaque,
        child: context.defaultWidget,
      );
    },
    childTransformers: childTransformers,
  );
}
