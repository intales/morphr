import 'package:flutter/material.dart';
import 'package:morphr/components/figma_component.dart';
import 'package:morphr/figma_service.dart';
import 'package:morphr/renderers/figma_text_field_renderer.dart';

class FigmaTextFieldComponent extends FigmaComponent {
  final String componentName;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? hint;

  const FigmaTextFieldComponent(
    this.componentName, {
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.hint,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final node = FigmaService.instance.getComponent(componentName);
    if (node == null) return const SizedBox.shrink();

    return FigmaTextFieldRenderer().render(
      node,
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      hint: hint,
    );
  }
}
