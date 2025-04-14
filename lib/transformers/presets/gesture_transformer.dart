// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:morphr/transformers/core/transformers_core.dart';

/// A transformer that makes a Figma node respond to various gestures.
class GestureTransformer extends NodeTransformer {
  /// Creates a transformer that adds various gestures to a Figma node.
  ///
  /// The [selector] determines which nodes to make interactive.
  /// Various gesture callbacks can be provided.
  GestureTransformer({
    required super.selector,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    VoidCallback? onDoubleTap,
    super.childTransformers = const [],
  }) : super(
         transform:
             (context, widget) => Material(
               color: Colors.transparent,
               child: InkWell(
                 onTap: onTap,
                 onLongPress: onLongPress,
                 onDoubleTap: onDoubleTap,
                 child: widget,
               ),
             ),
       );

  /// Factory method to create a gesture transformer for nodes with a specific name.
  factory GestureTransformer.byName(
    String name, {
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    VoidCallback? onDoubleTap,
    List<NodeTransformer> childTransformers = const [],
    bool exact = true,
  }) {
    return GestureTransformer(
      selector: NameSelector(name, exact: exact),
      onTap: onTap,
      onLongPress: onLongPress,
      onDoubleTap: onDoubleTap,
      childTransformers: childTransformers,
    );
  }
}
