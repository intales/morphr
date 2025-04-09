// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:morphr/components/figma_appbar_component.dart';
import 'package:morphr/components/figma_bottombar_component.dart';
import 'package:morphr/components/figma_component.dart';
import 'package:morphr/morphr_service.dart';
import 'package:morphr/renderers/figma_tree_renderer.dart';
import 'package:morphr/transformers/core/node_transformer.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

/// A component that renders a Figma design as a Flutter Scaffold.
///
/// This component handles the correct placement of special UI elements like
/// AppBar, BottomNavigationBar, and FloatingActionButton into the appropriate
/// positions within a Scaffold, while rendering the remaining content as the body.
class FigmaScaffoldComponent extends FigmaComponent {
  /// The name of the node in Figma that contains the entire screen.
  final String screenNodeName;

  /// The name of the node in Figma that should be rendered as an AppBar.
  final String? appBarNodeName;

  /// The name of the node in Figma that should be rendered as the main content.
  final String? bodyNodeName;

  /// The name of the node in Figma that should be rendered as a BottomNavigationBar.
  final String? bottomBarNodeName;

  /// The name of the node in Figma that should be rendered as a FloatingActionButton.
  final String? floatingActionButtonNodeName;

  /// Transformers to apply to the AppBar node.
  final List<NodeTransformer> appBarTransformers;

  /// Transformers to apply to the body node.
  final List<NodeTransformer> bodyTransformers;

  /// Transformers to apply to the bottom bar node.
  final List<NodeTransformer> bottomBarTransformers;

  /// Transformers to apply to the floating action button node.
  final List<NodeTransformer> fabTransformers;

  /// Background color for the Scaffold.
  final Color? backgroundColor;

  /// FloatingActionButton position.
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// Creates a FigmaScaffoldComponent.
  ///
  /// The [screenNodeName] is required and represents the name of the container
  /// node in Figma that holds the entire screen design.
  ///
  /// Other named parameters allow specifying which nodes should be treated
  /// as special parts of the Scaffold, and what transformers to apply to each.
  const FigmaScaffoldComponent(
    this.screenNodeName, {
    this.appBarNodeName,
    this.bodyNodeName,
    this.bottomBarNodeName,
    this.floatingActionButtonNodeName,
    this.appBarTransformers = const [],
    this.bodyTransformers = const [],
    this.bottomBarTransformers = const [],
    this.fabTransformers = const [],
    this.backgroundColor,
    this.floatingActionButtonLocation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // If bodyNodeName is not provided, we use the screen node as the body
    final effectiveBodyNodeName = bodyNodeName ?? screenNodeName;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(context),
      body: FigmaComponent.tree(
        effectiveBodyNodeName,
        transformers: bodyTransformers,
      ),
      bottomNavigationBar: _buildBottomBar(context),
      floatingActionButton: _buildFloatingActionButton(context),
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    if (appBarNodeName == null) return null;

    // First, render the original children using tree renderer
    final figmaNode = MorphrService.instance.getComponent(appBarNodeName!);
    if (figmaNode == null) return null;

    // Get child nodes from the app bar
    final List<Widget> appBarChildren = [];

    if (figmaNode is figma.Frame && figmaNode.children != null) {
      // Render each child node using tree renderer with the app bar transformers
      for (final childNode in figmaNode.children!) {
        if (childNode == null) continue;

        appBarChildren.add(
          const FigmaTreeRenderer().render(
            node: childNode,
            context: context,
            transformers: appBarTransformers,
            parent: figmaNode,
          ),
        );
      }
    } else if (figmaNode is figma.Instance && figmaNode.children != null) {
      // Same for instances
      for (final childNode in figmaNode.children!) {
        if (childNode == null) continue;

        appBarChildren.add(
          const FigmaTreeRenderer().render(
            node: childNode,
            context: context,
            transformers: appBarTransformers,
            parent: figmaNode,
          ),
        );
      }
    }

    return FigmaAppbarComponent(
      appBarNodeName!,
      context: context,
      children: appBarChildren,
    );
  }

  Widget? _buildBottomBar(BuildContext context) {
    if (bottomBarNodeName == null) return null;

    // First, render the original children using tree renderer
    final figmaNode = MorphrService.instance.getComponent(bottomBarNodeName!);
    if (figmaNode == null) return null;

    // Get child nodes from the bottom bar
    final List<Widget> bottomBarChildren = [];

    if (figmaNode is figma.Frame && figmaNode.children != null) {
      // Render each child node using tree renderer with the bottom bar transformers
      for (final childNode in figmaNode.children!) {
        if (childNode == null) continue;

        bottomBarChildren.add(
          const FigmaTreeRenderer().render(
            node: childNode,
            context: context,
            transformers: bottomBarTransformers,
            parent: figmaNode,
          ),
        );
      }
    } else if (figmaNode is figma.Instance && figmaNode.children != null) {
      // Same for instances
      for (final childNode in figmaNode.children!) {
        if (childNode == null) continue;

        bottomBarChildren.add(
          const FigmaTreeRenderer().render(
            node: childNode,
            context: context,
            transformers: bottomBarTransformers,
            parent: figmaNode,
          ),
        );
      }
    }

    return FigmaBottombarComponent(
      bottomBarNodeName!,
      children: bottomBarChildren,
    );
  }

  Widget? _buildFloatingActionButton(BuildContext context) {
    if (floatingActionButtonNodeName == null) return null;

    return FigmaComponent.tree(
      floatingActionButtonNodeName!,
      transformers: fabTransformers,
    );
  }
}
