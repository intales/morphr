import 'package:flutter/widgets.dart';
import 'package:morphr/components/figma_container_component.dart';
import 'package:morphr/components/figma_flex_component.dart';
import 'package:morphr/components/figma_text_component.dart';
import 'package:morphr/components/figma_text_field_component.dart';
import 'package:morphr/components/figma_button_component.dart';

abstract class FigmaComponent extends StatelessWidget {
  const FigmaComponent({super.key});

  const factory FigmaComponent.container(
    final String componentName, {
    final Widget? child,
  }) = FigmaContainerComponent;

  const factory FigmaComponent.column(
    final String componentName, {
    required final List<Widget> children,
  }) = FigmaFlexComponent;

  const factory FigmaComponent.row(
    final String componentName, {
    required final List<Widget> children,
  }) = FigmaFlexComponent;

  const factory FigmaComponent.text(
    final String componentName, {
    required final String text,
  }) = FigmaTextComponent;

  const factory FigmaComponent.button(
    final String componentName, {
    required final VoidCallback onPressed,
    final Widget? child,
  }) = FigmaButtonComponent;

  const factory FigmaComponent.textField(
    final String componentName, {
    final TextEditingController? controller,
    final ValueChanged<String>? onChanged,
    final ValueChanged<String>? onSubmitted,
    final String? hint,
  }) = FigmaTextFieldComponent;
}
