import 'package:flutter/material.dart';
import 'package:figma/figma.dart' as figma;
import 'package:morphr/adapters/figma_text_adapter.dart';

class FigmaTextFieldRenderer {
  const FigmaTextFieldRenderer();

  Widget render(
    figma.Node node, {
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    String? hint,
  }) {
    final textAdapter = FigmaTextAdapter(node);

    textAdapter.validateText();

    final baseStyle = textAdapter.createTextStyle();
    final placeholderStyle = baseStyle?.copyWith(
      color: baseStyle.color?.withOpacity(0.5),
    );

    final textField = TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      style: baseStyle,
      textAlign: textAdapter.getTextAlign(),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: placeholderStyle,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        isDense: true,
        isCollapsed: true,
      ),
    );

    return textField;
  }
}
