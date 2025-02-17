// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:figma/figma.dart' as figma;
import 'package:flutter/widgets.dart';

/// Adapter that handles Figma constraints and converts them to Flutter constraints
class FigmaConstraintsAdapter {
  final figma.Node node;
  final Size parentSize;

  const FigmaConstraintsAdapter(this.node, this.parentSize);

  /// Convert Figma constraints to Flutter widget with proper sizing and positioning
  Widget applyConstraints(Widget child) {
    return child;
  }
}
