// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:figma/figma.dart' as figma;
import 'package:morphr/adapters/figma_constraints_adapter.dart';
import 'package:morphr/adapters/figma_text_adapter.dart';

class FigmaTextFieldRenderer {
  const FigmaTextFieldRenderer();

  Widget render(
    figma.Node node,
    Size parentSize, {
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    String? hint,
  }) {
    final textAdapter = FigmaTextAdapter(node);
    final constraintsAdapter = FigmaConstraintsAdapter(node, parentSize);

    textAdapter.validateText();

    Widget textField = TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      style: textAdapter.createTextStyle(),
      textAlign: textAdapter.getTextAlign(),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: textAdapter.createTextStyle()?.copyWith(
              color:
                  textAdapter.createTextStyle()?.color?.withValues(alpha: 0.5),
            ),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        isDense: true,
        isCollapsed: true,
      ),
    );

    return constraintsAdapter.applyConstraints(textField);
  }
}
