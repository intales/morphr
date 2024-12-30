import 'package:flutter/widgets.dart';
import 'package:morphr/figma_container_component.dart';
import 'package:morphr/figma_flex_component.dart';
import 'package:morphr/figma_text_component.dart';

abstract class FigmaComponent extends StatelessWidget {
  const FigmaComponent({super.key});

  static Widget container(
    final String componentName, {
    final Widget? child,
  }) =>
      FigmaContainerComponent(
        componentName,
        child: child,
      );

  static Widget column(
    final String componentName, {
    required final List<Widget> children,
  }) =>
      FigmaFlexComponent(
        componentName,
        children: children,
      );

  static Widget row(
    final String componentName, {
    required final List<Widget> children,
  }) =>
      FigmaFlexComponent(
        componentName,
        children: children,
      );

  static Widget text(
    final String componentName, {
    required final String text,
  }) =>
      FigmaTextComponent(
        componentName,
        text: text,
      );
}
