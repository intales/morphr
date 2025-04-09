// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:morphr/components/figma_container_component.dart';
import 'package:morphr/components/figma_list_component.dart';
import 'package:morphr/components/figma_flex_component.dart';
import 'package:morphr/components/figma_text_component.dart';
import 'package:morphr/components/figma_text_field_component.dart';
import 'package:morphr/components/figma_button_component.dart';
import 'package:morphr/components/figma_icon_component.dart';
import 'package:morphr/components/figma_bottombar_component.dart';
import 'package:morphr/components/figma_appbar_component.dart';
import 'package:morphr/components/figma_tree_component.dart';
import 'package:morphr/components/figma_scaffold_component.dart';
import 'package:morphr/transformers/core/node_transformer.dart';

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

  static PreferredSizeWidget appBar(
    final String componentName, {
    required final BuildContext context,
    required final List<Widget> children,
  }) =>
      FigmaAppbarComponent(componentName, context: context, children: children);

  const factory FigmaComponent.bottomBar(
    final String componentName, {
    required final List<Widget> children,
  }) = FigmaBottombarComponent;

  const factory FigmaComponent.text(
    final String componentName, {
    required final String text,
  }) = FigmaTextComponent;

  const factory FigmaComponent.icon(final String componentName) =
      FigmaIconComponent;

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

  const factory FigmaComponent.list(
    final String componentName, {
    required final int itemCount,
    required final IndexedWidgetBuilder itemBuilder,
    required final Axis scrollDirection,
  }) = FigmaListComponent;

  const factory FigmaComponent.tree(
    final String componentName, {
    final List<NodeTransformer> transformers,
  }) = FigmaTreeComponent;

  const factory FigmaComponent.scaffold(
    final String screenNodeName, {
    String appBarNodeName,
    String bodyNodeName,
    String bottomBarNodeName,
    String floatingActionButtonNodeName,
    final List<NodeTransformer> appBarTransformers,
    final List<NodeTransformer> bodyTransformers,
    final List<NodeTransformer> bottomBarTransformers,
    final List<NodeTransformer> fabTransformers,
    Color? backgroundColor,
    FloatingActionButtonLocation? floatingActionButtonLocation,
  }) = FigmaScaffoldComponent;
}
