import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/adapters/figma_text_adapter.dart';
import 'package:morphr/archetypes/widget_archetype.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

mixin ButtonCapability {
  Capability get isButton => (Widget widget) {
    return widget is ElevatedButton ||
        widget is TextButton ||
        widget is OutlinedButton ||
        widget is IconButton ||
        widget is FloatingActionButton;
  };

  ButtonStyle extractButtonStyle(figma.Node node) {
    final figmaDecoration = FigmaDecorationAdapter(node);

    return ButtonStyle(
      backgroundColor: _getMaterialStateProperty(
        figmaDecoration.createBoxDecoration().color,
      ),
      foregroundColor: _getMaterialStateProperty(_extractTextColor(node)),
      overlayColor: _getMaterialStateProperty(
        figmaDecoration.createBoxDecoration().color?.withValues(alpha: 0.1),
      ),
      shadowColor: _getMaterialStateProperty(
        _extractShadowColor(figmaDecoration),
      ),
      elevation: _getMaterialStateProperty(_extractElevation(figmaDecoration)),
      padding: _getMaterialStateProperty(_extractPadding(node)),
      shape: _getMaterialStateProperty(_extractShapeBorder(figmaDecoration)),
    );
  }

  Color? _extractTextColor(figma.Node node) {
    final figmaText = FigmaTextAdapter(node);
    if (figmaText.supportsText) {
      final textStyle = figmaText.createTextStyle();
      return textStyle?.color;
    }
    return null;
  }

  Color? _extractShadowColor(FigmaDecorationAdapter decorationAdapter) {
    final decoration = decorationAdapter.createBoxDecoration();
    final shadows = decoration.boxShadow;
    if (shadows != null && shadows.isNotEmpty) {
      return shadows.first.color;
    }
    return null;
  }

  double? _extractElevation(FigmaDecorationAdapter decorationAdapter) {
    final decoration = decorationAdapter.createBoxDecoration();
    final shadows = decoration.boxShadow;
    if (shadows != null && shadows.isNotEmpty) {
      return shadows.first.blurRadius;
    }
    return null;
  }

  EdgeInsets? _extractPadding(figma.Node node) {
    if (node is figma.Frame) {
      return EdgeInsets.fromLTRB(
        node.paddingLeft.toDouble(),
        node.paddingTop.toDouble(),
        node.paddingRight.toDouble(),
        node.paddingBottom.toDouble(),
      );
    }
    if (node is figma.Instance) {
      return EdgeInsets.fromLTRB(
        node.paddingLeft.toDouble(),
        node.paddingTop.toDouble(),
        node.paddingRight.toDouble(),
        node.paddingBottom.toDouble(),
      );
    }
    return null;
  }

  OutlinedBorder? _extractShapeBorder(
    FigmaDecorationAdapter decorationAdapter,
  ) {
    final decoration = decorationAdapter.createBoxDecoration();

    if (decoration.shape == BoxShape.circle) {
      return const CircleBorder();
    }

    if (decoration.borderRadius != null) {
      final borderRadius = decoration.borderRadius as BorderRadius?;
      return RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.zero,
        side: _createBorderSide(decoration),
      );
    }

    return RoundedRectangleBorder(side: _createBorderSide(decoration));
  }

  BorderSide _createBorderSide(BoxDecoration decoration) {
    if (decoration.border == null) {
      return BorderSide.none;
    }

    return BorderSide(
      color: decoration.border?.top.color ?? Colors.transparent,
      width: decoration.border?.top.width ?? 0,
      style: decoration.border?.top.style ?? BorderStyle.none,
    );
  }

  WidgetStatePropertyAll<T>? _getMaterialStateProperty<T>(T? value) {
    if (value == null) return null;
    return WidgetStatePropertyAll<T>(value);
  }

  Widget buildFromElevatedButton(ElevatedButton button, figma.Node node) {
    final style = extractButtonStyle(node);

    return ElevatedButton(
      key: button.key,
      onPressed: button.onPressed,
      onLongPress: button.onLongPress,
      onHover: button.onHover,
      onFocusChange: button.onFocusChange,
      style: style.merge(button.style),
      focusNode: button.focusNode,
      autofocus: button.autofocus,
      clipBehavior: button.clipBehavior,
      child: DefaultTextStyle(style: TextStyle(), child: button.child!),
    );
  }

  Widget buildFromTextButton(TextButton button, figma.Node node) {
    final style = extractButtonStyle(node);
    if (button.child == null) return button;

    return TextButton(
      key: button.key,
      onPressed: button.onPressed,
      onLongPress: button.onLongPress,
      onHover: button.onHover,
      onFocusChange: button.onFocusChange,
      style: style.merge(button.style),
      focusNode: button.focusNode,
      autofocus: button.autofocus,
      clipBehavior: button.clipBehavior,
      child: button.child!,
    );
  }

  Widget buildFromOutlinedButton(OutlinedButton button, figma.Node node) {
    final style = extractButtonStyle(node);

    return OutlinedButton(
      key: button.key,
      onPressed: button.onPressed,
      onLongPress: button.onLongPress,
      onHover: button.onHover,
      onFocusChange: button.onFocusChange,
      style: style.merge(button.style),
      focusNode: button.focusNode,
      autofocus: button.autofocus,
      clipBehavior: button.clipBehavior,
      child: DefaultTextStyle(style: TextStyle(), child: button.child!),
    );
  }

  Widget buildFromIconButton(IconButton button, figma.Node node) {
    final figmaDecoration = FigmaDecorationAdapter(node);
    final color = figmaDecoration.createBoxDecoration().color;
    final iconColor = _extractTextColor(node);

    return IconButton(
      key: button.key,
      iconSize: button.iconSize,
      padding: _extractPadding(node) ?? button.padding,
      alignment: button.alignment,
      color: iconColor ?? button.color,
      splashColor: color?.withValues(alpha: 0.3) ?? button.splashColor,
      highlightColor: color?.withValues(alpha: 0.1) ?? button.highlightColor,
      onPressed: button.onPressed,
      focusNode: button.focusNode,
      autofocus: button.autofocus,
      tooltip: button.tooltip,
      enableFeedback: button.enableFeedback,
      constraints: button.constraints,
      icon: DefaultTextStyle(style: TextStyle(), child: button.icon),
    );
  }

  Widget buildFromFloatingActionButton(
    FloatingActionButton button,
    figma.Node node,
  ) {
    final figmaDecoration = FigmaDecorationAdapter(node);
    final backgroundColor = figmaDecoration.createBoxDecoration().color;
    final foregroundColor = _extractTextColor(node);

    return FloatingActionButton(
      key: button.key,
      tooltip: button.tooltip,
      foregroundColor: foregroundColor ?? button.foregroundColor,
      backgroundColor: backgroundColor ?? button.backgroundColor,
      focusColor: button.focusColor,
      hoverColor: button.hoverColor,
      splashColor: button.splashColor,
      heroTag: button.heroTag,
      elevation: _extractElevation(figmaDecoration) ?? button.elevation,
      focusElevation: button.focusElevation,
      hoverElevation: button.hoverElevation,
      highlightElevation: button.highlightElevation,
      disabledElevation: button.disabledElevation,
      onPressed: button.onPressed,
      mini: button.mini,
      shape: _extractShapeBorder(figmaDecoration) ?? button.shape,
      clipBehavior: button.clipBehavior,
      autofocus: button.autofocus,
      materialTapTargetSize: button.materialTapTargetSize,
      isExtended: button.isExtended,
      enableFeedback: button.enableFeedback,
      child: DefaultTextStyle(style: TextStyle(), child: button.child!),
    );
  }
}
