import 'package:flutter/widgets.dart';
import 'package:morphr/components/figma_container_component.dart';
import 'package:morphr/components/figma_flex_component.dart';
import 'package:morphr/components/figma_text_component.dart';
import 'package:morphr/components/figma_text_field_component.dart';

abstract class FigmaComponent extends StatelessWidget {
  const FigmaComponent({super.key});

  const factory FigmaComponent.container(
    final FigmaContainerComponentParams params, {
    final Key? key,
  }) = FigmaContainerComponent;

  const factory FigmaComponent.column(
    final FigmaFlexComponentParams params, {
    final Key? key,
  }) = FigmaFlexComponent;

  const factory FigmaComponent.row(
    final FigmaFlexComponentParams params, {
    final Key? key,
  }) = FigmaFlexComponent;

  const factory FigmaComponent.text(
    final FigmaTextComponentParams params, {
    final Key? key,
  }) = FigmaTextComponent;

  const factory FigmaComponent.textField(
    final FigmaTextFieldComponentParams params, {
    final Key? key,
  }) = FigmaTextFieldComponent;
}
