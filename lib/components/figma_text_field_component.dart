import 'package:flutter/material.dart';
import 'package:morphr/components/figma_component.dart';
import 'package:morphr/figma_service.dart';
import 'package:morphr/renderers/figma_text_field_renderer.dart';

typedef FigmaTextFieldComponentParams = (
  String componentName, {
  TextEditingController? controller,
  ValueChanged<String>? onChanged,
  ValueChanged<String>? onSubmitted,
  String? hint,
});

class FigmaTextFieldComponent extends FigmaComponent {
  final FigmaTextFieldComponentParams params;

  const FigmaTextFieldComponent(
    this.params, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final componentName = params.$1;
    final node = FigmaService.instance.getComponent(componentName);
    if (node == null) return const SizedBox.shrink();

    return FigmaTextFieldRenderer().render(
      node,
      controller: params.controller,
      onChanged: params.onChanged,
      onSubmitted: params.onSubmitted,
      hint: params.hint,
    );
  }
}
